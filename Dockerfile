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

RUN apt-get update \
    && apt-get install -y git build-essential cmake ninja-build pkg-config \
       postgresql-server-dev-18 libreadline-dev zlib1g-dev libssl-dev liblz4-dev libcurl4-openssl-dev \
    && git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/duckdb/pg_duckdb /tmp/pg_duckdb \
    && make -C /tmp/pg_duckdb install \
    && rm -rf /tmp/pg_duckdb \
    && apt-get purge -y git build-essential cmake ninja-build \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*
