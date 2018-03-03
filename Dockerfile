FROM lsiobase/mono
ARG ECOSERVER_DOWNLOAD

RUN \
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

EXPOSE 2999 3000 3001
VOLUME ["/config", "/app/eco/Storage", "/app/eco/Configs"]

WORKDIR /app/eco
