ARG base_image
FROM ${base_image}

RUN \
  apk add --no-cache \
    openssl
COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/
COPY postgresql-logical.conf /etc/postgresql/postgresql.conf.d/
