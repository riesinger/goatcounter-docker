# Goatcounter in Docker

This is an unofficial Docker image for [Goatcounter](https://goatcounter.com), heavily based on
[baethon/docker-goatcounter](https://github.com/baethon/docker-goatcounter), but adapted to use
Goatcounter v2.

## How to use this image

```sh
docker run --name goatcounter \
  -p 8080:8080 \
  -v $(pwd)/db:/goatcounter/db \
  -e GOATCOUNTER_DOMAIN=stats.domain.com \
  -e GOATCOUNTER_EMAIL=admin@domain.com \
  -e GOATCOUNTER_PASSWORD=pa55w0rd \
  ghcr.io/riesinger/goatcounter-docker:2
```

## Environment variables

### `GOATCOUNTER_DOMAIN` · _Mandatory_

This variable is used to create the initial site. Set this to the domain you want to run Goatcounter
on.

### `GOATCOUNTER_EMAIL` · _Mandatory_

Defines the email address of the admin user. Used to sign in.

### `GOATCOUNTER_PASSWORD` · _Mandatory_

The password to use for the admin account. It is recommended to not pass this on the CLI but to read
it from a file, for example using `docker-compose`.

### `GOATCOUNTER_SMTP` · _Optional_

Sets the SMTP server to be used by the server to send emails.

Example: `smtp://user:pass@server.com:587`
Default: stdout - print email contents to stdout

### `GOATCOUNTER_DB` · _Optional_

The database to use. By default, the server will use an SQLite database which is the easiest
solution.
Note that this image isn't tested for usage with PostgreSQL, but it _should_ work fine.

For persistence when using SQLite, make sure to mount a volume into `/goatcounter/db`, for example
with `docker run -v $(pwd)/db:/goatcounter/db ...`

Default: `sqlite:///goatcounter/db/goatconter.sqlite3`

