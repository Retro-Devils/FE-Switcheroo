if [ -f "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh ]; then
echo "---UPDATING FE SWITCHEROO NOW---"
sleep 5
sudo rm -R "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sudo rm -R /usr/local/bin/switcheroo
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/FE-Switcheroo.sh -P "$HOME"/RetroPie/retropiemenu/
chmod 755 "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
echo "UPDATE COMPLETE"
sleep 2 
else
echo "---INSTALLING FE SWITCHEROO NOW---"
sleep 5
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/FE-Switcheroo.sh -P "$HOME"/RetroPie/retropiemenu/
sudo wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/switcheroo -P /usr/local/bin
chmod 755 "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sudo chmod 755 /usr/local/bin/switcheroo
echo "INSTALL COMPLETE"
sleep 2
fi
