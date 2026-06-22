# Docker Compose Corpus Fixture

This is a minimal Docker Compose project for devcontainer setup evaluation.
It follows the shape of Docker's Compose quickstart: a Python HTTP service with
a Redis-backed hit counter.

## Commands

```sh
make run
make check
make clean
```

The HTTP service listens on port `8000` on the host and port `5000` in the
container.
