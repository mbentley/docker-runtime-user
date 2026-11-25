# rebased/repackaged base image that only updates existing packages
FROM mbentley/alpine:latest
LABEL maintainer="Matt Bentley <mbentley@mbentley.net>"

# install gosu & shadow (for usermod/groupmod)
RUN apk add --no-cache gosu shadow &&\
  addgroup -g 1000 app &&\
  adduser -u 1000 -G app -h /home/app -s /bin/sh -D app

# copy in the entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/ps","aux"]
