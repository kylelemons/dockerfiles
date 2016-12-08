FROM ubuntu:trusty

MAINTAINER Kyle Lemons <kyle@kylelemons.net>

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
                       git \
                       lighttpd \
 && rm -rf /var/lib/apt/lists/*

ADD gitweb.conf /etc/gitweb.conf
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

CMD /usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf

VOLUME /git
EXPOSE 9480
