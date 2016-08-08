FROM debian:jessie
MAINTAINER DST Academy <support@dst.academy>

# Set build arguments.
ARG FILEBEAT_VERSION=1.2.3

# Install dependencies.
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install filebeat.
RUN curl -fsSL "https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz" | tar -xzvC /opt \
	&& mv /opt/filebeat-* /opt/filebeat \
	&& chmod +x /opt/filebeat/filebeat \
	&& ln -s /opt/filebeat/filebeat /usr/local/bin

# Copy entrypoint script.
COPY /docker-entrypoint.sh /

# Set entrypoint and default command.
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["filebeat", "-e"]
