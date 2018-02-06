FROM ubuntu:xenial
MAINTAINER Heiko Bornholdt "heiko@bornholdt.it"

RUN apt-get update \
	&& \
	apt-get install -y \
		wget \
	&& \
    apt-get clean \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget --no-verbose --output-document=/usr/local/bin/plexdrive https://github.com/dweidenfeld/plexdrive/releases/download/4.0.0/plexdrive-linux-amd64 \
	&& \
	chmod +x /usr/local/bin/plexdrive

VOLUME /plexdrive-temp
VOLUME /plexdrive-conf
VOLUME /plexdrive-mount

CMD ["plexdrive", "--mongo-host", "mongo", "--clear-chunk-age=24h", "--temp", "/plexdrive-temp", "--config=/plexdrive-conf", "--refresh-interval=1m", "--fuse-options=allow_other", "--verbosity", "2", "/plexdrive-mount"]
