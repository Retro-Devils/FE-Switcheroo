if [ -f "$HOME"/RetroPie/retropiemenu/FE-Switcheroo/Switch-Too-Attract-Mode.sh ]; then
echo "---UPDATING FE SWITCHEROO NOW---"
sleep 3
sudo rm -R "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Attract-Mode.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Desktop.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Emulationstation.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Pegasus-FE.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Helpers.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/ 
echo "---FE SWITCHEROO UPDATE COMPLETE---"
sleep 3
else
echo "---INSTALLING FE SWITCHEROO NOW---"
sleep 3
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Attract-Mode.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Desktop.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Emulationstation.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Switch-Too-Pegasus-FE.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/buttons/Helpers.sh -P "$HOME"/RetroPie/retropiemenu/Fe-Switcheroo/ 
echo "---FE SWITCHEROO INSTALL COMPLETE---"
sleep 3
fi
