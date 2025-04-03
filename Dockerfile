# Etap 1: Obraz bazowy Scratch z aplikacją Go
FROM scratch AS app

# Dodanie systemu plików
ADD alpine-minirootfs-3.21.3-x86_64.tar.gz /

WORKDIR /app

# Wersja aplikacji GO może zostać zmieniona w argumencie
ARG APP_VERSION=1.22.2

# Port aplikacji domyślnie to 8080
ENV PORT=8080
EXPOSE ${PORT}

# Pobranie i instalaja Go w wersji z argumentu APP_VERSION
ADD https://go.dev/dl/go${APP_VERSION}.linux-amd64.tar.gz /tmp/go.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz && rm /tmp/go.tar.gz

# Ścieżka do Go
ENV PATH="/usr/local/go/bin:${PATH}"

# Kopiowanie pliku main.go do kontenera
COPY main.go .

# Kompilacja aplikację go z wybraną wersją
RUN go build -ldflags "-X main.version=${APP_VERSION}" -o main main.go

# Ustawienie punktu wejścia
CMD ["./main"]

# Etap 2: Obraz bazowy Nginx, który użyje Reverse Proxy
FROM nginx:alpine AS proxy

WORKDIR /app

# Skopiowanie skompilowanej aplikacji do obrazu
COPY --from=app /app/main .

# Skopiowanie pliku konfiguracyjnego Reverse Proxy
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=3s --start-period=5s \
  CMD curl -f http://localhost/ || exit 1

# Uruchomienie najpierw aplikacji Go a potem silnik Nginx
CMD ["/bin/sh", "-c", "/app/main & sleep 2 && nginx -g 'daemon off;'"]