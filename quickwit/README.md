# Quickwit

## Set up MinIO

MinIO provides an object storage API to store files, and is compatible with the
AWS S3 API.

We will use MinIO to persist Quickwit indexes in a dedicated bucket.

Set up a password for the `quickwit-admin` account:

```shell
$ vim .env

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

Set the access and secret keys:

```
$ vim .env

MINIO_AWS_ACCESS_KEY_ID=<access key>
MINIO_AWS_SECRET_ACCESS_KEY=<secret key>
```

## Start Quickwit

Quickwit is a search an analytics engine, that is suited to indexing application
logs and traces.

```shell
$ docker compose up -d quickwit
```

## Resources
### Quickwit
- [Node Configuration](https://quickwit.io/docs/configuration/node-config)
- [Index Configuration](https://quickwit.io/docs/configuration/index-config)
- [Metastore Configuration](https://quickwit.io/docs/configuration/metastore-config)

### MinIO
- [Web Console](https://min.io/docs/minio/linux/administration/minio-console.html)
- [Command-line client](https://min.io/docs/minio/linux/reference/minio-mc.html)
