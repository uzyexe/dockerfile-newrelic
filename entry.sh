#!/bin/sh -e

echo 'reconfigure nrsysmond'

nrsysmond-config --set license_key="$NEW_RELIC_LICENSE_KEY"

[ ! -z "$FORWARD_PROXY" ] && \
  sed -i "s/#proxy.*/proxy=$FORWARD_PROXY/g" /etc/newrelic/nrsysmond.cfg

cat /etc/newrelic/nrsysmond.cfg

exec "$@"
