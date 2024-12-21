ARG base_image
FROM ${base_image}

RUN \
  apk add --no-cache \
    openssl
COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/

COPY replication.conf /tmp/replication.conf
RUN cat /tmp/replication.conf >> /usr/local/share/postgresql/postgresql.conf.sample && \
    rm /tmp/replication.conf
