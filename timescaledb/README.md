# TimescaleDB

## 1. Prerequisites

### 1.1. Install and configure Docker and Just
Install the following software:

- [Docker](https://www.docker.com/products/docker-desktop)
- [Docker Compose](https://docs.docker.com/compose/)
- [Just](https://github.com/casey/just)

### 1.2. Start TimescaleDB and Grafana
Start the services with:

```shell
docker compose up -d
```

Check the services are running with:

```shell
docker compose ps

NAME                        IMAGE                               COMMAND                  SERVICE       CREATED          STATUS                   PORTS
timescaledb-grafana-1       grafana/grafana:11.6.0              "/run.sh"                grafana       52 minutes ago   Up 7 minutes (healthy)   0.0.0.0:13000->3000/tcp
timescaledb-timescaledb-1   timescale/timescaledb:2.18.1-pg17   "docker-entrypoint.s…"   timescaledb   7 minutes ago    Up 7 minutes (healthy)   5432/tcp
```

### 1.3. Beware! TimescaleDB configuration limits

Some TimescaleDB tutorials are based on large datasets, such as the New York Yellow Cab rides dataset used
in the [Analytics on transport and geospatial data](https://docs.timescale.com/tutorials/latest/real-time-analytics-transport/) tutorial.

When following the tutorials, some commands may fail due to the default resource limits configured
for the TimescaleDB container.

See the **Troubleshooting** section below for some workarounds!

## 2. TimescaleDB Tutorials
### 2.1. Energy Consumption

Here are the first steps of the [Analytics on energy consumption](https://docs.timescale.com/tutorials/latest/real-time-analytics-energy-consumption/) tutorial.

Download and extract the dataset:

```sh
just extract-energy
```

Connect to the `timescaledb` database:

```shell
just psql
```

Create the `metrics` table:

```sql
CREATE TABLE "metrics"(
  created timestamp with time zone default now() not null,
  type_id integer                                not null,
  value   double precision                       not null
);
```

```
CREATE TABLE
```

Convert it to an hypertable:

```sql
SELECT create_hypertable('metrics', by_range('created'));
```

```
create_hypertable
-------------------
 (1,t)
(1 row)
```

Import the dataset:

```sql
\COPY metrics FROM /datasets/metrics.csv CSV;
```

```
COPY 2523726
```

Query the data with:

```sql
SELECT time_bucket('1 day', created, 'Europe/Berlin') AS "time",
round((last(value, created) - first(value, created)) * 100.) / 100. AS value
FROM metrics
WHERE type_id = 5
GROUP BY 1;
```

```
          time          | value
------------------------+-------
 2023-05-29 22:00:00+00 |  23.1
 2023-05-28 22:00:00+00 |  19.5
 2023-05-30 22:00:00+00 |    25
 2023-05-31 22:00:00+00 |   8.1
(4 rows)
```

Congratulations!
You can now proceed with the rest of the [Analytics on energy consumption](https://docs.timescale.com/tutorials/latest/real-time-analytics-energy-consumption/) tutorial.

## 3. Troubleshooting
### 3.1. Tuple decompression limit exceeded by operation

Error message when processing PostGIS data for the New York Yellow Cab dataset:

```
ERROR:  tuple decompression limit exceeded by operation
DETAIL:  current limit: 100000, tuples decompressed: 10906860
HINT:  Consider increasing timescaledb.max_tuples_decompressed_per_dml_transaction or set to 0 (unlimited).
```

Update the configuration with:

```sql
SET timescaledb.max_tuples_decompressed_per_dml_transaction TO 0;
```

Reference:

- [Troubleshooting - Compression - Tuple decompression limit exceeded by operation](https://docs.timescale.com/use-timescale/latest/compression/troubleshooting/#tuple-decompression-limit-exceeded-by-operation)

## 4. Reference
### 4.1. Getting Started
- [An Introduction to TimescaleDB](https://severalnines.com/blog/introduction-timescaledb/)

### 4.2. Tutorials
- [Tutorials](https://docs.timescale.com/tutorials/latest/)
- [Community Cookbook](https://docs.timescale.com/tutorials/latest/cookbook/)

### 4.3. Guides
- [Designing Your Database Schema: Wide vs. Narrow Postgres Tables](https://www.timescale.com/learn/designing-your-database-schema-wide-vs-narrow-postgres-tables)
- [Best Practices for Time-Series Data Modeling: Single or Multiple Partitioned Table(s) a.k.a. Hypertables](https://www.timescale.com/learn/best-practices-time-series-data-modeling-single-or-multiple-partitioned-tables-aka-hypertables)
- [Best Practices for (Time-)Series Metadata Tables](https://www.timescale.com/learn/best-practices-for-time-series-metadata-tables)

### 4.4. Docker
- [Install and configure TimescaleDB on PostgreSQL](https://docs.timescale.com/self-hosted/latest/install/installation-docker/)
- [timescale/timescaledb-docker-ha](https://github.com/timescale/timescaledb-docker-ha)
    - Based on Ubuntu, provides the [TimescaleDB Toolkit](https://github.com/timescale/timescaledb-toolkit)
    - Required to follow the tutorials
- [timescale/timescaledb-docker](https://github.com/timescale/timescaledb-docker)
    - Based on Alpine Linux
    - Minimal image
    - Not suitable to follow the tutorials

### 4.5. Integrations
- [Integrations](https://docs.timescale.com/use-timescale/latest/integrations/)
- [Grafana Integration](https://docs.timescale.com/use-timescale/latest/integrations/grafana/)
- [Get Started With TimescaleDB and Grafana](https://www.timescale.com/blog/get-started-with-timescale-and-grafana)
- [PostgreSQL data source](https://grafana.com/docs/grafana/latest/datasources/postgres/)
    - [PostgreSQL provisioning example](https://grafana.com/docs/grafana/latest/datasources/postgres/configure/#postgresql-provisioning-example)
