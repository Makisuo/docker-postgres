ARG base_image
FROM ${base_image}

RUN \
  apk add --no-cache \
    openssl
COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/

# COPY postgresql.conf /etc/postgresql/postgresql.conf

# CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]