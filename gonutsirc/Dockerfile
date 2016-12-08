FROM golang:1.4
MAINTAINER Kyle Lemons <kyle@kylelemons.net>

### Early steps
# We do these early, so that they're cached for simpler development.

### Remote dependencies
# We follow up the keys by pulling down remote dependencies, so they're
# cached to minimize network traffic and rebuild delays.

# Install Go app
RUN go get github.com/kylelemons/blightbot

# Run this as the bot
ENTRYPOINT ["/go/bin/blightbot"]
