FROM mono:latest
ARG ECOSERVER_DOWNLOAD

RUN \
 echo "**** adding user ****" && \
  useradd -u 911 -U -d /config -s /bin/false abc && \
  usermod -G users abc && \
  mkdir -p \
	/app \
	/config \
	/defaults && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	curl unzip && \
 echo "**** install eco ****" && \
 mkdir -p \
	/app/eco && \
 curl -o \
 /tmp/EcoServer.zip -L \
	$ECOSERVER_DOWNLOAD && \
 unzip \
 /tmp/EcoServer.zip -d \
	/app/eco && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# environment settings
ENV XDG_DATA_HOME="/config" \
XDG_CONFIG_HOME="/config"
ENV PGID=911
ENV PUID=911

EXPOSE 2999 3000 3001
VOLUME ["/config", "/app/eco/Storage", "/app/eco/Configs"]

WORKDIR /app/eco
ENTRYPOINT ["/runServer"]
