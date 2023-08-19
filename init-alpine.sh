#!/bin/bash

set -euxo pipefail

# Update package
apk -U upgrade

# Installing docker
touch /etc/network/interfaces
apk add openrc docker
openrc default
service docker start
sleep 1
