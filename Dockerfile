FROM ubuntu

MAINTAINER Eshin Kunishima, omochi@luna.miko.im

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y curl lib32gcc1 && \
    rm -rf /var/lib/apt/lists/*

ENV STEAMCMD_DOWNLOAD_URL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
ENV STEAMCMD_ROOT /opt/steamcmd

RUN mkdir "$STEAMCMD_ROOT" && \
    cd "$STEAMCMD_ROOT" && \
    curl -fsSL "$STEAMCMD_DOWNLOAD_URL" -o steamcmd.tar.gz && \
    tar -xzf steamcmd.tar.gz && \
    rm steamcmd.tar.gz

WORKDIR "$STEAMCMD_ROOT"

ADD update_steam.txt "$STEAMCMD_ROOT"

RUN ./steamcmd.sh +runscript update_steam.txt && rm update_steam.txt
