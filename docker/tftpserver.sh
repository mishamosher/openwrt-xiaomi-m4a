#!/bin/bash
#set -x

ARGS="--rm --name mi4a-openwrt-recovery -d --cap-add NET_ADMIN --network host -v $PWD/dnsmasq.conf:/etc/dnsmasq.conf -v $PWD/tftpboot:/tftpboot"

case "$1" in
  build)
    docker build -t mi4a-dnsmasq:latest -f Dockerfile.dnsmasq .
    ;;
  start)
    docker run $ARGS mi4a-dnsmasq:latest
    ;;
  stop)
    docker stop mi4a-openwrt-recovery
    ;;
  restart)
    docker restart mi4a-openwrt-recovery
    ;;
  *)
    echo "Usage: $0 {build|start|stop|restart}" >&2
    exit 1
    ;;
esac
