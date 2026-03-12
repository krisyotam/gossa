FROM golang:1.23-alpine AS builder
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -o /gossa

FROM alpine:3.20
COPY --from=builder /gossa /usr/local/bin/gossa
ENTRYPOINT ["gossa"]
