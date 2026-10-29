#!/usr/bin/env bash
set -euo pipefail

mvn install
mvn package
mvn compile
mvn spring-boot:run
mvn versions:display-dependency-updates
mvn versions:display-plugin-updates
mvn versions:update-properties

# Run a jar in the background after replacing the file name.
# nohup java -jar app.jar > app.log 2>&1 &
# pgrep -af 'java -jar'
# kill <pid>
