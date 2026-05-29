# Minimal multi-arch image for coleifer/sqlite-web.
#
# Why this repo exists: upstream publishes its Docker image for amd64
# only, and its Dockerfile compiles SQLite from source (slow under QEMU
# on an arm64 build). We don't need the custom SQLite build for a simple
# admin UI over a tiny DB — so we just install the latest PyPI release on
# a glibc python base, where every dependency ships a prebuilt wheel. No
# compilation, fast arm64 builds. The app code is upstream's; this repo
# only owns the packaging + CI.
FROM python:3-slim

RUN pip install --no-cache-dir sqlite-web gevent

EXPOSE 8080
VOLUME /data
WORKDIR /data

# `sqlite_wsgi` is sqlite-web's gevent WSGI server. The positional arg
# (passed via the compose `command:`) is the DB filename relative to
# /data. Listens on 8080.
ENTRYPOINT ["sqlite_wsgi", "-H", "0.0.0.0"]
