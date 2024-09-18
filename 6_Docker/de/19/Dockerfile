FROM alpine:latest

RUN apk add --no-cache tzdata

RUN cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime && \
    echo "Europe/Brussels" > /etc/timezone

CMD ["date"]
