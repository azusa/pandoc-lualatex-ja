FROM ubuntu:16.10
MAINTAINER Hiroyuki Onaka

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y language-pack-ja-base language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN apt-get install -y texlive-luatex texlive-fonts-recommended texlive-fonts-extra texlive-lang-japanese  cabal-install
RUN apt-get install -y zlib1g-dev
RUN cabal update
RUN cabal install pandoc-citeproc
RUN cabal install pandoc-crossref --force-reinstalls
RUN apt-get install -y curl

ENV PATH /root/.cabal/bin:$PATH

