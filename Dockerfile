FROM ubuntu:18.04

# Add Supervisor
RUN apt-get update && apt-get install --no-install-recommends -y supervisor wget
RUN rm -rf /var/lib/apt/lists/* 


COPY supervisord.conf /etc

# Download AirConnect
RUN wget --output-document=/bin/airupnp-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-x86-64 && chmod +x /bin/airupnp-x86-64
RUN wget --output-document=/bin/aircast-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/aircast-x86-64 && chmod +x /bin/aircast-x86-64

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]

