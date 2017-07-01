FROM debian:jessie
MAINTAINER DST Academy <support@dst.academy>

# Set build arguments.
ARG GOSU_VERSION
ENV GOSU_VERSION ${GOSU_VERSION:-1.10}
ARG FILEBEAT_USER
ENV FILEBEAT_USER ${FILEBEAT_USER:-"filebeat"}
ARG FILEBEAT_HOME
ENV FILEBEAT_HOME ${FILEBEAT_HOME:-"/opt/filebeat"}
ARG FILEBEAT_VERSION
ENV FILEBEAT_VERSION ${FILEBEAT_VERSION:-5.4.3}
ARG FILEBEAT_URL
ENV FILEBEAT_URL ${FILEBEAT_URL:-"https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$FILEBEAT_VERSION-linux-x86_64.tar.gz"}

# Add our user/group first to ensure their IDs get set consistently.
RUN groupadd -r $FILEBEAT_USER \
	&& useradd -rm -d $FILEBEAT_HOME -g $FILEBEAT_USER $FILEBEAT_USER

# Install everything.
RUN set -x \

	# Install dependencies.
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		wget \
		ca-certificates \

	# Install gosu.
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \

	# Install filebeat.
	&& wget -qO- $FILEBEAT_URL | gosu $FILEBEAT_USER tar --strip-components=1 -xzvC $FILEBEAT_HOME \

	# Clean up.
	&& apt-get purge -y --auto-remove \
		wget \
	&& apt-get clean \
	&& rm -rf \
		/var/lib/apt/lists/* \
		/var/tmp/* \
		/tmp/*

# Copy common scripts.
COPY /script/* /usr/local/bin/

# Copy entrypoint script.
COPY /docker-entrypoint.sh /

# Set entrypoint and default command.
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["filebeat", "-e"]
