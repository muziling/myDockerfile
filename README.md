# telegram-cli

## 参考

- https://github.com/ubidots/docker-telegram-cli/blob/master/Dockerfile
- https://github.com/victor141516/telegram-cli-downloader/blob/master/Dockerfile

## 使用方法

- Generate public key from https://my.telegram.org/auth?to=apps and save to file tg-server.pub
- Start docker with parameter or setting RUN_PARAM: -k tg-server.pub --tcp-port 2391 --daemonize --disable-auto-accept --disable-readline --disable-output --disable-colors --accept-any-tcp
- Exec follow script if you need to auto checkin 
```
netcat localhost 2391 <<EOF
msg Test-bot /checkin
EOF
```