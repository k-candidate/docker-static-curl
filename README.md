# docker-static-curl

A minimal Docker image containing only a statically compiled curl binary.

## Features
- Based on scratch image
- Contains only statically compiled curl binary
- Minimal image size

## Build

```bash
docker build --no-cache -t static-curl .
```

## Usage

```bash
docker run --rm static-curl https://httpbin.org/get
```

## Example
```bash
# GET request
docker run --rm static-curl -s https://api.github.com

# POST request
docker run --rm static-curl -X POST -H "Content-Type: application/json" \
  -d '{"key":"value"}' https://api.example.com
```