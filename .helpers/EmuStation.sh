function es_helper() {
local choice

  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "ES HELPER " \
     --ok-button Select --cancel-button Exit \
     --menu "Version 0.9" 15 30 30 \
      1 "Devils Themes" \
      2 "ES Theme Menu" \
      3 "Hurstys Themes" \
       2>&1 >/dev/tty)
    
    case "$choice" in 
    1) devils-themes ;;
    2) es-themes  ;;
    3) hursty-themes ;;
    *) break ;;
    esac
  done
}

function es-themes () {
sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/esthemes.rp
}

function hursty-themes () {
if [ -f "/home/pi/RetroPie/retropiemenu/hurstythemes.sh" ]; then
/home/pi/RetroPie/retropiemenu/hurstythemes.sh
else
wget https://raw.githubusercontent.com/RetroHursty69/HurstyThemes/master/install.sh
chmod +x "install.sh"
./install.sh
fi
}

function devil-themes() {
local choice 

  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title " DEVILS THEMES MENU " \ 
    --ok-label Select --cancel-label Main-Menu \ 
    --menu "SELECT THEME AND PRESS A " 20 50 30 \ 
     1 "Devil Chromey " \ 
     2 "Neon I.B.A.D " \ 
     2>&1 >/dev/tty) 
     
   case "$choice" in 
   1) devil-chromey ;; 
   2) neon-ibad ;; 
   *) break ;; 
   esac 
 done
 }
 
 function devil-chromey() {
 wget https://archive.org/download/devils-themes/devil-chromey.zip -P ${HOME}/
 unzip -o "$HOME"/devil-chromey.zip -d /home/pi/.emulationstation/themes/
 sudo rm -R "$HOME"/devil-chromey.zip
 } 
 
 function neon-ibad() {
 wget https://archive.org/download/devils-themes/NEON-IBAD.zip -P ${HOME}/
 unzip -o "$HOME"/NEON-IBAD.zip -d /home/pi/.emulationstation/themes/
 sudo rm -R "$HOME"/NEON-IBAD.zip
 }
 
 es_helper
 
