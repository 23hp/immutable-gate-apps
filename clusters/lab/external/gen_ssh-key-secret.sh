#!/usr/bin/env bash
# This script generate/update flux's credential to pull external repository
set -euo pipefail

NAME=flux-ssh-key
OUT="./${NAME}.enc.yaml"

umask 077
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# 1. Generate Deploy Key
ssh-keygen -q -t ed25519 -N "" -C "$NAME" -f "$TMP/id"

# 2. Generate Secret -> SOPS encrypt -> export to file
mkdir -p "$(dirname "$OUT")"
kubectl create secret generic "$NAME" \
  --from-file=identity="$TMP/id" \
  --from-file=identity.pub="$TMP/id.pub" \
  --from-file=known_hosts="./known_hosts" \
  --dry-run=client -o yaml \
  | sops --encrypt --filename-override "$OUT" /dev/stdin > "$TMP/out.yaml"

mv "$TMP/out.yaml" "$OUT"

echo "Please add this public key to the external repository's Deploy Keys (Read-Only):"
cat "$TMP/id.pub"