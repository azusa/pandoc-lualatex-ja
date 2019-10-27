FROM ubuntu:19.10
MAINTAINER Hiroyuki Onaka

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH /root/.cabal/bin:$PATH

RUN apt-get update -y && \
 apt-get upgrade -y && \
 apt-get install -y curl wget && \
 apt-get install -y language-pack-ja-base language-pack-ja && \
 update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja" && \
 apt-get install -y texlive-luatex texlive-fonts-recommended texlive-fonts-extra texlive-lang-japanese && \
 apt-get install -y cabal-install && \
 apt-get install -y zlib1g-dev && \
 cabal update && \
 cabal install happy &&  \
 cabal install pandoc-citeproc && \
 cabal install pandoc-crossref --force-reinstalls && \
 cabal install pandoc --force-reinstalls && \
 apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove

ENV PATH /root/.cabal/bin:$PATH

