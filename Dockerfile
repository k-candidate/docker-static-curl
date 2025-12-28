FROM alpine:3.23 AS builder

ARG VERSION

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    wget \
    openssl-dev \
    openssl-libs-static

# Download and extract curl source
WORKDIR /tmp
RUN wget -O curl.tar.gz https://curl.se/download/curl-${VERSION}.tar.gz \
    && tar -xzf curl.tar.gz \
    && mv ./curl-* ./src

# Build curl statically
WORKDIR /tmp/src
RUN ./configure \
    --disable-shared \
    --enable-static \
    --enable-dnsshuffle \
    --enable-werror \
    --disable-cookies \
    --disable-crypto-auth \
    --disable-dict \
    --disable-file \
    --disable-ftp \
    --disable-gopher \
    --disable-imap \
    --disable-ldap \
    --disable-pop3 \
    --disable-proxy \
    --disable-rtmp \
    --disable-rtsp \
    --disable-scp \
    --disable-sftp \
    --disable-smtp \
    --disable-telnet \
    --disable-tftp \
    --disable-versioned-symbols \
    --disable-doh \
    --disable-netrc \
    --disable-mqtt \
    --disable-largefile \
    --without-gssapi \
    --without-libidn2 \
    --without-libpsl \
    --without-librtmp \
    --without-libssh2 \
    --without-nghttp2 \
    --without-ntlm-auth \
    --without-brotli \
    --without-zlib \
    --with-ssl && \
    make -j$(nproc) V=1 LDFLAGS="-static -all-static" && \
    strip ./src/curl

# Verify static compilation
RUN ldd ./src/curl && exit 1 || true

# Create final minimal image
FROM gcr.io/distroless/static:nonroot
COPY --from=builder /tmp/src/src/curl /bin/curl
ENTRYPOINT ["/bin/curl"]
CMD ["--help"]