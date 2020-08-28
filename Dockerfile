FROM golang:latest as builder

WORKDIR /go/src/repospanner/

COPY go.mod go.sum /go/src/repospanner/
RUN go mod download

COPY . /go/src/repospanner/
RUN ./build.sh

FROM debian:buster

COPY --from=builder /go/src/repospanner/repobridge /go/src/repospanner/repospanner /go/src/repospanner/repohookrunner /usr/bin/

RUN mkdir /etc/repospanner
COPY config.yml.example /etc/repospanner/config.yml

CMD /usr/bin/repospanner
