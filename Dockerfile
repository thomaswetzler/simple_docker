# See https://docs.docker.com/engine/reference/builder/#format
#     https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
#
# Basics
#
FROM ubuntu:18.04

# MAINTAINER is obsolete, use LABEL instead
# Query LABELs using docker inspect
LABEL maintainer="thomas.wetzler@t-systems.com"

ENV ORG_NAME="T-Systems"

# Install Packages
RUN echo "updating key functionalities" && \
        DEBIAN_FRONTEND=noninteractive  apt-get update  && \
        apt update && \
        apt-get install -y software-properties-common   && \
        apt-get install -y python3-software-properties && \
        add-apt-repository main && \
        add-apt-repository universe && \
        add-apt-repository restricted && \
        add-apt-repository multiverse
RUN     apt-get update

RUN echo "Installing vi" && \
        apt-get install -y vim

RUN echo "Installing Python" && \
        apt-get install -y python3 python3-pip &&\
        pip3 install requests && \
        pip3 install flask

COPY files/* /home/
RUN  chmod u+x /home/server.*
RUN  chown 1000.1000 /home/*

# Start Server
WORKDIR /home/
ENTRYPOINT /usr/bin/python3 /home/server.py

