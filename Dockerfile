FROM alpine:latest
MAINTAINER Matt Bentley <mbentley@mbentley.net>

# install gosu & shadow (for groupmod)
RUN echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories &&\
  apk add --no-cache gosu@edge shadow

# copy in the entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/ps","aux"]
