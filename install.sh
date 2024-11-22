#!/bin/bash
JAR_PATH="/root/utils/jars"

for jar_file in $(ls "$JAR_PATH"/*.jar | sort); do
    if [ -f "$jar_file" ]; then
        echo "Executing: $jar_file"
        java -jar "$jar_file"
    fi
done
