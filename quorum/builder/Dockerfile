### Build Quorum & Constellation
FROM ubuntu:18.04 as quorum-builder

RUN apt-get update
RUN apt-get install -y ca-certificates libsodium-dev ncurses-dev make gcc musl-dev golang-1.10-go git wget libsnappy-dev libdb-dev libleveldb-dev

RUN ln -s /usr/lib/go-1.10/bin/go /usr/local/bin/go

ARG BUILD_FROM_MASTER=false
ARG QUORUM_VERSION=2.0.2
ARG CONSTELLATION_VERSION=0.3.2

# Compile quorum
WORKDIR /opt/
RUN test ${BUILD_FROM_MASTER} = "true" && git clone https://github.com/jpmorganchase/quorum.git quorum || :
RUN test ${BUILD_FROM_MASTER} = "false" && wget https://github.com/jpmorganchase/quorum/archive/v${QUORUM_VERSION}.tar.gz || :
RUN test ${BUILD_FROM_MASTER} = "false" && tar -zxvf v${QUORUM_VERSION}.tar.gz || :
RUN test ${BUILD_FROM_MASTER} = "false" && ln -s quorum-${QUORUM_VERSION}/ quorum || :
RUN cd quorum/ && make all

WORKDIR /opt/
RUN cp quorum/build/bin/geth /usr/local/bin/

# Install Haskell stack
RUN wget -qO- https://get.haskellstack.org/ | sh

# Compile constellation
WORKDIR /usr/local/src/
RUN test ${BUILD_FROM_MASTER} = "true" && git clone https://github.com/jpmorganchase/constellation || :
RUN test ${BUILD_FROM_MASTER} = "false" && wget https://github.com/jpmorganchase/constellation/archive/v${CONSTELLATION_VERSION}.tar.gz || :
RUN test ${BUILD_FROM_MASTER} = "false" && tar -zxvf v${CONSTELLATION_VERSION}.tar.gz || :
RUN test ${BUILD_FROM_MASTER} = "false" && ln -s constellation-${CONSTELLATION_VERSION}/ constellation || :

ENV SRC /usr/local/src/constellation/
WORKDIR $SRC

RUN stack setup
RUN stack build --dependencies-only
RUN stack install --local-bin-path /usr/local/bin --test
