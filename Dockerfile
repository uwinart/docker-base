# Version 0.0.1
FROM debian:jessie

MAINTAINER Yurii Khmelevskii <y@uwinart.com>

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
  apt-get install apt-utils --yes --force-yes && \
  echo "Europe/Kiev" > /etc/timezone && \
  dpkg-reconfigure tzdata && \
  apt-get upgrade --yes --force-yes && \
  apt-get install locales && \
  sed -i -e "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen && \
  sed -i -e "s/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g" /etc/locale.gen && \
  sed -i -e "s/# uk_UA.UTF-8 UTF-8/uk_UA.UTF-8 UTF-8/g" /etc/locale.gen && \
  locale-gen && \
  apt-get install -yq build-essential autotools-dev automake pkg-config \
    ncurses-dev cmake aptitude cron \
    curl wget \
    git mercurial \
    htop \
    autojump zsh tmux && \
  apt-get install -yq python2.7-dev ruby-dev libperl-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV TERM xterm-256color
