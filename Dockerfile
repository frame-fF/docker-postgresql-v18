FROM postgres:18

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y postgis postgresql-18-postgis-3 \
    && apt-get autoremove && apt-get clean && apt-get autoremove --purge && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y gnupg curl \
    && curl -s https://packagecloud.io/install/repositories/timescale/timescaledb/script.deb.sh | bash \
    && apt-get install -y timescaledb-2-postgresql-18 \
    && apt-get autoremove && apt-get clean && apt-get autoremove --purge && rm -rf /var/lib/apt/lists/*
