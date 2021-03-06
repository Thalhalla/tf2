#!/bin/bash

sudo chown -R steam. /home/steam
mkdir -p /home/steam/serverfiles/tf2

cp /assets/steamer.txt /home/steam/
cd /home/steam
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt

cd /opt/steamer
./steamcmd.sh +runscript /home/steam/steamer.txt
echo '<<<<<<<<<<<<<<<DEBUG>>>>>>>>>>>>>>>>'
ls -lh /home/steam/serverfiles
ls -lh /home/steam/serverfiles/tf2
ls -lh /home/steam/serverfiles/tf2/tf
ls -lh /home/steam/serverfiles/tf2/tf/cfg
env
echo '{{{{{{{{{{{{{{{DEBUGEND}}}}}}}}}}}}}}}}'

cp /assets/server.cfg /tmp/
cd /tmp
sed -i "s/REPLACEME_TF2_HOSTNAME/$TF2_HOSTNAME/" server.cfg
sed -i "s/REPLACEME_TF2_PASSWORD/$TF2_PASSWORD/" server.cfg
sed -i "s/REPLACEME_TF2_MAIL/$TF2_MAIL/" server.cfg
# server.cfg
[ -f /home/steam/serverfiles/tf2/tf/cfg/server.cfg ] && echo 'server.cfg exists already' || mv -v /tmp/server.cfg /home/steam/serverfiles/tf2/tf/cfg/

# map cycle 
[ -f /home/steam/serverfiles/tf2/tf/cfg/mapcycle.txt ] && echo 'mapcycle.txt exists already' || cp -v /assets/mapcycle.txt /home/steam/serverfiles/tf2/tf/cfg/

cd /home/steam/serverfiles/tf2/tf/cfg
# motd.txt
[ -f /home/steam/serverfiles/tf2/tf/cfg/motd.txt ] && echo 'motd.txt exists already' || wget -c $TF2_MOTD_URL


# Run
bash /assets/run.sh
