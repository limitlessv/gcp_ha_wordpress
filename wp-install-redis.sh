#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status.
set -e

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install gcc make autoconf libc-dev pkg-config -y
sudo apt-get install redis-server -y
