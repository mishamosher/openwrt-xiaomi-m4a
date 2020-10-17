# Xiaomi Mi4A Gigabit Openwrt Readme

## Scripts and Docker container (docker/build-dnsmasq.sh, docker/start-stop.sh)

### docker

For convenience have added a docker container to run a dhcp, tftp server to push out images via the u-boot menu

Make sure to have a host that has docker engine installed and running (https://docs.docker.com/engine/install)

**And have a USB ttl serial lead to connect to the uart ports!
This is really important, as only recover is to hold reset and install factory image again (test.bin)**

You need to build the docker image first:

    ./build-dnsmasq.sh

you can configure the 'dnsmasq.conf' to suit your needs - defaults should be fine and will detect all cards (tested in linux only)

To run it:

    ./start-stop.sh start

To stop the dhcp container:

    ./start-stop.sh stop
    
Put your new openwrt images into the '**docker/tftpboot**' folder
Then specify the images when interacting with the u-boot menu.

If you havent gained access to the u-boot menu, then do the exploit method - go to https://github.com/acecilia/OpenWRTInvasion
and follow the exploit guide.

Before flashing your new image during the exploit, run the following commands first:

    nvram set uart_en=1
    nvram set boot_wait=on
    nvram set boot_delay=5
    nvram commit

This allows you to recover from bad flashes without going back to the OEM firmware.

Then continue the exploit guide.

If unsure of compatibilty, write the **openwrt-initramfs image** instead of the sysupgrade image. As this does not write anything to the SPI NOR chip.

Any issues, leave an issue on this git repo
