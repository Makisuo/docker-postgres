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

# Copy PostgreSQL configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Ensure proper permissions
RUN chown postgres:postgres /etc/postgresql/postgresql.conf && \
    chmod 600 /etc/postgresql/postgresql.conf

# Set the custom configuration file path
ENV POSTGRES_CONFIG_FILE=/etc/postgresql/postgresql.conf