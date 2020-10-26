FROM debian:buster

RUN apt-get update &&\
    apt-get install -y sudo time git-core subversion build-essential g++ bash make libssl-dev patch libncurses5 libncurses5-dev zlib1g-dev gawk flex gettext wget unzip xz-utils python python-distutils-extra python3 python3-distutils-extra rsync && \
    apt-get clean && \
    useradd -m buser && \
    echo 'buser ALL=NOPASSWD: ALL' > /etc/sudoers.d/buser

USER buser
WORKDIR /home/buser

# set dummy git config
RUN git config --global user.name "buser" && git config --global user.email "buser@example.com"

# git clone openwrt code
RUN git clone https://gitlab.com/db260179/xiaomi-m4a.git openwrt

# Switch to openwrt folder
WORKDIR /home/buser/openwrt

ENTRYPOINT ["/bin/bash", "-c", "./build.sh build-docker"]
