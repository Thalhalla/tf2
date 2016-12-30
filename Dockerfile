FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

USER root

ENV TF2_UPDATED 20161228
ENV TF2_MOTD_URL https://raw.githubusercontent.com/Thalhalla/tf2/master/assests/motd.txt

# override these variables in with the prompts
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GID 440

# and override this file with the command to start your server
COPY assets /assets
RUN chmod 755 /assets/start.sh ; \
chmod 755 /assets/run.sh ; \
chmod 755 /assets/steamer.txt

USER steam

CMD ["/bin/bash",  "/assets/start.sh"]
