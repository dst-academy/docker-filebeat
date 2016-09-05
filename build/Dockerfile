FROM debian:jessie
MAINTAINER DST Academy <support@dst.academy>

# Set build arguments.
ARG FILEBEAT_VERSION=1.3.0
ARG FILEBEAT_USER="filebeat"

# Add our user/group first to ensure their IDs get set consistently.
RUN groupadd -r $FILEBEAT_USER && useradd -r -g $FILEBEAT_USER $FILEBEAT_USER

# Install everything.
RUN set -x \

	# Install dependencies.
	&& apt-get update \
	&& apt-get install -y --no-install-recommends wget ca-certificates \

	# Install filebeat.
	&& mkdir -p /opt/filebeat \
	&& wget -qO- "https://download.elastic.co/beats/filebeat/filebeat-$FILEBEAT_VERSION-x86_64.tar.gz" | tar --strip-components=1 -xzvC /opt/filebeat \
	&& chmod +x /opt/filebeat/filebeat \
	&& ln -s /opt/filebeat/filebeat /usr/local/bin \

	# Clean up.
	&& apt-get purge -y --auto-remove wget ca-certificates \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy entrypoint script.
COPY /docker-entrypoint.sh /

# Set entrypoint and default command.
USER $FILEBEAT_USER
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["filebeat", "-e"]
