#!/bin/sh

. ./env.sh

if [ ! -z "$1" ]; then
  VERSION="$1"
fi
if [ ! -z "$2" ]; then
  ARCH="$2"
fi

string="$(pwd)"
substr="/pronghorn/src/app"
if [ ! -z "${string##*$substr*}" ]; then
  echo "CWD is not in */pronghorn/src/app"
  exit 1
fi

container=$(buildah from --arch "$ARCH" node:14)
run="buildah run $container /bin/sh -c"

buildah copy $container . "/$APP"
buildah config --workingdir "/$APP" $container
$run "npm i --no-audit --no-fund --no-optional"
$run "npm run build"
buildah config --entrypoint "npm run start" $container
buildah commit --squash $container "$APP:$VERSION-$ARCH"
buildah rm $container && buildah rmi --prune && unset container
