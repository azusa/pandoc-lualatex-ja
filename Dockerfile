FROM ubuntu:18.10
MAINTAINER Hiroyuki Onaka

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl wget
RUN apt-get install -y language-pack-ja-base language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

RUN apt-get install -y texlive-luatex texlive-fonts-recommended texlive-fonts-extra texlive-lang-japanese 
RUN apt-get install -y cabal-install
RUN apt-get install -y zlib1g-dev
ENV PATH /root/.cabal/bin:$PATH
RUN cabal update
RUN cabal install happy
RUN cabal install pandoc-citeproc
RUN cabal install pandoc-crossref --force-reinstalls
RUN cabal install pandoc --force-reinstalls
RUN apt-get clean
RUN apt-get autoclean

ENV PATH /root/.cabal/bin:$PATH

