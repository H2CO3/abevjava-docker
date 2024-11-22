#!/bin/bash

set -eu

JAR_PATH="/root/utils/jars"

java -jar "$JAR_PATH/abevjava_install.jar"

for jar_file in $(ls "$JAR_PATH/templates"/*.jar | sort); do
    if [ -f "$jar_file" ]; then
        echo "Executing: $jar_file"
        java -jar "$jar_file"
    fi
done
