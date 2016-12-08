#!/bin/bash

case "$1" in
  run)
    DATADIR="$2"
    [[ -z "$DATADIR" ]] && echo "no datadir specified" && exit 1
    docker run --name minecraft --detach -p 25565:25565/tcp -v /dev/shm/msm:/ram -v $DATADIR:/msm kylelemons/minecraft-server
    ;;
  save)
    docker exec minecraft /bin/msm all worlds todisk
    ;;
  stop)
    docker exec minecraft /bin/msm stop
    docker rm -f minecraft
    ;;
  kill)
    docker rm -f minecraft
    ;;
  build)
    ;;
  *)
    echo "usage:"
    echo "  $0 run <datadir>"
    echo "  $0 kill"
    echo "  $0 build"
    ;;
esac
