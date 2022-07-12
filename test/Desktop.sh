#!/bin/bash
AUTOSTART="/opt/retropie/configs/all/autostart.sh"

if [ ! -f /usr/bin/startx ]; then
dialog  --sleep 1 --title "PIXEL DESKTOP NOT INSTALLED !! " --msgbox " 
INSTALLING NOW" 0 0
cd $HOME/RetroPie-Setup
sudo ./retropie_packages.sh raspbiantools lxde
DE_FE;
else
    if grep -q 'attract \#auto' "$AUTOSTART"; then
    sudo sed -i 's/attract \#auto/startx \#auto/g' $AUTOSTART
    echo "Desktop Mode Set"
    sleep 2
    pgrep -f attract|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f startx 2>&1
    elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    sudo sed -i 's/pegasus-fe \#auto/startx \#auto/g' $AUTOSTART
    echo "Desktop Mode Set"
    sleep 2
    pgrep -f pegasus-fe|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f startx 2>&1
    elif grep -q 'emulationstation \#auto' "$AUTOSTART"; then
    sudo sed -i 's/emulationstation \#auto/startx \#auto/g' $AUTOSTART
    echo "Desktop Mode Set"
    sleep 2
    pgrep -f emulationstation|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f startx 2>&1
    elif grep -q 'startx \#auto' "$AUTOSTART"; then
    echo "Desktop Mode Already Set"
    sleep 2
fi
fi
mode_check

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