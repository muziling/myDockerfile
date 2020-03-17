FROM alpine as builder

RUN apk upgrade --no-cache && apk add --no-cache apk-tools \
    musl \
    libcrypto1.1 \
    libssl1.1 \
    ca-certificates-cacert \
    musl-utils \
    libconfig-dev \
    libevent-dev \
    jansson-dev \
    ncurses-terminfo-base \
    ncurses-libs \
    readline-dev \
    libressl-dev \
    python3-dev \
    libgcrypt-dev \
    zlib-dev \
    lua-lgi \
    make \
    git \
    g++ \
    lua-dev && \
    git clone --recursive https://github.com/kenorb-contrib/tg.git && \
    cd tg && \
    ./configure LDFLAGS="-Wl,--allow-multiple-definition" && make

FROM alpine

VOLUME [ "/tg" ]
EXPOSE 1234

ENV RUN_PARAM ""

RUN mkdir /tg

RUN apk add --no-cache libcrypto1.1 \
    libconfig \
    libevent \
    libressl \
    lua \
    jansson \
    readline

COPY --from=builder /tg/bin/telegram-cli /usr/bin/telegram-cli

CMD /usr/bin/telegram-cli $RUN_PARAM
