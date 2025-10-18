# docker-static-curl

A Multi-Arch (`amd64` and `arm64`) Distroless image containing only a statically compiled curl binary.

## Build

```bash
docker build --no-cache -t static-curl .
```

## Usage

```bash
docker run --rm static-curl https://httpbin.org/get
```

How to use in a minimal image:
```dockerfile
FROM kcandidate/static-curl AS curl

# Build stage here

# Runtime image
FROM gcr.io/distroless/static:nonroot

# Copy /etc/ssl/certs/ca-certificates.crt (Debian like) \
# or /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem (Fedora like) \
# if using private CA

# Copy static curl for health checks
COPY --from=curl /bin/curl /usr/bin/curl

CMD ["my-statically-linked-bin"]
```
