#!/bin/bash

cd /home/steam/serverfiles/tf2
./srcds_run -console -game tf -nohltv +sv_pure 1 +map ctf_2fort +maxplayers 24 +ip $IP +sv_setsteamaccount $STEAM_GLST
