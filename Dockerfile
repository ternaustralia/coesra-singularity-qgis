FROM ubuntu:18.04

RUN apt update -y && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:ubuntugis/ubuntugis-unstable && \
  apt update -y

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia

RUN apt install -y qgis 

ENTRYPOINT qgis