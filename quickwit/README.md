# Quickwit
## Overview
Quickwit is a search an analytics engine, that is suited to indexing application
logs and traces.

We will run Quickwit along with:

- PostgreSQL to persist Quickwit index and task configuration
- MinIO to persist Quickwit index data in a S3-like bucket

## 1. Start and configure MinIO

MinIO provides an object storage API to store files, and is compatible with the
AWS S3 API.

Edit `.env` to set up a password for the `quickwit-admin` account:

```shell
MINIO_ROOT_PASSWORD=<your password goes here>
```

Start MinIO with:

```shell
$ docker compose up -d minio
```

Configure a bucket for Quickwit:

1. Go to http://localhost:9090/ to log in (username: `quickwit-admin`)
2. Go to http://localhost:9090/buckets
3. Create a bucket named `quickwit`

Configure an access and secret key for programmatic access:

1. Go to http://localhost:9090/access-keys
2. Create a new access key, and note the corresponding secret key

These keys will be used by Quickwit to store and retrieve indexed data from the
MinIO bucket.

Edit `.env` to set the access and secret keys:

```
MINIO_AWS_ACCESS_KEY_ID=<access key>
MINIO_AWS_SECRET_ACCESS_KEY=<secret key>
```

## 2. Start PostgreSQL and Quickwit

Start Quickwit with:

```shell
$ docker compose up -d quickwit
```

The Web interface will be available at http://localhost:7280

## Resources
### Quickwit
- [Node Configuration](https://quickwit.io/docs/configuration/node-config)
- [Index Configuration](https://quickwit.io/docs/configuration/index-config)
- [Metastore Configuration](https://quickwit.io/docs/configuration/metastore-config)

### MinIO
- [Web Console](https://min.io/docs/minio/linux/administration/minio-console.html)
- [Command-line client](https://min.io/docs/minio/linux/reference/minio-mc.html)
