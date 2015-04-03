#!/bin/bash

COMMAND=${1:-start}

if [[ ! -e /data/config.js ]]; then
  echo "Initializing config.js..."
  cp /ghost/config.docker.js /data/config.js
fi
if [[ ! -e /data/content ]]; then
  echo "Initializing content..."
  rsync -avz /ghost/content/ /data/content
fi
ln -sf /data/config.js /ghost/config.js

chown -R ghost:ghost /ghost /data

case $COMMAND in
  init)
    echo "init requested; exiting"
    ;;
  start)
    # Run ghost
    npm start --production
    ;;
  *)
    echo "unknown command; try 'init' or 'start'"
    ;;
esac
