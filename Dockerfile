FROM golang:1.17.9-alpine3.15

# Set the Current Working Directory inside the container
WORKDIR $GOPATH/src/server/mrn-backend

COPY . .

RUN apk add --no-cache ca-certificates && update-ca-certificates

RUN go get

RUN go mod tidy

RUN apk add --update curl && apk add --update tar && apk add --no-cache tzdata && rm -rf /var/cache/apk/*

RUN rm -f /etc/localtime; ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime;

RUN go build -o /mrn-backend

EXPOSE 3001/tcp

CMD ["/mrn-backend"]