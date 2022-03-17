#!/bin/bash
#
# Description : FRONT-END SWITCHEROO TOOL
# Author      : Supreme Team, Retro Devils
# Credit      : Chad Ward
# Version     : 2.0
#
clear

AUTOSTART="/opt/retropie/configs/all/autostart.sh"

#################
#MAIN INSTALLERS#
#################

install_attract() {
if (dialog --title "ATTRACT MODE NOT INSTALLED!" --yesno "Would You Like To Install Atrract Mode?" 0 0 )
then
        if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
	else
        cd $HOME/RetroPie-Setup
        sudo ./retropie_packages.sh attractmode
        echo -e "$(tput setaf 2)Attract Successfully Installed. $(tput sgr0)"
        sleep 3
        ATTRACT_MODE
	fi
else 
        echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
        sleep 3
        quit
fi
}

install_desktop() {
if (dialog --title "PIXEL DESKTOP NOT INSTALLED!" --yesno "Would You Like To Install Pixel Desktop?" 0 0 )
then
        if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
	else
        cd $HOME/RetroPie-Setup
        sudo ./retropie_packages.sh raspbiantools lxde
        echo -e "$(tput setaf 2)Pixel Desktop Successfully Installed. $(tput sgr0)"
        sleep 3
        DESKTOP_MODE
	fi
else 
        echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
        sleep 3
        quit
fi
}

install_emulationstation() {
if (dialog --title "EMULATIONSTATION NOT INSTALLED!" --yesno "Would You Like To Install Emulationstation?" 0 0 )
then
        if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
	else
        cd $HOME/RetroPie-Setup
        sudo ./retropie_packages.sh emulationstation
        echo -e "$(tput setaf 2)Emulastation Successfully Installed. $(tput sgr0)"
        sleep 3
        EMULATIONSTATION_MODE
	fi
else 
        echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
        sleep 3
        quit
fi
}

install_pegasus() {
if (dialog --title "PEGASUS NOT INSTALLED!" --yesno "Would You Like To Install Pegasus-Fe?" 0 0 )
then
        if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
	else
        cd $HOME/RetroPie-Setup
        sudo ./retropie_packages.sh pegasus-fe
        echo -e "$(tput setaf 2)Pegasus fe Successfully Installed. $(tput sgr0)"
        sleep 3
        PEGASUS_MODE
	fi
else 
        echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
        sleep 3
        quit
fi
}

install_kodi() {
if (dialog --title "KODI NOT INSTALLED!" --yesno "Would you like to Install kodi?" 0 0 )
then
        if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
	else
        cd $HOME/RetroPie-Setup
        sudo ./retropie_packages.sh kodi
        echo -e "$(tput setaf 2)Kodi Successfully Installed. $(tput sgr0)"
        sleep 3
        KODI_MODE
	fi
else 
        echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
        sleep 3
        quit
fi
}

#################
#ATTRACT TOOLS#
#################

function es_attractmode() {
if (dialog --title "ATTRACT CONTROLLER TOOL!" --yesno "Would You Like To Copy Your ES Controller input to AM?" 0 0 )
then
        es_at
else 
        echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
        sleep 3
fi
}

function es_at() {
        echo -e "$(tput setaf 2)Now copying maim Es Controller input to attract! $(tput sgr0)"
        sleep 3

rm /tmp/attract_tmp  2>/dev/null
cp /home/pi/.attract/attract.cfg /home/pi/.attract/attract.cfg.bkp

#Read in current values from the Emulation Station es_settings.cfg file

configure=`cat /opt/retropie/configs/all/emulationstation/es_input.cfg |grep 'input name="start"' |cut -f6 -d '"'`
select=`cat /opt/retropie/configs/all/emulationstation/es_input.cfg |grep 'input name="a"' |cut -f6 -d '"'`
back=`cat /opt/retropie/configs/all/emulationstation/es_input.cfg |grep 'input name="b"' |cut -f6 -d '"'`
prev_letter=`cat /opt/retropie/configs/all/emulationstation/es_input.cfg |grep 'input name="pageup"' |cut -f6 -d '"'`
next_letter=`cat /opt/retropie/configs/all/emulationstation/es_input.cfg |grep 'input name="pagedown"' |cut -f6 -d '"'`
add_favourite=`cat /opt/retropie/configs/all/emulationstation/es_input.cfg |grep 'input name="y"' |cut -f6 -d '"'`
edit_game=`cat /opt/retropie/configs/all/emulationstation/es_input.cfg |grep 'input name="select"' |cut -f6 -d '"'`


#Write out the new values into the Attract Mode attract.cfg file

while read line
do
if [[ "${line}" == "input_map" ]]; then
  echo "input_map" >> /tmp/attract_tmp
  echo "configure                 Joy0 Button${configure}" >> /tmp/attract_tmp
  echo "select                    Joy0 Button${select}" >> /tmp/attract_tmp
  echo "back                      Joy0 Button${back}" >> /tmp/attract_tmp
  echo "prev_letter               Joy0 Button${prev_letter}" >> /tmp/attract_tmp
  echo "next_letter               Joy0 Button${next_letter}" >> /tmp/attract_tmp
  echo "add_favourite             Joy0 Button${add_favourite}" >> /tmp/attract_tmp
  echo "edit_game                 Joy0 Button${edit_game}" >> /tmp/attract_tmp
else
  echo "${line}" >> /tmp/attract_tmp
fi
done < /home/pi/.attract/attract.cfg

cp /tmp/attract_tmp /home/pi/.attract/attract.cfg  2>/dev/null
        echo -e "$(tput setaf 2)Done! $(tput sgr0)"
        sleep 3
}

###########
#MAIN MENU#
###########

function main_menu() {
    mode_check
    local choice

    while true; do
        choice=$(dialog --backtitle "RetroPie is Currently Using $md As Your Boot Mode" --title " FRONTENDS SWITCHEROO MENU V 2.0" \
            --ok-label OK --cancel-label EXIT \
            --menu "Which Frontend or Helper Which You Like To Use?" 25 75 20 \
	    + "<--------->FRONTENDS<--------->" \
	    1 "Switch Boot Mode To Attract Mode ( $at_here )" \
            2 "Switch Boot Mode To Desktop ( $dp_here )" \
            3 "Switch Boot Mode To Emulationstation ( $es_here )" \
            4 "Switch Boot Mode To Pegasus-fe ( $ps_here )" \
            5 "Switch Boot Mode To Kodi ( $kodi_here )" \
	    + "<--------->UPDATES<----------->" \
	    6 "Update FE Switcheroo" \
            2>&1 > /dev/tty)

        case "$choice" in
	    +) none ;;
            1) ATTRACT_MODE ;;
            2) DESKTOP_MODE ;;
            3) EMULATIONSTATION_MODE ;;
            4) PEGASUS_MODE ;;
            5) KODI_MODE ;;
	    6) start-update-switcheroo-basic ;;
            *)  break ;;
        esac
    done
}

function ATTRACT_MODE() {
    if [ ! -d /home/pi/.attract ]; then
    install_attract
else
    if grep -q 'emulationstation \#auto' "$AUTOSTART"; then
    sudo sed -i 's/emulationstation \#auto/attract \#auto/g' $AUTOSTART
    if (dialog --title "Attract Mode Now Set!" --yesno "Would You Like To Reboot In Attact Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Attract Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi  
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    sudo sed -i 's/pegasus-fe \#auto/attract \#auto/g' $AUTOSTART
    if (dialog --title "Attract Mode Now Set!" --yesno "Would You Like To Reboot In Attact Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Attract Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi  
elif grep -q 'startx \#auto' "$AUTOSTART"; then
    sudo sed -i 's/startx \#auto/attract \#auto/g' $AUTOSTART
    if (dialog --title "Attract Mode Now Set!" --yesno "Would You Like To Reboot In Attact Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Attract Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi  
elif grep -q 'kodi \#auto' "$AUTOSTART"; then
    sudo sed -i 's/kodi \#auto/attract \#auto/g' $AUTOSTART
    if (dialog --title "Attract Mode Now Set!" --yesno "Would You Like To Reboot In Attact Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Attract Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi  
elif grep -q 'attract \#auto' "$AUTOSTART"; then
    echo -e "$(tput setaf 2)Attract Mode Already Set! $(tput sgr0)"
    sleep 3
fi
es_attractmode
mode_check
fi
}

function DESKTOP_MODE() {
    if [ ! -f /usr/bin/startx ]; then
    install_desktop
else
    if grep -q 'attract \#auto' "$AUTOSTART"; then
    sudo sed -i 's/attract \#auto/startx \#auto/g' $AUTOSTART
    if (dialog --title "  Mode Set!" --yesno "Would You Like To Reboot In Desktop Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Desktop Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    sudo sed -i 's/pegasus-fe \#auto/startx \#auto/g' $AUTOSTART
    if (dialog --title "Desktop Boot Mode Set!" --yesno "Would You Like To Reboot In Desktop Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Desktop Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'emulationstation \#auto' "$AUTOSTART"; then
    sudo sed -i 's/emulationstation \#auto/startx \#auto/g' $AUTOSTART
    if (dialog --title "Desktop Boot Mode Set!" --yesno "Would You Like To Reboot In Desktop Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Desktop Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'kodi \#auto' "$AUTOSTART"; then
    sudo sed -i 's/kodi \#auto/startx \#auto/g' $AUTOSTART
    if (dialog --title "Desktop Boot Mode Set!" --yesno "Would You Like To Reboot In Desktop Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Desktop Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'startx \#auto' "$AUTOSTART"; then
    echo -e "$(tput setaf 2)Desktop Mode Already Set! $(tput sgr0)"
    sleep 3
fi
mode_check
fi
}

function EMULATIONSTATION_MODE() {
    if [ ! -d /opt/retropie/configs/all/emulationstation ]; then
    install_emulationstation
else
    if grep -q 'attract \#auto' "$AUTOSTART"; then
    sudo sed -i 's/attract \#auto/emulationstation \#auto/g' $AUTOSTART
    if (dialog --title "EmulationStation Boot Mode Set!" --yesno "Would You Like To Reboot Into EmulationStation Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into EmulationStation Mode ! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    sudo sed -i 's/pegasus-fe \#auto/emulationstation \#auto/g' $AUTOSTART
    if (dialog --title "EmulationStation Boot Mode Set!" --yesno "Would You Like To Reboot Into EmulationStation Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into EmulationStation Mode ! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'startx \#auto' "$AUTOSTART"; then
    sudo sed -i 's/startx \#auto/emulationstation \#auto/g' $AUTOSTART
    if (dialog --title "EmulationStation Boot Mode Set!" --yesno "Would You Like To Reboot Into EmulationStation Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into EmulationStation Mode ! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'kodi \#auto' "$AUTOSTART"; then
    sudo sed -i 's/kodi \#auto/emulationstation \#auto/g' $AUTOSTART
    if (dialog --title "EmulationStation Boot Mode Set!" --yesno "Would You Like To Reboot Into EmulationStation Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into EmulationStation Mode ! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'emulationstation \#auto' "$AUTOSTART"; then
    echo -e "$(tput setaf 2)EmulationStation Mode Already Set! $(tput sgr0)"
    sleep 3
fi
mode_check
fi
}

function PEGASUS_MODE() {
    if [ ! -d /opt/retropie/configs/all/pegasus-fe ]; then
    install_pegasus
else
    if grep -q 'attract \#auto' "$AUTOSTART"; then
    sudo sed -i 's/attract \#auto/pegasus-fe \#auto/g' $AUTOSTART
    if (dialog --title "Pegasus Mode Set!" --yesno "Would You Like To Reboot In Pegasus Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Pegasus Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'emulationstation \#auto' "$AUTOSTART"; then
    sudo sed -i 's/emulationstation \#auto/pegasus-fe \#auto/g' $AUTOSTART
    if (dialog --title "Pegasus Mode Set!" --yesno "Would You Like To Reboot In Pegasus Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Pegasus Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'startx \#auto' "$AUTOSTART"; then
    sudo sed -i 's/startx \#auto/pegasus-fe \#auto/g' $AUTOSTART
    if (dialog --title "Pegasus Mode Set!" --yesno "Would You Like To Reboot In Pegasus Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Pegasus Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'kodi \#auto' "$AUTOSTART"; then
    sudo sed -i 's/kodi \#auto/pegasus-fe \#auto/g' $AUTOSTART
    if (dialog --title "Pegasus Mode Set!" --yesno "Would You Like To Reboot In Pegasus Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Pegasus Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    echo -e "$(tput setaf 2)Pegasus Mode Already Set! $(tput sgr0)"
    sleep 3
fi
mode_check
fi
}

function KODI_MODE() {
    if [ ! -f /usr/bin/kodi ]; then
    install_kodi
else
    if grep -q 'attract \#auto' "$AUTOSTART"; then
    sudo sed -i 's/attract \#auto/kodi \#auto/g' $AUTOSTART
    if (dialog --title "Kodi Mode Set!" --yesno "Would You Like To Reboot In Kodi Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Kodi Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'emulationstation \#auto' "$AUTOSTART"; then
   sudo sed -i 's/emulationstation \#auto/kodi \#auto/g' $AUTOSTART
    if (dialog --title "Kodi Mode Set!" --yesno "Would You Like To Reboot In Kodi Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Kodi Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'startx \#auto' "$AUTOSTART"; then
    sudo sed -i 's/startx \#auto/kodi \#auto/g' $AUTOSTART
    if (dialog --title "Kodi Mode Set!" --yesno "Would You Like To Reboot In Kodi Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Kodi Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
    sudo sed -i 's/pegasus-fe \#auto/kodi \#auto/g' $AUTOSTART
    if (dialog --title "Kodi Mode Set!" --yesno "Would You Like To Reboot In Kodi Mode Now?" 0 0 )
    then
    echo -e "$(tput setaf 2)Now Rebooting Pi Into Kodi Mode! $(tput sgr0)"
    sleep 3
    sudo reboot
    else 
    echo -e "$(tput setaf 2)Skipping Heading Back To Main Menu! $(tput sgr0)"
    sleep 3
    quit 2>/dev/null
    fi
elif grep -q 'kodi \#auto' "$AUTOSTART"; then
    echo -e "$(tput setaf 2)Kodi Mode Already Set! $(tput sgr0)"
    sleep 3
fi
mode_check
fi
}

function installer_helper() {
if [ ! -d /home/pi/.attract ]; then
at_here=MISSING!
else
at_here=INSTALLED!
fi

if [ ! -f /usr/bin/startx ]; then
dp_here=MISSING!
else
dp_here=INSTALLED!
fi

if [ ! -d /opt/retropie/configs/all/emulationstation ]; then
es_here=MISSING!
else
es_here=INSTALLED!
fi

if [ ! -d /opt/retropie/configs/all/pegasus-fe ]; then
ps_here=MISSING!
else
ps_here=INSTALLED!
fi

if [ ! -f /usr/bin/kodi ]; then
kodi_here=MISSING!
else
kodi_here=INSTALLED!
fi
}

function mode_check() {
if grep -q 'emulationstation \#auto' "$AUTOSTART"; then
	md="Emulationstation Mode"
elif grep -q 'attract \#auto' "$AUTOSTART"; then
	md="Attract Mode"
elif grep -q 'pegasus-fe \#auto' "$AUTOSTART"; then
	md="Pegasus Mode"
elif grep -q 'startx \#auto' "$AUTOSTART"; then
	md="Desktop Mode"
elif grep -q 'kodi \#auto' "$AUTOSTART"; then
	md="Kodi Mode"
fi
}

function start-update-switcheroo-basic() {
if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
else

echo -e "$(tput setaf 2)UPDATING FE SWITCHEROO NOW! $(tput sgr0)"
sleep 3

#Remove old version of FE-Switcheroo
if [[ -f "$HOME"/RetroPie/retropiemenu/icons/FE-Switcheroo.png ]]; then
sudo rm -r "$HOME"/RetroPie/retropiemenu/icons/FE-Switcheroo.png
fi

if [[ -f "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh ]]; then
sudo rm -R "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
fi

if [[ -f /usr/local/bin/switcheroo ]]; then
sudo rm -R /usr/local/bin/switcheroo
fi 

if [[ -f "$HOME"/.attract/tools/FE-Switcheroo.sh ]]; then
sudo rm -r "$HOME"/.attract/tools/FE-Switcheroo.sh
fi

#Pulling latest script version#
wget https://raw.githubusercontent.com/SupremePi/FE-Switcheroo/main/FE-Switcheroo-basic.sh  -O "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sudo chmod +x /home/pi/RetroPie/retropiemenu/FE-Switcheroo.sh

#If on a supreme build
if [ -f /usr/bin/suprememarqueetool ]; then

sudo cat <<\EOF123 > "/opt/retropie/configs/all/autostart.sh"
#isdual=`tvservice -l |grep "2 attached device" |wc -l`
if [[ $isdual == "1" ]]; then
fbset -fb /dev/fb0 -g 1920 1080 1920 1080 16
/usr/bin/python /opt/retropie/configs/all/PieMarquee2/PieMarquee2.py &
fi
#/home/pi/scripts/themerandom.sh
#/home/pi/.attract/ambootcheck/amromcheck.sh
while pgrep omxplayer >/dev/null; do sleep 1; done
(sleep 10; mpg123 -f 24576 -Z /home/pi/RetroPie/roms/music/*.mp3 >/dev/null 2>&1) &
pegasus-fe #auto
EOF123
sudo chmod +x /opt/retropie/configs/all/autostart.sh

sudo cp "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh "$HOME"/RetroPie/retropiemenu/frontendselector.sh
sudo mv "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh "$HOME"/RetroPie/scripts/.sb-unified/retropiemenu/frontendselector.sh

echo -e "$(tput setaf 2)UPDATE COMPLETE LAUNCHING SWITCHEROO! $(tput sgr0)"
sleep 3
"$HOME"/RetroPie/retropiemenu/frontendselector.sh
sleep 2 

else

#Adding bin launcher#
if [ ! -f /usr/local/bin/switcheroo ]; then
sudo bash -c 'cat << EOF > /usr/local/bin/switcheroo
sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch  /home/pi/RetroPie/retropiemenu/FE-Switcheroo.sh
EOF'
sudo chmod +x /usr/local/bin/switcheroo
fi

#Pulling latest png file
wget https://raw.githubusercontent.com/SupremePi/FE-Switcheroo/main/FE-Switcheroo.png -P "$HOME"/RetroPie/retropiemenu/icons/
sudo chmod +x "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh

#Do gamelist edits#
cp /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml.bkp
cp /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml /tmp

cat /tmp/gamelist.xml |grep -v "</gameList>" > /tmp/templist.xml

ifexist=`cat /tmp/templist.xml |grep FE-Switcheroo |wc -l`

if [[ ${ifexist} > 0 ]]; then
  echo -e "$(tput setaf 2)Skipping adding FE-Switcheroo to your gamlist it's already added! $(tput sgr0)"
  echo "already in gamelist.xml" > /tmp/exists
else
  echo "  <game>" >> /tmp/templist.xml
  echo "    <path>./FE-Switcheroo.sh</path>" >> /tmp/templist.xml
  echo "    <name>FE Switcheroo</name>" >> /tmp/templist.xml
  echo "    <desc>This script will let you pick your boot up front-end and so much more.</desc>" >> /tmp/templist.xml
  echo "    <image>/home/pi/RetroPie/retropiemenu/icons/FE-Switcheroo.png</image>" >> /tmp/templist.xml
  echo "    <playcount>1</playcount>" >> /tmp/templist.xml
  echo "    <lastplayed></lastplayed>" >> /tmp/templist.xml
  echo "  </game>" >> /tmp/templist.xml
  echo "</gameList>" >> /tmp/templist.xml

  cp /tmp/templist.xml /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
  cp /tmp/templist.xml /home/pi/RetroPie/retropiemenu/gamelist.xml
  #Check if on a supreme build!
  if [ -d /home/pi/RetroPie/scripts/.sb-unified/retropiemenu ]; then
  cp /tmp/templist.xml /home/pi/RetroPie/scripts/.sb-unified/retropiemenu/gamelist.xml
  cp /tmp/templist.xml /home/pi/RetroPie/scripts/.sb-unified/retropie-gml/gamelist.xml
  fi
  echo -e "$(tput setaf 2)Finished adding FE-Switcheroo to your gamlist! $(tput sgr0)"
fi

#Build attract locations
if [[ ! -e /opt/retropie/configs/all/attractmode/tools ]]; then
mkdir "$HOME"/.attract/tools/
fi

cp "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh -P "$HOME"/.attract/tools/
chmod 755 "$HOME"/.attract/tools/

echo -e "$(tput setaf 2)UPDATE COMPLETE LAUNCHING SWITCHEROO! $(tput sgr0)"
sleep 3

"$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sleep 2

fi
fi
}

##############
#-CHECK LIST-#
##############

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
  NETCONNECTED=0
else
  NETCONNECTED=1
fi

installer_helper

main_menu
