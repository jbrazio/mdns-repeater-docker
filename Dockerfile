# --------------------------------------------------------------------------------------------------
FROM alpine:3 AS build
WORKDIR /src

RUN apk add --no-cache alpine-sdk libcap

RUN git clone https://github.com/geekman/mdns-repeater.git /src \
	&& make mdns-repeater && chmod 0755 mdns-repeater \
	&& setcap 'cap_net_raw=+ep' mdns-repeater

# --------------------------------------------------------------------------------------------------
FROM alpine:3

LABEL org.opencontainers.image.authors="João Brázio <jbrazio@gmail.com>"
LABEL org.opencontainers.image.description="Dockerized service that is designed to repeat mDNS packets across networks."
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
LABEL org.opencontainers.image.source="https://github.com/jbrazio/mdns-repeater-docker"

RUN apk add --no-cache supervisor
COPY --from=build /src/mdns-repeater /usr/bin/mdns-repeater

RUN mkdir /etc/supervisor.d/ \
	&& cat >> /etc/supervisor.d/mdns-repeater.ini <<EOF
[program:mdns-repeater]
command  = /usr/bin/mdns-repeater -f -u nobody %(ENV_IFDEV)s
user = nobody

startsecs   = 5
autostart   = true
autorestart = true
stopasgroup = true

redirect_stderr = true
stdout_logfile = /dev/stdout
stdout_logfile_maxbytes = 0
EOF

ARG IFDEV=eth0
CMD [ "/usr/bin/supervisord", "--nodaemon" ]