#!/bin/bash

build-full () {
echo "Update feeds..."
./scripts/feeds update -a

echo "Install all packages from feeds..."
./scripts/feeds install -a

echo "Copy default custom config to make image"
cp Config-custom .config

echo "Set to use default config"
make defconfig

echo "Download packages before build"
make download

echo "Start build and log to build.log"
make -j$(($(nproc)+1)) V=s CONFIG_DEBUG_SECTION_MISMATCH=y 2>&1 | tee build.log
}

build-rebuild () {
make defconfig
echo "Start build and log to build.log"
make -j$(($(nproc)+1)) V=s CONFIG_DEBUG_SECTION_MISMATCH=y 2>&1 | tee build.log
}

clean-min () {
make clean
}

clean-full () {
make distclean
}

case "$1" in
  build)
    build-full
    ;;
  build-rebuild)
    build-rebuild
    ;;
  clean-min)
    clean-min
    ;;
  clean-full)
    clean-full
    ;;
  *)
    echo "Usage: $0 {build|build-rebuild|clean-min|clean-full}" >&2
    exit 1
    ;;
esac
