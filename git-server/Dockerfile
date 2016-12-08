FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y git-core

## Files
# Main entrypoint script
ADD serve.sh /serve.sh
# Git repository data
VOLUME /d/git

## Entry point
# Run serve.sh by default
CMD /serve.sh

## Ports
# Git (anonymous)
EXPOSE 9418
