#!/bin/sh

set -eu

migrate_db ()
{
  goatcounter db \
    -createdb \
    -db "$GOATCOUNTER_DB" \
    migrate all
}

create_site ()
{
  goatcounter db site create \
    -vhost "$GOATCOUNTER_DOMAIN" \
    -user.email "$GOATCOUNTER_EMAIL" \
    -user.password "$GOATCOUNTER_PASSWORD" \
    -db "$GOATCOUNTER_DB"
}

echo "Starting migrations"
migrate_db
echo "Migrations done"

if ! create_site; then
  # stupid way to silence the errors created by the command
  # we should ignore only 'zdb.TX fn: cname: already exists.'
  /bin/true
fi

exec "$@"
