if [ -f "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh ]; then
echo "---UPDATING FE SWITCHEROO NOW---"
sleep 5
sudo rm -R "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/FE-Switcheroo.sh -P "$HOME"/RetroPie/retropiemenu/
chmod 755 "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
cp "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh -P "$HOME"/.attract/devils-tools/
echo "UPDATE COMPLETE"
sleep 2 
else
echo "---INSTALLING FE SWITCHEROO NOW---"
sleep 5
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/FE-Switcheroo.sh -P "$HOME"/RetroPie/retropiemenu/
sudo wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/switcheroo -P /usr/local/bin
chmod 755 "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sudo chmod 755 /usr/local/bin/switcheroo
mkdir "$HOME"/.attract/devils-tools/
cp "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh -P "$HOME"/.attract/devils-tools/
cp "$HOME"/RetroPie/retropiemenu/Devils-Box.sh -P "$HOME"/.attract/devils-tools/
chmod 755 "$HOME"/.attract/devils-tools/
chmod 755 "$HOME"/.attract/devils-tools/
echo "INSTALL COMPLETE"
sleep 2
fi
