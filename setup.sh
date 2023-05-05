#/usr/bin/bash

##automatic script version of:
##https://www.reddit.com/r/SteamDeck/comments/vocyi5/start_syncthing_automatically_on_steamdeck_even/

echo "Installing syncthing Flatpak"
#install syncthing through flatpak
flatpak install me.kozec.syncthingtk

echo "Installing ST User Service"
#copy syncthing service to /home/deck/.config/systemd/user/
cp ./syncthing.service /home/deck/.config/systemd/user/

echo "Enabling Service with Decky Port Fix"
#start syncthing service
systemctl --user start syncthing.service

sleep 3

#stop syncthing service & make edits to port to avoid plugin issues
systemctl --user stop syncthing


sleep 3


sed -i 's/<address>127\.0\.0\.1:8080<\/address>/<address>127.0.0.1:8384<\/address>/' ~/.var/app/me.kozec.syncthingtk/config/syncthing/config.xml

#start and enable
systemctl --user start syncthing.service
systemctl --user enable syncthing.service

sleep 1

echo "Please setup your syncthing settings"
#run firefox and open the syncthing config webpage
flatpak run org.mozilla.firefox http://localhost:8384/

