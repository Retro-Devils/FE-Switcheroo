if [ -f "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh ]; then
echo "---UPDATING FE SWITCHEROO NOW---"
sleep 5
sudo rm -r "$HOME"/RetroPie/retropiemenu/icons/FE-Switcheroo.png
sudo rm -R "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sudo rm -R /usr/local/bin/switcheroo
sudo rm -r "$HOME"/.attract/tools/FE-Switcheroo.sh
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/FE-Switcheroo.sh -P "$HOME"/RetroPie/retropiemenu/
wget https://github.com/Retro-Devils/FE-Switcheroo/blob/main/FE-Switcheroo.png -P "$HOME"/RetroPie/retropiemenu/icons/
sudo wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/switcheroo -P /usr/local/bin
wget https://github.com/Retro-Devils/FE-Switcheroo/archive/refs/heads/main.zip -P "$HOME"
unzip "$HOME"/main.zip
mv "$HOME"/FE-Switcheroo-main/.helpers "$HOME"
sudo rm -r "$HOME"/FE-Switcheroo-main
chmod 755 "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
chmod 755 "$HOME"/.attract/tools/FE-Switcheroo.sh
sudo chmod 755 /usr/local/bin/switcheroo
cp "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh -P "$HOME"/.attract/tools/
echo "UPDATE COMPLETE LAUNCHING SWITCHEROO"
"$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sleep 2 
else
echo "---INSTALLING FE SWITCHEROO NOW---"
sleep 5
wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/FE-Switcheroo.sh -P "$HOME"/RetroPie/retropiemenu/
sudo wget https://raw.githubusercontent.com/Retro-Devils/FE-Switcheroo/main/switcheroo -P /usr/local/bin
wget https://github.com/Retro-Devils/FE-Switcheroo/blob/main/FE-Switcheroo.png -P "$HOME"/RetroPie/retropiemenu/icons/
wget https://github.com/Retro-Devils/FE-Switcheroo/archive/refs/heads/main.zip -P "$HOME"
wget https://github.com/Retro-Devils/FE-Switcheroo/archive/refs/heads/main.zip -P "$HOME"
unzip "$HOME"/main.zip
mv "$HOME"/FE-Switcheroo-main/.helpers "$HOME"
sudo rm -r "$HOME"/FE-Switcheroo-main
chmod 755 "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
sudo chmod 755 /usr/local/bin/switcheroo
mkdir "$HOME"/.attract/tools/
cp "$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh -P "$HOME"/.attract/tools/
cp "$HOME"/RetroPie/retropiemenu/Devils-Box.sh -P "$HOME"/.attract/tools/
chmod 755 "$HOME"/.attract/tools/
echo "INSTALL COMPLETE LAUNCHING SWITCHEROO"
sleep 2
"$HOME"/RetroPie/retropiemenu/FE-Switcheroo.sh
fi
