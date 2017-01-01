.PHONY: run build homedir
all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker

reqs: STEAM_USERNAME STEAM_PASSWORD STEAM_GLST IP PORT STEAM_GID TAG IP HOMEDIR TF2_HOSTNAME TF2_PASSWORD TF2_MAIL TF2_EXEC TF2_MOTD_URL

run: reqs rm homedir rundocker

install: reqs rm homedir installdocker

rundocker:
	$(eval NAME := $(shell cat NAME))
	$(eval HOMEDIR := $(shell cat HOMEDIR))
	$(eval IP := $(shell cat IP))
	$(eval PORT := $(shell cat PORT))
	$(eval TAG := $(shell cat TAG))
	$(eval STEAM_USERNAME := $(shell cat STEAM_USERNAME))
	$(eval STEAM_PASSWORD := $(shell cat STEAM_PASSWORD))
	$(eval TF2_PASSWORD := $(shell cat TF2_PASSWORD))
	$(eval TF2_HOSTNAME := $(shell cat TF2_HOSTNAME))
	$(eval TF2_MAIL := $(shell cat TF2_MAIL))
	$(eval TF2_EXEC := $(shell cat TF2_EXEC))
	$(eval TF2_MOTD_URL := $(shell cat TF2_MOTD_URL))
	$(eval STEAM_GID := $(shell cat STEAM_GID))
	$(eval STEAM_GLST := $(shell cat STEAM_GLST))
	@docker run --name=$(NAME) \
	-d \
	--cidfile="steamerCID" \
	--env USER=steam \
	--env STEAM_USERNAME=$(STEAM_USERNAME) \
	--env STEAM_PASSWORD=$(STEAM_PASSWORD) \
	--env TF2_PASSWORD=$(TF2_PASSWORD) \
	--env TF2_HOSTNAME=$(TF2_HOSTNAME) \
	--env TF2_MAIL=$(TF2_MAIL) \
	--env TF2_EXEC=$(TF2_EXEC) \
	--env TF2_MOTD_URL=$(TF2_MOTD_URL) \
	--env STEAM_GID=$(STEAM_GID) \
	--env STEAM_GUARD_CODE=$(STEAM_GUARD_CODE) \
	--env STEAM_GLST=$(STEAM_GLST) \
	--env IP=$(IP) \
	--env PORT=$(PORT) \
	-p $(IP):$(PORT):$(PORT) \
	-p $(IP):$(PORT):$(PORT)/udp \
	-p $(IP):26901:26901/udp \
	-p $(IP):27005:27005/udp \
	-p $(IP):27020:27020/udp \
	-v $(HOMEDIR)/.steam:/home/steam/.local \
	-v $(HOMEDIR)/.local:/home/steam/.steam \
	-v $(HOMEDIR)/SteamLibrary:/home/steam/SteamLibrary \
	-v $(HOMEDIR)/Steam:/home/steam/Steam \
	-v $(HOMEDIR)/steamcmd:/home/steam/steamcmd \
	-v $(HOMEDIR)/serverfiles:/home/steam/serverfiles \
	-v $(HOMEDIR)/log:/home/steam/log \
	-t $(TAG)

installdocker:
	$(eval NAME := $(shell cat NAME))
	$(eval HOMEDIR := $(shell cat HOMEDIR))
	$(eval TAG := $(shell cat TAG))
	$(eval IP := $(shell cat IP))
	$(eval PORT := $(shell cat PORT))
	$(eval STEAM_USERNAME := $(shell cat STEAM_USERNAME))
	$(eval STEAM_PASSWORD := $(shell cat STEAM_PASSWORD))
	$(eval STEAM_GID := $(shell cat STEAM_GID))
	$(eval STEAM_GLST := $(shell cat STEAM_GLST))
	$(eval TF2_PASSWORD := $(shell cat TF2_PASSWORD))
	$(eval TF2_HOSTNAME := $(shell cat TF2_HOSTNAME))
	$(eval TF2_MAIL := $(shell cat TF2_MAIL))
	$(eval TF2_EXEC := $(shell cat TF2_EXEC))
	$(eval TF2_MOTD_URL := $(shell cat TF2_MOTD_URL))
	@docker run --name=$(NAME) \
	-d \
  -p $(IP):27345:27345/tcp \
	--cidfile="steamerCID" \
	--env USER=steam \
	--env TF2_PASSWORD=$(TF2_PASSWORD) \
	--env TF2_HOSTNAME=$(TF2_HOSTNAME) \
	--env TF2_MAIL=$(TF2_MAIL) \
	--env TF2_EXEC=$(TF2_EXEC) \
	--env TF2_MOTD_URL=$(TF2_MOTD_URL) \
	--env STEAM_USERNAME=$(STEAM_USERNAME) \
	--env STEAM_PASSWORD=$(STEAM_PASSWORD) \
	--env STEAM_GID=$(STEAM_GID) \
	--env STEAM_GUARD_CODE=$(STEAM_GUARD_CODE) \
	--env STEAM_GLST=$(STEAM_GLST) \
	--env IP=$(IP) \
	--env PORT=$(PORT) \
	-p $(IP):$(PORT):$(PORT) \
	-p $(IP):$(PORT):$(PORT)/udp \
	-p $(IP):26901:26901/udp \
	-p $(IP):27005:27005/udp \
	-p $(IP):27020:27020/udp \
	-v $(HOMEDIR)/.steam:/home/steam/.local \
	-v $(HOMEDIR)/.local:/home/steam/.steam \
	-v $(HOMEDIR)/SteamLibrary:/home/steam/SteamLibrary \
	-v $(HOMEDIR)/Steam:/home/steam/Steam \
	-v $(HOMEDIR)/steamcmd:/home/steam/steamcmd \
	-v $(HOMEDIR)/serverfiles:/home/steam/serverfiles \
	-v $(HOMEDIR)/log:/home/steam/log \
	-t $(TAG) /bin/bash

builddocker: TAG
	$(eval TAG := $(shell cat TAG))
	/usr/bin/time -v docker build -t $(TAG) .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	-@docker kill `cat steamerCID`

rm-image:
	-@docker rm `cat steamerCID`
	-@rm steamerCID

rm: kill rm-image

clean:  rm

logs:
	docker logs  -f `cat steamerCID`

enter:
	docker exec -i -t `cat steamerCID` /bin/bash

TAG:
	@while [ -z "$$TAG" ]; do \
		read -r -p "Enter the TAG you wish to associate with this container [TAG]: " TAG; echo "$$TAG">>TAG; cat TAG; \
	done ;

HOMEDIR:
	@while [ -z "$$HOMEDIR" ]; do \
		read -r -p "Enter the HOMEDIR you wish to associate with this container [HOMEDIR]: " HOMEDIR; echo "$$HOMEDIR">>HOMEDIR; cat HOMEDIR; \
	done ;

IP:
	@while [ -z "$$IP" ]; do \
		read -r -p "Enter the IP Address you wish to assign to this container [IP]: " IP; echo "$$IP">>IP; cat IP; \
	done ;

PORT:
	echo 27015 > PORT

ASK_PORT:
	@while [ -z "$$PORT" ]; do \
		read -r -p "Enter the PORT Address you wish to assign to this container (27015) [PORT]: " PORT; echo "$$PORT">>PORT; cat PORT; \
	done ;

STEAM_USERNAME:
	@while [ -z "$$STEAM_USERNAME" ]; do \
		read -r -p "Enter the steam username you wish to associate with this container [STEAM_USERNAME]: " STEAM_USERNAME; echo "$$STEAM_USERNAME">>STEAM_USERNAME; cat STEAM_USERNAME; \
	done ;

STEAM_GUARD_CODE:
	@while [ -z "$$STEAM_GUARD_CODE" ]; do \
		read -r -p "Enter the steam guard code you wish to associate with this container [STEAM_GUARD_CODE]: " STEAM_GUARD_CODE; echo "$$STEAM_GUARD_CODE">>STEAM_GUARD_CODE; cat STEAM_GUARD_CODE; \
	done ;

STEAM_GID:
	echo 232250 > STEAM_GID

ASK_STEAM_GID:
	@while [ -z "$$STEAM_GID" ]; do \
		read -r -p "Enter the steam password you wish to associate with this container [STEAM_GID]: " STEAM_GID; echo "$$STEAM_GID">>STEAM_GID; cat STEAM_GID; \
	done ;

STEAM_GLST:
	@while [ -z "$$STEAM_GLST" ]; do \
		read -r -p "Enter the steam glst you wish to associate with this container [STEAM_GLST]: " STEAM_GLST; echo "$$STEAM_GLST">>STEAM_GLST; cat STEAM_GLST; \
	done ;

STEAM_PASSWORD:
	@while [ -z "$$STEAM_PASSWORD" ]; do \
		read -r -p "Enter the steam password you wish to associate with this container [STEAM_PASSWORD]: " STEAM_PASSWORD; echo "$$STEAM_PASSWORD">>STEAM_PASSWORD; cat STEAM_PASSWORD; \
	done ;

TF2_PASSWORD:
	@while [ -z "$$TF2_PASSWORD" ]; do \
		read -r -p "Enter the password you wish to associate with this TF2 Server [TF2_PASSWORD]: " TF2_PASSWORD; echo "$$TF2_PASSWORD">>TF2_PASSWORD; cat TF2_PASSWORD; \
	done ;

TF2_HOSTNAME:
	@while [ -z "$$TF2_HOSTNAME" ]; do \
		read -r -p "Enter the tf2 hostname you wish to associate with this TF2 Server [TF2_HOSTNAME]: " TF2_HOSTNAME; echo "$$TF2_HOSTNAME">>TF2_HOSTNAME; cat TF2_HOSTNAME; \
	done ;

TF2_MAIL:
	@while [ -z "$$TF2_MAIL" ]; do \
		read -r -p "Enter the admin email you wish to associate with this TF2 server [TF2_MAIL]: " TF2_MAIL; echo "$$TF2_MAIL">>TF2_MAIL; cat TF2_MAIL; \
	done ;

TF2_EXEC:
	@while [ -z "$$TF2_EXEC" ]; do \
		read -r -p "Enter the server config you wish to execute with this TF2 server hint: look in serverfiles/tf2/tf/cfg ( server_competitive.cfg ) [TF2_EXEC]: " TF2_EXEC; echo "$$TF2_EXEC">>TF2_EXEC; cat TF2_EXEC; \
	done ;

TF2_MOTD_URL:
	@while [ -z "$$TF2_MOTD_URL" ]; do \
		read -r -p "Enter the url to your motd.txt [TF2_MOTD_URL]: " TF2_MOTD_URL; echo "$$TF2_MOTD_URL">>TF2_MOTD_URL; cat TF2_MOTD_URL; \
	done ;

homedir: HOMEDIR
	$(eval HOMEDIR := $(shell cat HOMEDIR))
	-@sudo mkdir -p $(HOMEDIR)/SteamLibrary/steamapps
	-@sudo mkdir -p $(HOMEDIR)/Steam
	-@sudo mkdir -p $(HOMEDIR)/steamcmd
	-@sudo mkdir -p $(HOMEDIR)/.steam
	-@sudo mkdir -p $(HOMEDIR)/.local
	-@sudo chown -R 1000:1000 $(HOMEDIR)

pull:
	$(eval TAG := $(shell cat TAG))
	docker pull $(TAG)

t: build run logs
