# FROM quay.io/projectquay/golang:1.20 AS builder

# WORKDIR /go/src/app
# COPY . .

# RUN go get
# RUN make build

# FROM scratch

# COPY --from=builder /go/src/app/my-binary /usr/local/bin/

# COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# ENTRYPOINT ["/usr/local/bin/my-binary"]
# CMD [""]

# Build stage
FROM golang:1.20 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o myapp-linux-amd64 .

# Final stage
FROM scratch
COPY --from=builder /app/myapp-linux-amd64 /app/myapp
ENTRYPOINT ["/app/myapp"]
