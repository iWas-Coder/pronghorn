#!/bin/sh

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Executed without arguments (user, token)"
  exit 1
fi
USER="$1"
TOKEN="$2"

. ./env.sh

buildah push --creds "$USER:$TOKEN" "$APP:$VERSION-$ARCH" docker://"$USER"/"$APP:$VERSION-$ARCH"
