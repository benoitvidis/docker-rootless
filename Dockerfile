FROM alpine:3.14

LABEL fr.ben0.maintainer="Benoît Vidis"

ARG FIXUID_VERSION=0.5.1

RUN  set -x \
  \
  && apk add --no-cache --virtual deps \
    curl \
  && apk add --no-cache \
    sudo \
  \
  && addgroup -g 1000 me \
  && adduser -u 1000 -G me -h /home/me -s /bin/sh -D me \
  && echo "me ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  \
  && curl -SsL https://github.com/boxboat/fixuid/releases/download/v${FIXUID_VERSION}/fixuid-${FIXUID_VERSION}-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - \
  && chown root:root /usr/local/bin/fixuid \
  && chmod 4755 /usr/local/bin/fixuid \
  && mkdir -p /etc/fixuid \
  && printf "user: me\ngroup: me\n" > /etc/fixuid/config.yml \
  \
  && apk del deps

USER me:me
WORKDIR /home/me

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "ash" ]
