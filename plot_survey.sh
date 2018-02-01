#!/usr/bin/bash

if [ -z "$1" ]; then
	echo "No device name supplied"
	exit 1
fi

dev=$1

old_ctime=0
old_cb=0
old_cr=0
old_ct=0
ct_offset=0

rm plot.dat;
printf "Time(s)\tBusy(%%)\tDwell(s)\n" >> plot.dat;
while true; do
	survey="$(iw dev $dev survey dump|grep -A 5 in\ use| sed 's/[^0-9]*//g')";
	freq=$(echo $survey | cut -f1 -d\ );
	noise_f=$(echo $survey | cut -f2 -d\ );
	channel_time=$(echo $survey | cut -f3 -d\ );
	if [ "$ct_offset" -eq "0" ]; then
		ct_offset=$channel_time;
	fi
	channel_busy=$(echo $survey | cut -f4 -d\ );
	channel_rx=$(echo $survey | cut -f5 -d\ );
	channel_tx=$(echo $survey | cut -f6 -d\ );
	printf "Frequency $freq\nNoise Floor $noise_f\n" #Channel Time $channel_time\nChannel Busy $channel_busy\nChannel Rx $channel_rx\nChannel Tx $channel_tx\n"
	busy=$(bc <<< "scale=3; 100*$channel_busy/$channel_time")
	tx=$(bc <<< "scale=3; 100*$channel_tx/$channel_time")
	rx=$(bc <<< "scale=3; 100*$channel_rx/$channel_time")
	dif_ctime=$(bc <<< "scale=3; $channel_time-$old_ctime")
	dif_cb=$(bc <<< "scale=3; $channel_busy-$old_cb")
	dif_cr=$(bc <<< "scale=3; $channel_rx-$old_cr")
	dif_ct=$(bc <<< "scale=3; $channel_tx-$old_ct")
	dif_busy=$(bc <<< "scale=3; 100*$dif_cb/$dif_ctime")
	dif_rx=$(bc <<< "scale=3; 100*$dif_cr/$dif_ctime")
	dif_tx=$(bc <<< "scale=3; 100*$dif_ct/$dif_ctime")


	old_ctime=$channel_time
	old_cb=$channel_busy
	old_cr=$channel_rx
	old_ct=$channel_tx

        printf "Channel Busy %%: $dif_busy%%\tMAC tx: $dif_tx%%\tMAC rx: $dif_rx%%\tdwell time: $dif_ctime ms\n"

	relative_time=$(bc <<< "scale=3;$channel_time-$ct_offset")
	echo $relative_time
	printf "$relative_time\t$dif_idle\t$dif_rx\t$dif_tx\t$dif_ctime\n" >> plot.dat
	
	sleep 0.01
done
