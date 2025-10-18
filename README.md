# docker-static-curl

A Distroless image containing only a statically compiled curl binary.

## Build

```bash
docker build --no-cache -t static-curl .
```

## Usage

```bash
docker run --rm static-curl https://httpbin.org/get
```

## TODO
- [ ] Parameterize the curl version. Tag the image accordingly.
- [ ] GH Action for PRs: builds, tests, but does not push the image.
- [ ] Multi-arch.