#!/bin/sh

USERDATADIR=$1

if [ "x$USERDATADIR" == "x" ]; then
    echo "Please specify the user data directory as an argument to this script.";
    exit 1;
fi

# create `eKuldes` directory too, so that the installer doesn't ask to create it
mkdir -p $USERDATADIR/eKuldes
xhost + # allow all connections
docker run -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $USERDATADIR:/root/abevjava --rm -it abevjava
xhost - # disallow connections again, for security. TODO: do this better.
