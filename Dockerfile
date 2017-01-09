FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

USER root

ENV TF2_UPDATED 20170108

# override these variables in with the prompts
ENV TF2_MOTD_URL https://raw.githubusercontent.com/Thalhalla/tf2/master/assets/motd.txt
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GID 232250

# and override this file with the command to start your server
COPY assets /assets
RUN chmod 755 /assets/*.sh ; \
chmod 755 /assets/steamer.txt

USER steam

CMD ["/bin/bash",  "/assets/start.sh"]
