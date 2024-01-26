#!/bin/bash

export _JAVA_OPTIONS='-Dsun.java2d.xrender=false’
java -jar /root/utils/abevjava_install.jar && java -jar /root/utils/igazol.jar
