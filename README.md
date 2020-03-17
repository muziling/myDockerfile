## [anyproxy](https://github.com/alibaba/anyproxy) is a fully configurable http/https proxy in NodeJS

## offical document

[http://anyproxy.io/cn.html](http://anyproxy.io/cn.html)

---
## run

```
docker run --name anyproxy --restart=always \
	-p 8001:8001\
	-p 8002:8002 \
	-v yourRuleFile:/root/anyproxy.js \
	-d n0trace/anyproxy
```

## test

curl http://httpbin.org/user-agent --proxy http://<server-ip>:8001
