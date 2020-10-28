#!/bin/bash
#set -x
ARGS="--rm --name mi4a-openwrt-imagebuild -d --cap-add NET_ADMIN -v $PWD/openwrt:/home/buser/openwrt"

case "$1" in
  build-image)
    docker build -t mi4a-imagebuild:latest -f Dockerfile.build .
    ;;
  start-min)
    docker run $ARGS mi4a-imagebuild:latest build-min
    ;;
  start-full)
    docker run $ARGS mi4a-imagebuild:latest build-full
    ;;
  stop)
    docker stop mi4a-openwrt-imagebuild
    ;;
  restart)
    docker restart mi4a-openwrt-imagebuild
    ;;
  *)
    echo "Usage: $0 {build-image|start-min|start-full|stop|restart}" >&2
    exit 1
    ;;
esac
