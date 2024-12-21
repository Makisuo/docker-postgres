ARG base_image
FROM ${base_image}

RUN \
  apk add --no-cache \
    openssl
COPY generate-ssl-certs.sh /docker-entrypoint-initdb.d/

RUN sed -i \
    -e "s/#wal_level = replica/wal_level = logical/" \
    -e "s/#max_replication_slots = 10/max_replication_slots = 10/" \
    -e "s/#max_wal_senders = 10/max_wal_senders = 10/" \
    /usr/local/share/postgresql/postgresql.conf.sample

# Create directory for configuration and set permissions
RUN mkdir -p /etc/postgresql && \
    chown -R postgres:postgres /etc/postgresql

# Copy the modified configuration
RUN cp /usr/local/share/postgresql/postgresql.conf.sample /etc/postgresql/postgresql.conf

# Set the custom configuration file path
ENV POSTGRES_CONFIG_FILE=/etc/postgresql/postgresql.conf
