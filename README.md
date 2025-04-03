# PAwChO-lab5
Sprawozdanie na laboratoria nr 5

https://hub.docker.com/r/extremical/lab5
```bash
127.0.0.1 - - [03/Apr/2025:23:12:48 +0000] "GET / HTTP/1.1" 200 62 "-" "curl/8.12.1"
2025/04/03 23:12:59 path: /
```
```bash
docker build --build-arg APP_VERSION=1.21.7 -t extremical/lab5 .
docker run -p 8080:80 --hostname=cinammon extremical/lab5
```
```
Hostname: cinammon
IP Address: 172.17.0.3
App Version: 1.21.7
```
