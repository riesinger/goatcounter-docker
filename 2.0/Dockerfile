FROM golang:alpine AS builder

ARG GIT_CI_REF=release-2.0

RUN apk add --update --no-cache git build-base

RUN git clone -b ${GIT_CI_REF} https://github.com/zgoat/goatcounter.git
RUN cd goatcounter \
    && go build ./cmd/goatcounter


FROM alpine AS runner

WORKDIR /goatcounter

ENV GOATCOUNTER_LISTEN '0.0.0.0:8080'
ENV GOATCOUNTER_DB 'sqlite:///goatcounter/db/goatcounter.sqlite3?_busy_timeout=200&_journal_mode=wal&cache=shared'
ENV GOATCOUNTER_SMTP ''

RUN apk add --update --no-cache ca-certificates

RUN addgroup -S goatcounter && adduser -S goatcounter -G goatcounter
RUN mkdir -p /goatcounter/db && chown -R goatcounter:goatcounter /goatcounter
USER goatcounter


COPY --chown=goatcounter:goatcounter --from=builder /go/goatcounter/goatcounter /usr/bin/goatcounter
COPY --chown=goatcounter:goatcounter goatcounter.sh ./
COPY --chown=goatcounter:goatcounter entrypoint.sh /entrypoint.sh

VOLUME ["/goatcounter/db"]
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/goatcounter/goatcounter.sh"]
