FROM ubuntu:16.10
MAINTAINER Hiroyuki Onaka



RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl wget
RUN apt-get install -y language-pack-ja-base language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN (cd /tmp && curl -L -O https://github.com/scottkosty/install-tl-ubuntu/raw/master/install-tl-ubuntu && chmod +x ./install-tl-ubuntu)
RUN /tmp/install-tl-ubuntu
RUN apt-get install -y cabal-install
RUN apt-get install -y zlib1g-dev
ENV PATH /root/.cabal/bin:$PATH
RUN cabal update
RUN cabal install happy
RUN cabal install pandoc-citeproc
RUN cabal install pandoc-crossref --force-reinstalls

ENV PATH /opt/texbin:/root/.cabal/bin:$PATH

