# PAwChO-lab5
Sprawozdanie na laboratoria nr 5

# Budowanie obrazy i kontenera

Obraz można pobrać poleceniem
```bash
docker pull extremical/lab5:latest
```
Link do dockerhuba z obrazem: https://hub.docker.com/r/extremical/lab5

Przy budowie obrazu można zdefiniować argument APP_VERSION, który wyznaczy jakiej wersji aplikacji GO użyć (domyślna to 1.22.2):
```bash
docker build --build-arg APP_VERSION=1.21.7 -t extremical/lab5 .
```
Przy kontenerze można zdefiniować nazwę hosta jaką ma pokazywać aplikacja GO, w przypadku jej niezdefiniowania w "Hostname" pokaże się id kontenera:
```bash
docker run -p 8080:80 --hostname=cinammon extremical/lab5
```

# Wyniki

Dockerfile zawiera healthcheck'i, które (jeśli kontener został uruchomiony przez terminal) ukażą nam stan naszego kontenera.
```bash
127.0.0.1 - - [03/Apr/2025:23:12:48 +0000] "GET / HTTP/1.1" 200 62 "-" "curl/8.12.1"
2025/04/03 23:12:59 path: /
```
W ```GET / HTTP/1.1" 200 62``` cyfra 200 oznacza kod OK, czyli kontener działa poprawnie (jest "healthy"). \
Po uruchomieniu (domyślnie) http://localhost:8080/ aplikacja GO zwróci nam taki rezultat:
```
Hostname: cinammon
IP Address: 172.17.0.3
App Version: 1.21.7
```
