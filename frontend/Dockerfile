FROM nginx:1.7

MAINTAINER Kyle Lemons <kyle@kylelemons.net>

RUN mkdir -p /data/www/{static,download}
RUN mkdir -p /data/{conf,ssl}
RUN rm -rf /etc/nginx/conf.d
RUN ln -s /data/conf /etc/nginx/conf.d

VOLUME /data
EXPOSE 80 443
