FROM quay.io/projectquay/golang:1.20 AS builder

WORKDIR /go/src/app
COPY . .

RUN go get
RUN make build

FROM scratch

COPY --from=builder /go/src/app/my-binary /usr/local/bin/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/usr/local/bin/my-binary"]
CMD [""]
