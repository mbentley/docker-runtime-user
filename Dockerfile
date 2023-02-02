# rebased/repackaged base image that only updates existing packages
FROM mbentley/alpine:latest
LABEL maintainer="Matt Bentley <mbentley@mbentley.net>"

# install gosu (from edge) & shadow for groupmod
RUN apk add --no-cache shadow &&\
  apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing gosu &&\

# copy in the entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/ps","aux"]
