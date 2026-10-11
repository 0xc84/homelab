#!/bin/bash

SECRETS_DIR=./secrets/nitter
HMAC_KEY_FILE=$SECRETS_DIR/.hmac_key

mkdir -p $SECRETS_DIR

[ -f $HMAC_KEY_FILE ] || openssl rand -hex 32 > $HMAC_KEY_FILE
export NITTER_HMAC_KEY=$(cat $HMAC_KEY_FILE)
envsubst '${NITTER_HMAC_KEY}' < ./config/nitter/nitter.template.conf > ./config/nitter/nitter.conf
envsubst '${NITTER_HMAC_KEY}' < ./config/nitter/nitter_proxy.template.conf > ./config/nitter/nitter_proxy.conf
