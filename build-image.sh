#!/bin/sh

if [ "x$(uname)" = "xLinux" ]; then
    echo '`docker build` needs `sudo`' # not on macOS, though
    sudo docker build -t abevjava -f Dockerfile .
else
    docker build -t abevjava -f Dockerfile .
fi
