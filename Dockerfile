FROM haskell:9.4.3 AS builder
WORKDIR /tmp

ENV DEBIAN_FRONTEND=noninteractive

#RUN ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split
#RUN ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb
#RUN ln -s /bin/rm /usr/sbin/rm
#RUN ln -s /bin/tar /usr/sbin/tar

#RUN apt-get update -y
#RUN apt-get upgrade -y
#RUN apt-get install -y python3 python3-pip
#RUN apt-get install -y  build-essential cabal-install zlib1g-dev 

RUN cabal update
RUN cabal v2-install --installdir=/tmp -f-export-dynamic -fembed_data_files --enable-executable-static   pandoc pandoc-crossref

FROM ubuntu:22.10

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=builder /tmp/pandoc /usr/bin/
COPY --from=builder /tmp/pandoc-crossref /usr/bin/

RUN apt-get update -y &&\
  apt-get upgrade -y &&\
  apt-get install -y curl wget xz-utils &&\
  apt-get install -y language-pack-ja-base language-pack-ja &&\
  update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja" &&\
  apt-get install -y xz-utils texlive-luatex texlive-fonts-recommended texlive-fonts-extra texlive-lang-japanese &&\
  chmod a+x /usr/bin/pandoc &&\
  chmod a+x /usr/bin/pandoc-crossref &&\
  apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove 

