FROM alpine:latest
MAINTAINER Matt Bentley <mbentley@mbentley.net>

# install gosu
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories &&\
  apk add --no-cache gosu@edge

# copy in the entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/ps","aux"]
