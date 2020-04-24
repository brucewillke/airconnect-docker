FROM ubuntu:18.04

# Add Supervisor
RUN apt-get update && apt-get install --no-install-recommends -y supervisor wget
RUN rm -rf /var/lib/apt/lists/* 
RUN groupadd airconnect && useradd airconnect -s /sbin/nologin -g airconnect -m

COPY supervisord.conf /etc
USER airconnect
# Download AirConnect
RUN wget --no-check-certificate --output-document=/home/airconnect/airupnp-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-x86-64 && chmod +x /home/airconnect/airupnp-x86-64
RUN wget --no-check-certificate --output-document=/home/airconnect/aircast-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/aircast-x86-64 && chmod +x /home/airconnect/aircast-x86-64

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]

