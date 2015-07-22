#!/bin/bash

# Always run from the script local directory:
cd "$(dirname "${BASH_SOURCE[0]}")"

# Constants:
IMAGE="kylelemons/gitweb"
CONTAINER="gitweb"

# Configuration variables:
VERBOSE=0
DATADIR="$PWD/gitdata"
REMOTE=""
PORT=9480

# Load the config from ./container.cfg relative to this script:
[[ -e "container.cfg" ]] && source "container.cfg"

# Project-specific run options (these can use the config):
run_options=(
  --publish="$PORT":9480
  --volume="$DATADIR":/git
)

# Define a usage function for your future self:
usage() {
  echo "Usage:"
  echo "  container.sh [<options>] <command>"
  echo "Options:"
  echo "  -v           Turn up verbosity"
  echo "  -d <dir>     Set data directory"
  echo "  -p <port>    Set listening port (e.g. 80 or 127.0.0.1:80)"
  echo "Commands:"
  echo "  build        Build the container"
  echo "  run          Run the container"
  echo "  tail         Follow the STDOUT from the container"
  echo "  stop         Kill and remove the container"
  echo "  restart      Restart a possibly-running container"
  echo "  push         Push the container to gcr.io"
  exit 1
}

# Accept overrides from the command-line:
while getopts "vd:p:" opt; do
  case "$opt" in
    v) VERBOSE=$(($VERBOSE+1));;
    d) DATADIR="$OPTARG";;
    p) PORT="$OPTARG";;
    *) usage;;
  esac
done
shift $((OPTIND-1))

if [[ $VERBOSE -ge 1 ]]; then
  echo "Project:"
  echo "  Image:          $IMAGE"
  echo "  Container:      $CONTAINER"
  echo "  Remote Tag:     $REMOTE"
  echo "Config:"
  echo "  Verbosity:      $VERBOSE"
  echo "  Data Directory: $DATADIR"
  if [[ $VERBOSE -ge 2 ]]; then
    echo "Run Options:"
    echo "  ${run_options[@]}"
  fi
fi
[[ -z "$1" ]] && usage

# Execute the command(s):
for command in "$@"; do
  case "$command" in
    build)    docker build -t "$IMAGE" .;;
    run)      docker run --detach --name "$CONTAINER" "${run_options[@]}" "$IMAGE";;
    stop)     docker kill "$CONTAINER";;
    restart)  docker rm -f "$CONTAINER";
              docker run --detach --name "$CONTAINER" "${run_options[@]}" "$IMAGE";;

    push)
      if [[ -z "$REMOTE" ]]; then
        echo "error: must configure REMOTE for push"
        exit 1
      fi
      docker tag -f "$IMAGE" "$REMOTE"
      gcloud docker push "$REMOTE"
      ;;

    *)        usage;;
  esac
done
