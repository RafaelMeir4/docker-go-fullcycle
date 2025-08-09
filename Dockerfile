FROM golang:tip-alpine3.22 AS builder

WORKDIR /app
COPY go.mod  *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o go-fullcycle .

FROM scratch
COPY --from=builder /app/go-fullcycle /
CMD ["/go-fullcycle"]
