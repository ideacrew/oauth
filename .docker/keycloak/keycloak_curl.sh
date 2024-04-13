#!/bin/sh

set -e

HOST=`cat $1 | jq -r .host`
REALM=`cat $1 | jq -r .realm`
USERNAME=`cat $1 | jq -r .username`
PASSWORD=`cat $1 | jq -r .password`
CLIENTID=`cat $1 | jq -r .clientid`
CLIENTSECRET=`cat $1 | jq -r .client_secret`

# obtain OICD configuration from keycloak
curl -iv \
    http://$HOST/realms/$REALM/.well-known/openid-configuration

curl -iv \
    http://$HOST/realms/$REALM/protocol/openid-connect/auth \
    --data-urlencode scope="openid profile email" \
    --data-urlencode response_type=code \
    --data-urlencode client_id=$CLIENTID \
    --data-urlencode client_secret=$CLIENTSECRET \
    --data-urlencode redirect_uri=http://0.0.0.0:3000/accounts/openid_connect/callback

        # -H 'Content-Type: application/x-www-form-urlencoded' \
