FROM dstacademy/gosu:0.1
MAINTAINER DST Academy <support@dst.academy>

# Set build arguments.
ARG FILEBEAT_USER
ENV FILEBEAT_USER ${FILEBEAT_USER:-"filebeat"}
ARG FILEBEAT_HOME
ENV FILEBEAT_HOME ${FILEBEAT_HOME:-"/opt/filebeat"}
ARG FILEBEAT_VERSION
ENV FILEBEAT_VERSION ${FILEBEAT_VERSION:-6.2.4}
ARG FILEBEAT_URL
ENV FILEBEAT_URL ${FILEBEAT_URL:-"https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$FILEBEAT_VERSION-linux-x86_64.tar.gz"}

# Add our user/group first to ensure their IDs get set consistently.
RUN groupadd -r $FILEBEAT_USER && useradd -rm -d $FILEBEAT_HOME -g $FILEBEAT_USER $FILEBEAT_USER

# Install everything.
RUN set -x \
	# Install dependencies.
	&& apt-get update \
	&& apt-get install -y --no-install-recommends wget ca-certificates \
	# Install filebeat.
	&& wget -qO- $FILEBEAT_URL | gosu $FILEBEAT_USER tar --strip-components=1 -xzvC $FILEBEAT_HOME \
	# Clean up.
	&& apt-get purge -y --auto-remove wget \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Copy common scripts.
COPY /script/* /usr/local/bin/

# Copy entrypoint script.
COPY /docker-entrypoint.sh /

# Set entrypoint and default command.
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["filebeat", "-e"]
