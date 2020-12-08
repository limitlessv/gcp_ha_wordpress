#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status.
set -e

readonly DATESTAMP=$(date +"%Y%m%d-%H%M%S")

sudo cp /etc/php/7.4/fpm/php.{ini,backup.${DATESTAMP}}
sudo cp /etc/php/7.4/cli/php.{ini,backup.${DATESTAMP}}

sudo cat /opt/limitlessv/scripts/php.mod >>  /etc/php/7.4/fpm/php.ini
sudo cat /opt/limitlessv/scripts/php.mod >>  /etc/php/7.4/cli/php.ini
