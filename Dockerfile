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
	apt-get install -y python3-software-properties 
RUN apk add --no-cache curl && \
    echo "===> Installing Python3" && \
    apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools utils db && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    apt-get update && \
    apt-get install -y libsasl2-dev python-dev libldap2-dev libssl-dev&& \
    echo "===> Installing flask..." && \
    pip3 install requests && \
    pip3 install web.py 

COPY files/* /home/ 
RUN  chmod u+x /home/srver.*
RUN  chown 1000.1000 /home/*

# Start Server
WORKDIR /home/
#ENTRYPOINT /home/server.py

