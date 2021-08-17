FROM ubuntu:20.04

# Update and install required packages
RUN apt-get update -y \
    && apt-get install -y \
    wget \
    gnupg \
    software-properties-common

## Download qgis latest version and configure it
RUN wget -qO - https://qgis.org/downloads/qgis-2021.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import \
    && chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg \
    && add-apt-repository "deb https://qgis.org/ubuntu $(lsb_release -c -s) main" \
    && apt-get update -y


ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia

## Install qgis
RUN apt install -y \
    binutils \
    qgis \
    qgis-plugin-grass

## error while loading shared libraries: libQt5Core.so.5: cannot open shared object file: No such file or directory
## FIX here -> https://github.com/dnschneid/crouton/wiki/Fix-error-while-loading-shared-libraries:-libQt5Core.so.5
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

ENTRYPOINT qgis
