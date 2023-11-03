#!/bin/bash
 export _JAVA_OPTIONS='-Dsun.java2d.xrender=false’
pushd /usr/share/abevjava;
./abevjava_start;
popd
