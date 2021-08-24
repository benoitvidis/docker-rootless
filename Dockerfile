FROM ubuntu:focal

LABEL fr.ben0.maintainer="Benoît Vidis"

ARG FIXUID_VERSION=0.5.1

RUN  set -x \
  \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    curl \
    sudo \
  \
  && addgroup --gid 1000 me \
  && adduser --uid 1000 --ingroup me --home /home/me --shell /bin/sh --disabled-password --gecos "" me \
  && echo "me ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  \
  && curl -SsL https://github.com/boxboat/fixuid/releases/download/v${FIXUID_VERSION}/fixuid-${FIXUID_VERSION}-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - \
  && chown root:root /usr/local/bin/fixuid \
  && chmod 4755 /usr/local/bin/fixuid \
  && mkdir -p /etc/fixuid \
  && printf "user: me\ngroup: me\n" > /etc/fixuid/config.yml \
  \
  && apt-get purge -y \
    curl \
  && rm -rf /var/lib/apt/lists/*

USER me:me
WORKDIR /home/me

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "bash" ]
