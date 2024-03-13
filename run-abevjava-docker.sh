#!/bin/sh

set -eu

USERDATADIR="$1"
COMMITHASH=$(git rev-parse --short=8 HEAD)

# create `eKuldes` directory too, so that the installer doesn't ask to create it
mkdir -p $USERDATADIR/eKuldes

xhost + # allow all connections
docker run --rm -it -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$USERDATADIR:/root/abevjava" "abevjava:$COMMITHASH"
xhost - # disallow connections again, for security. TODO: do this better.
