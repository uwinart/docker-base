# Version 0.0.1
FROM debian:wheezy

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
    ncurses-dev cmake aptitude \
    curl wget \
    git mercurial \
    htop \
    autojump zsh tmux \
    python2.7-dev ruby-dev liblua5.1-dev libperl-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  curl -L http://install.ohmyz.sh | zsh

ADD ./adds/uwinart.zsh-theme /root/.oh-my-zsh/themes/uwinart.zsh-theme
ADD ./adds/zshrc /root/.zshrc

# Install vim
RUN cd /usr/local/src/ && \
  hg clone https://vim.googlecode.com/hg/ vim && \
  cd vim && \
  ./configure --enable-pythoninterp --enable-perlinterp --enable-luainterp --enable-largefile --enable-rubyinterp --enable-cscope --enable-multibyte --enable-fontset && \
  make install clean && \
  git clone https://github.com/khmelevskii/vimrc.git ~/.vim_runtime && \
  ln -s /root/.vim_runtime/.vimrc /root/.vimrc && \
  curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh && \
  sed -i -e "s/call add(s:settings.plugin_groups, 'db')/\" call add(s:settings.plugin_groups, 'db')/g" /root/.vimrc && \
  sed -i -e "s/call add(s:settings.plugin_groups, 'autocomplete')/\" call add(s:settings.plugin_groups, 'autocomplete')/g" /root/.vimrc && \
  sed -i -e "s/call add(s:settings.plugin_groups, 'tern')/\" call add(s:settings.plugin_groups, 'tern')/g" /root/.vimrc && \
  ~/.vim/bundle/neobundle.vim/bin/neoinstall

ENV TERM xterm-256color
