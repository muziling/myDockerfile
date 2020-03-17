# telegram-cli

## 参考

https://github.com/victor141516/telegram-cli-downloader/blob/master/Dockerfile

## 使用方法

- 启动docker，进入docker，执行交互命令进行登录

```
telegram-cli -k /tg/tg-server.pub
```

- 登录成功后，停止docker，配置启动参数RUN_PARAM为：

```
-k /tg/tg-server.pub -P 1234
```

然后启动docker。

- 使用类似以下脚本进行tg指令交互

```
nc localhost 1234 <<EOF
msg CCCAT-bot /checkin
EOF
```
