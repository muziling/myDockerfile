User N_m3u8DL-RE to stream drm video

Map follow parameter yourself:
- Start an 8080 port in docker
- video stream cache dir /tmp/cache in docker
- read channel config file /app/channels.json in docker

set env `HTTP_ADDR` to your addr
default connect limit is 10, set env `CONN_LIMIT` to modify

channels.json example:
```json
{
    "CinemaxHD": {
        "url": "https://youraddr/index.m3u8",
        "key1": "yourkey",
        "key2": "",
        "key3": "",
        "useragent": "Mozilla/5.0 (Linux; Android 10; BRAVIA 4K VH2 Build/QTG3.200305.006.S292; wv)",
        "authorization": "",
        "proxy": "",
        "resolution": ""
    },
    "CNBC": {
        "url": "https://youraddr/index.m3u8",
        "key1": "yourkey",
        "key2": "",
        "key3": "",
        "useragent": "Mozilla/5.0 (Linux; Android 10; BRAVIA 4K VH2 Build/QTG3.200305.006.S292; wv)",
        "authorization": "",
        "proxy": "",
        "resolution": ""
    }
}
```
These json item value pass to N_m3u8DL-RE

Start docker, browser open setted env `HTTP_ADDR` value

Usage example:
```shell
docker run --name=stream-drm --env=TZ=Asia/Shanghai --env=HTTP_ADDR=http://192.168.1.6:5590 --volume=/mnt/user/appdata/channels.json:/app/channels.json:ro --volume=/dev/shm:/tmp/cache:rw --network=bridge -p 5590:8080 muziling/stream-drm
```
