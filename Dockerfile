FROM alpine

LABEL maintainer="pieceking@qq.com"

RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache tzdata moreutils git nodejs npm\
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN git clone --depth 1 https://github.com/luchenqun/my-bookmark.git /app \
        && cd /app \
        && npm install --production --registry=https://registry.npm.taobao.org

WORKDIR /app

ENV MYSQL_HOST 127.0.0.1
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE mybookmarks
ENV MYSQL_USER root
ENV MYSQL_PASSWORD rootpwd

RUN touch /usr/local/bin/start.sh \
  && chmod 777 /usr/local/bin/start.sh \
  && echo "#!/bin/sh" >> /usr/local/bin/start.sh \
  && echo "sed -i \"s/host:.*/host: '\$1',/\" /app/src/config/adapter.js" >> /usr/local/bin/start.sh \
  && echo "sed -i \"s/port:.*/port: '\$2',/\" /app/src/config/adapter.js" >> /usr/local/bin/start.sh \
  && echo "sed -i \"s/database:.*/database: '\$3',/\" /app/src/config/adapter.js" >> /usr/local/bin/start.sh \
  && echo "sed -i \"s/user:.*/user: '\$4',/\" /app/src/config/adapter.js" >> /usr/local/bin/start.sh \
  && echo "sed -i \"s/password:.*/password: '\$5',/\" /app/src/config/adapter.js" >> /usr/local/bin/start.sh \
  && echo "node /app/production.js" >> /usr/local/bin/start.sh

EXPOSE  2000

CMD start.sh $MYSQL_HOST $MYSQL_PORT $MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD
