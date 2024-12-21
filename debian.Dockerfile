ARG base_image
FROM ${base_image}

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update -y && \
  apt-get install -y -qq \
    openssl && \
  apt-get clean autoclean -y && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
  unset DEBIAN_FRONTEND

COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/
COPY postgresql-logical.conf /docker-entrypoint-initdb.d/

# Ensure the config file is copied to the correct location during initialization
RUN echo "cp /docker-entrypoint-initdb.d/postgresql-logical.conf /var/lib/postgresql/data/postgresql.auto.conf" > /docker-entrypoint-initdb.d/01-copy-config.sh && \
    chmod +x /docker-entrypoint-initdb.d/01-copy-config.sh
