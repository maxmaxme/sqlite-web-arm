# sqlite-web-arm

A tiny multi-arch (amd64 + **arm64**) Docker image for
[coleifer/sqlite-web](https://github.com/coleifer/sqlite-web), built so it
runs on a Raspberry Pi.

## Why

Upstream publishes its Docker image for **amd64 only**, and its Dockerfile
compiles SQLite from source (slow to build under QEMU emulation for
arm64). This repo doesn't fork or patch sqlite-web — it just installs the
latest published release from PyPI on a stock `python:3-slim` base, where
all dependencies ship prebuilt wheels. No compilation, fast arm64 builds.

The application is 100% upstream's; this repo owns only the packaging and
CI. "Latest" tracks the latest **PyPI release** of `sqlite-web` (not the
upstream git `master`).

## Image

Published to `ghcr.io/maxmaxme/sqlite-web-arm:latest` on every push to
`main` (and `:<tag>` for git tags) by `.github/workflows/build.yml`.

## Run

```bash
docker run --rm -p 8080:8080 -v "$PWD:/data" \
  ghcr.io/maxmaxme/sqlite-web-arm:latest your-database.db
```

Opens at <http://localhost:8080>. The positional argument is the database
filename relative to the mounted `/data` directory.
