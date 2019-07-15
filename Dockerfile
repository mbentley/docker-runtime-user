FROM alpine:latest
MAINTAINER Matt Bentley <mbentley@mbentley.net>

# copy in the entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/ps","aux"]
