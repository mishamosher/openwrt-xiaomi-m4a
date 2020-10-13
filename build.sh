#!/bin/bash

echo "Simple script to build Openwrt image for the Xiaomi Mi Router 4A Gigabit Router"

echo "Update feeds..."
./scripts/feeds update -a

echo "Install all packages from feeds..."
./scripts/feeds install -a

echo "Copy default to make image"
cp Config-Mi4a .config

echo "Set to use default config"
make defconfig

echo "Download packages before build"
make download

echo "Start build and log to build.log"
make V=s CONFIG_DEBUG_SECTION_MISMATCH=y 2>&1 | tee build.log

exit 0
