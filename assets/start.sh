#!/bin/bash

cp /assets/steamer.txt /home/steam/
cd /home/steam
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt
bash /home/steam/steamcmd.sh +runscript /home/steam/steamer.txt

cp /assets/server.cfg /tmp/
cd /tmp
sed -i "s/REPLACEME_TF2_HOSTNAME/$TF2_HOSTNAME/" server.cfg
sed -i "s/REPLACEME_TF2_PASSWORD/$TF2_PASSWORD/" server.cfg
sed -i "s/REPLACEME_TF2_MAIL/$TF2_MAIL/" server.cfg
# server.cfg
[ -f /home/steam/serverfiles/tf2/tf/cfg/server.cfg ] && echo 'server.cfg exists already' || cp -v /tmp/server.cfg /home/steam/serverfiles/tf2/tf/cfg/

# map cycle 
[ -f /home/steam/serverfiles/tf2/tf/cfg/mapcycle.txt ] && echo 'mapcycle.txt exists already' || cp -v /assets/mapcycle.txt /home/steam/serverfiles/tf2/tf/cfg/

cd /home/steam/serverfiles/tf2/tf/cfg
# motd.txt
[ -f /home/steam/serverfiles/tf2/tf/cfg/motd.txt ] && echo 'motd.txt exists already' || wget -c $TF2_MOTD_URL


# Run
bash /assets/run.sh
