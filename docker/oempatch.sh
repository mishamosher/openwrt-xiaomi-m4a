#!/bin/bash
#set -x
export USERUID="$(id -u)"
export USERGID="$(id -g)"
BARGS="--build-arg USERUID=$USERUID --build-arg USERGID=$USERGID"
ARGS="--rm --name mi4a-oempatch -it --cap-add NET_ADMIN --network host -v $PWD/oempatch:/home/buser/oempatch -v $PWD/tftpboot:/home/buser/oempatch/firmwares"

case "$1" in
  build)
    docker build $BARGS -t mi4a-oempatch:latest -f Dockerfile.oempatch .
    ;;
  start)
    docker run $ARGS mi4a-oempatch:latest
    ;;
  stop)
    docker stop mi4a-oempatch
    ;;
  restart)
    docker restart mi4a-oempatch
    ;;
  *)
    echo "Usage: $0 {build|start|stop|restart}" >&2
    exit 1
    ;;
esac
