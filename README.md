**How-to**

1- Make sure to disable all networking done by linux (ubuntu):
<pre><code>sudo systemctl stop NetworkManager && sudo systemctl disable NetworkManager</code></pre>

2- Edit hostapd.conf to specify AP configuration, most importantly here the channel that will be used during the experiment (default channel=6) and the interface name
<pre><code>
ssid=hosttest
interface=wlp5s0
driver=nl80211
channel=6
hw_mode=g
auth_algs=1
wpa=3
wpa_passphrase=Somepassphrase
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
rsn_pairwise=CCMP
</code></pre>

3- run the hostapd daemon to create the access point + configure IP
<pre><code>
sudo hostapd hostapd.conf -B && sudo ifconfig INTERFACE_NAME 192.168.10.10 
</code></pre>
The output should be like
<pre><code>
$ sudo hostapd /etc/hostapd/hostapd.conf -B
Configuration file: /etc/hostapd/hostapd.conf
Using interface INTERFACE_NAME with hwaddr xx:xx:xx:xx:xx:xx and ssid "hosttest"
wlp5s0: interface state UNINITIALIZED->ENABLED
wlp5s0: AP-ENABLED
</code></pre>

4- Associate a client to this AP (a smart phone for instance) and run a flood ping from the AP to the Client )100,000 packets here)
<pre><code>
ping -f -c 100000 DESTINATION_IP
</code></pre>

5- Run the plot_survey.sh (you might need to <code>chmod +x plot_survey.sh</code>)
<pre><code>
sudo ./plot_survey.sh INTERFACE_NAME
</code></pre>

6- On a different terminal and in the same directory run <code>gnuplot plot.gnu</code> 
