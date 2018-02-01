sudo kprobe -d 30 p:ath_tx_complete | awk '{ print $4 }'
