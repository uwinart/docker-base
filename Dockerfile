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
  apt-get install -yq python2.7-dev ruby-dev libperl-dev

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_VERSION 8u91
ENV JAVA_DEBIAN_VERSION 8u91-b14-1~bpo8+1
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

RUN set -x && \
  apt-get update && \
  apt-get install -y \
    openjdk-8-jdk="$JAVA_DEBIAN_VERSION" \
    ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION"

RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

ENV TERM xterm-256color
