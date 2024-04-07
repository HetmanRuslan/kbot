FROM quay.io/projectquay/golang:1.20

WORKDIR /go/src/app
COPY . .
RUN go get
RUN make build 
RUN go build -o my-binary .

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT [ "./kbot" ]
CMD ["./my-binary"]