FROM ubuntu:latest

# Add Supervisor
RUN apt-get update && apt-get install --no-install-recommends -y supervisor wget apt-utils ca-certificates 
RUN rm -rf /var/lib/apt/lists/* 
RUN groupadd airconnect && useradd airconnect -s /sbin/nologin -g airconnect -m

COPY supervisord.conf /etc
COPY config.xml /home/airconnect
USER airconnect

# Download AirConnect

RUN wget --no-check-certificate --output-document=/home/airconnect/airupnp-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-x86-64 && chmod +x /home/airconnect/airupnp-x86-64
RUN wget --no-check-certificate --output-document=/home/airconnect/aircast-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/aircast-x86-64 && chmod +x /home/airconnect/aircast-x86-64


ADD https://mayhem4api.forallsecure.com/downloads/cli/latest/linux-musl/mapi /usr/bin/mapi
RUN chmod 0755 /usr/bin/mapi


ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]

