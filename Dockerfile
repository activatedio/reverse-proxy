FROM golang:1.22.5 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download
COPY main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /proxy ./runner/cmd

# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /proxy /usr/bin/proxy

USER nonroot:nonroot

ENTRYPOINT ["/usr/bin/proxy"]
