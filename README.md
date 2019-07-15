mbentley/runtime-user
=====================

docker image to demonstrate creating a user and group and runtime; based off of alpine:latest

Build image:
```
docker build -t mbentley/runtime-user .
```

Example usage:
```
docker run -d \
  -e MY_USERNAME=default \
  -e MY_GROUP=default \
  -e MY_UID=1000 \
  -e MY_GID=1000 \
  mbentley/runtime-user
```

Startup environment variables:
  * `MY_USERNAME` - (default: `default`) username to use inside the container
  * `MY_GROUP` - (default: `default`) group name to use inside the container
  * `MY_UID` - (default: `1000`) UID of the new user inside the container; this is important if you want to have the UID outside the container match inside
  * `MY_GID` - (default: `1000`) GID of the new user's group inside the container; this is important if you want to have the GID outside the container match inside
