#!/bin/bash

cp /assets/steamer.txt /home/steam/
cd /home/steam
ln -s '/home/steam/Steam/steamapps/common/Arma 3 Server' arma3
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt
bash /home/steam/steamcmd.sh +runscript /home/steam/steamer.txt

# server.cfg
cp /assets/server.cfg /home/steam/serverfiles/tf2/tf/cfg/
cd /home/steam/serverfiles/tf2/tf/cfg/
sed -i "s/REPLACEME_TF2_HOSTNAME/$TF2_HOSTNAME/" server.cfg
sed -i "s/REPLACEME_TF2_PASSWORD/$TF2_PASSWORD/" server.cfg
sed -i "s/REPLACEME_TF2_MAIL/$TF2_MAIL/" server.cfg

# map cycle 
cp /assets/mapcycle.txt /home/steam/serverfiles/tf2/tf/cfg/

# Run
bash /assets/run.sh
