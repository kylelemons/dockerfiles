FROM ubuntu:trusty

MAINTAINER Kyle Lemons <kyle@kylelemons.net>

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
                       git \
 && rm -rf /var/lib/apt/lists/*

RUN useradd \
      --comment "Git user" \
      --home "/git" \
      --create-home \
      --shell /sbin/nologin \
      git

CMD git daemon \
      --user=git \
      --reuseaddr \
      --base-path=/git/ \
      --verbose \
      --informative-errors \
      /git/

VOLUME /git
EXPOSE 9418
