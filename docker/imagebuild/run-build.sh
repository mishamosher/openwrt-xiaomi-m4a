#!/bin/bash
#set -x
ARGS="--rm --name mi4a-openwrt-imagebuild -d --cap-add NET_ADMIN -v $PWD/images:/home/buser/images"

case "$1" in
  build-image)
    docker build -t mi4a-imagebuild:latest .
    ;;
  start)
    docker run $ARGS mi4a-imagebuild:latest
    ;;
  stop)
    docker stop mi4a-openwrt-imagebuild
    ;;
  restart)
    docker restart mi4a-openwrt-imagebuild
    ;;
  *)
    echo "Usage: $0 {build-image|start|stop|restart}" >&2
    exit 1
    ;;
esac
