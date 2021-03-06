#!/bin/bash
#set -x
export USERUID="$(id -u)"
export USERGID="$(id -g)"
BARGS="--build-arg USERUID=$USERUID --build-arg USERGID=$USERGID"
ARGS="--rm --name mi4a-openwrt-imagebuild -d --cap-add NET_ADMIN -v $PWD/openwrt:/home/buser/openwrt"

case "$1" in
  build-image)
    docker build $BARGS -t mi4a-imagebuild:latest -f Dockerfile.build .
    ;;
  rebuild)
    docker run $ARGS mi4a-imagebuild:latest build-rebuild
    ;;
  clean-min)
    docker run $ARGS mi4a-imagebuild:latest clean-min
    ;;
  start-min)
    docker run $ARGS mi4a-imagebuild:latest build-min
    ;;
  stop)
    docker stop mi4a-openwrt-imagebuild
    ;;
  restart)
    docker restart mi4a-openwrt-imagebuild
    ;;
  *)
    echo "Usage: $0 {build-image|rebuild|clean-min|start-min|stop|restart}" >&2
    exit 1
    ;;
esac
