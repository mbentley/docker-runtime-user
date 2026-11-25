mbentley/runtime-user
=====================

docker image to demonstrate creating a user and group at runtime; based off of alpine:latest

Build image:
```
docker build -t mbentley/runtime-user .
```

Example usage:
```
docker run -it --rm \
  -e PUID=1000 \
  -e PGID=1000 \
  mbentley/runtime-user
```

Startup environment variables:
  * `PUID` - (default: `1000`) UID of the `app` user inside the container; set this to match the UID outside the container so file ownership lines up
  * `PGID` - (default: `1000`) GID of the `app` group inside the container; set this to match the GID outside the container so file ownership lines up
