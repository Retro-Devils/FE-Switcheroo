#!/bin/bash
#
# Description : FRONT-END SWITCHEROO TOOL
# Author      : Supreme Team, Retro Devils
# Credit      : Chad Ward
# Version     : 2.0
#
clear

install() {
    local IS_RASPBERRYPI
    IS_RASPBERRYPI=$(grep </proc/cpuinfo 'BCM2711')
    cd "$INSTALL_DIR" || exit 1

    if [[ -z $IS_RASPBERRYPI ]]; then
        echo "Please note: The SWITCHEROO script works the best on the Pi4 Boards"
        sleep 5
    fi

    if [[ ! -d $HOME/RetroPie-Setup ]]; then
        echo "Sorry.The mugen installer is only available for builds with RetroPie installed."
        sleep 5
        exit
    fi

    main_menu
}


infobox=""
infobox="${infobox}\n"
infobox="${infobox}Supreme & Devils Switcheroo Download Tool\n\n"
infobox="${infobox}\n"
infobox="${infobox}This script will let you pick your pi frontend once installed.\n"
infobox="${infobox}\n"
infobox="${infobox}\n\n"

dialog --backtitle "Switcheroo installer" \
--title "Switcheroo" \
--msgbox "${infobox}" 0 0

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title "INSTALLER TOOL" \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 0 0 0 \
            1 "Install switcheroo" \
            2 "Install Switcheroo Basic" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) start-install-switcheroo ;;
            2) start-install-switcheroo-basic ;;
            *)  break ;;
        esac
    done
}


function start-install-switcheroo() {
if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
else

echo -e "$(tput setaf 2)INSTALLING FE SWITCHEROO NOW! $(tput sgr0)"
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
wget https://raw.githubusercontent.com/SupremePi/FE-Switcheroo/main/FE-Switcheroo.sh  -P "$HOME"/RetroPie/retropiemenu/
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

function start-install-switcheroo-basic() {
if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
else

echo -e "$(tput setaf 2)INSTALLING FE SWITCHEROO NOW! $(tput sgr0)"
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

install
