#!/bin/bash
AUTOSTART="/opt/retropie/configs/all/autostart.sh"

clear
mode_check
echo "Front End Switcheroo Currently Using $fe"
sleep 3 
if [ ! -d /opt/retropie/configs/all/pegasus-fe/ ]; then
dialog  --sleep 1 --title "PEGASUS NOT INSTALLED !! " --msgbox "
INSTALLING NOW" 0 0
cd "$HOME"/RetroPie-Setup
sudo ./retropie_packages.sh pegasus-fe
PE_FE;
else
    if grep -q 'attract \#auto' "$AUTOSTART"; then
    sudo sed -i 's/attract \#auto/pegasus-fe \#auto/g' $AUTOSTART
    echo "Pegasus Mode Set"
    sleep 2
    pgrep -f attract|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f pegasus-fe 2>&1
    elif grep -q 'emulationstation \#auto' "$AUTOSTART"; then
    sudo sed -i 's/emulationstation \#auto/pegasus-fe \#auto/g' $AUTOSTART
    echo "Pegasus Mode Set"
    sleep 2
    pgrep -f emulationstation|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f pegasus-fe 2>&1
    elif grep -q 'startx \#auto' "$AUTOSTART"; then
    sudo sed -i 's/pegasus-fe \#auto/pegasus-fe \#auto/g' $AUTOSTART
    echo "Pegasus Mode Set"
    sleep 2
    pgrep -f pegasus-fe|xargs sudo kill -9 > /dev/null 2>&1 &
    sudo openvt -c 1 -s -f emulationstation 2>&1
    elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    echo "Pegasus Mode Already Set"
    sleep 2
fi
fi
mode_check
echo "Front End Currently set Too $fe"
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
