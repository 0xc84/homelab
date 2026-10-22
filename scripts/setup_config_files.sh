#!/bin/bash
set -euo pipefail

set -a # set exportall turn
source ./.env
set +a # set exportall off

NITTER_SECRETS_DIR=./secrets/nitter
NITTER_HMAC_KEY_FILE=$NITTER_SECRETS_DIR/.hmac_key

mkdir -p "$NITTER_SECRETS_DIR"

# nitter
[ -f "$NITTER_HMAC_KEY_FILE" ] || openssl rand -hex 32 > "$NITTER_HMAC_KEY_FILE"
export NITTER_HMAC_KEY=$(cat "$NITTER_HMAC_KEY_FILE")

envsubst '${NITTER_HMAC_KEY}' < ./config/nitter/nitter.template > ./config/nitter/nitter.conf
envsubst '${NITTER_HMAC_KEY}' < ./config/nitter/nitter_proxy.template > ./config/nitter/nitter_proxy.conf

# copyparty
envsubst '${COPYPARTY_MUKESH_PASSWORD} ${COPYPARTY_ANURAG_PASSWORD} ${COPYPARTY_AYAAN_PASSWORD}' \
  < ./config/copyparty/copyparty.template \
  > ./config/copyparty/copyparty.conf
