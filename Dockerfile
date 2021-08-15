FROM alpine:latest as build

RUN apk --no-cache add readline readline-dev libconfig libconfig-dev lua \
                       lua-dev luajit-dev luajit openssl openssl-dev \
                       build-base libevent libevent-dev python3-dev \
                       jansson jansson-dev git zlib-dev

RUN git clone --depth 1 --recursive https://github.com/kenorb-contrib/tg.git

WORKDIR /tg
RUN ./configure LDFLAGS="-Wl,--allow-multiple-definition" && make

FROM alpine:latest

RUN apk add --no-cache libevent jansson libconfig libexecinfo \
                       readline lua openssl

COPY --from=build /tg/bin/telegram-cli /bin/telegram-cli

EXPOSE 2391
ENV RUN_PARAM ""

CMD telegram-cli $RUN_PARAM
