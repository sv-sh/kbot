FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app/

RUN apk add make

COPY  . .

ARG TARGETOS

RUN make $TARGETOS

FROM scratch 

WORKDIR /

COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["./kbot"]
CMD ["kbot"]