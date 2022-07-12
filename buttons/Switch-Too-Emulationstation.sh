#!/bin/bash
AUTOSTART="/opt/retropie/configs/all/autostart.sh"

mode_check
echo "Front End Switcheroo Currently using $fe"
sleep 3 
if grep -q 'attract \#auto' "$AUTOSTART"; then
    sudo sed -i 's/attract \#auto/emulationstation \#auto/g' $AUTOSTART
    echo "EmulationStation Mode Set"
    sleep 2
    pgrep -f attract|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f emulationstation 2>&1
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    sudo sed -i 's/pegasus-fe \#auto/emulationstation \#auto/g' $AUTOSTART
    echo "EmulationStation Mode Set"
    sleep 2
    pgrep -f pegasus-fe|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f emulationstation 2>&1
elif grep -q 'startx \#auto' "$AUTOSTART"; then
    sudo sed -i 's/startx \#auto/emulationstation \#auto/g' $AUTOSTART
    echo "EmulationStation Mode Set"
    sleep 2
    pgrep -f startx|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f emulationstation 2>&1
elif grep -q 'emulationstation \#auto' "$AUTOSTART"; then
    echo "EmulationStation Mode Already Set"
    sleep 2
fi

mode_check
echo "Front End Set Too $fe"
sleep 3 
echo "Rebooting Now"
sleep 3 
sudo reboot

function mode_check() {
if grep -q 'emulationstation \#auto' "$AUTOSTART"; then
	fe="Emulationstation Mode"
elif grep -q 'attract \#auto' "$AUTOSTART"; then
	fe="Attract Mode"
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
	fe="Pegasus Mode"
elif grep -q 'startx \#auto' "$AUTOSTART"; then
	fe="Desktop Mode"
fi
}
