FROM quay.io/armswarm/alpine:{{ALPINE_VERSION}}

ENV GOLANG_VERSION={{GOLANG_VERSION}} \
    GOPATH=/go \
    PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

RUN \
    apk add \
      --no-cache \
      --repository https://ftp.acc.umu.se/mirror/alpinelinux.org/edge/community \
      ca-certificates \
      git \
      musl-dev \
      go={{GOLANG_PACKAGE}} \
    && mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH" \
    && go install cmd/cover

WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/
