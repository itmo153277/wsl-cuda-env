#!/bin/bash

set -euxo pipefail

# Update package
apk -U upgrade

# Installing docker
apk add openrc docker
openrc default
service docker start
sleep 1
