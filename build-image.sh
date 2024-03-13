#!/bin/sh

set -eu

BUILDCTX="$1"
COMMITHASH=$(git rev-parse --short=8 HEAD)

docker build -t "abevjava:$COMMITHASH" -f Dockerfile "$BUILDCTX"
