FROM alpine:3.14.3 AS builder

RUN apk add --no-cache --update ca-certificates
RUN apk add --no-cache --update -t deps curl
RUN (cd /usr/local/bin; curl -LOk https://dl.k8s.io/release/v1.23.1/bin/linux/arm64/kubectl )
RUN chmod +x /usr/local/bin/kubectl
RUN apk del --purge deps

FROM alpine:3.14.3

COPY --from=builder /usr/local/bin/kubectl /usr/local/bin/kubectl

ENTRYPOINT ["kubectl"]

