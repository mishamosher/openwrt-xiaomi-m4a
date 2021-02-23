#!/bin/bash

opt=$2

build-min () {
echo "Update feeds..."
./scripts/feeds update -a

echo "Install all packages from feeds..."
./scripts/feeds install -a && ./scripts/feeds install -a

echo "Copy default config min to make image"
cp Config-min .config

echo "Set to use default config"
make defconfig

echo "Download packages before build"
if [ "$opt" = "nodownload" ]; then
   echo "Skipping download of packages.."
else
   make download
fi

echo "Start build and log to build.log"
make -j$(($(nproc)+1)) V=s CONFIG_DEBUG_SECTION_MISMATCH=y 2>&1 | tee build.log
}

build-official () {
echo "Update feeds..."
./scripts/feeds update -a

echo "Install all packages from feeds..."
./scripts/feeds install -a && ./scripts/feeds install -a

echo "Copy Openwrt official config..."
release=$(grep -m1 '$(VERSION_NUMBER),' include/version.mk | awk -F, '{ print $3 }' | sed 's/[)]//g')

wget https://downloads.openwrt.org/releases/$release/targets/ramips/mt7621/config.buildinfo -O .config

echo "Set to use default config"
make defconfig

echo "Download packages before build"
if [ "$opt" = "nodownload" ]; then
   echo "Skipping download of packages.."
else
   make download
fi

echo "Start build and log to build.log"
make -j$(($(nproc)+1)) V=s CONFIG_DEBUG_SECTION_MISMATCH=y 2>&1 | tee build.log
}

build-rebuild () {
make clean
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
  build-min)
    build-min
    ;;
  build-official)
    build-official
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
    echo "Usage: $0 {build-official|build-min|build-rebuild|clean-min|clean-full}" >&2
    echo "Optional: {nodownload = No downloads of packages}" >&2
    exit 1
    ;;
esac
shift

