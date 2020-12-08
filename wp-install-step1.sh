#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status.
set -e

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install memcached -y
sudo apt install locate -y
sudo apt install telnet -y
sudo apt install git -y
sudo apt install rsync -y
sudo apt install curl git unzip zip -y
sudo apt install php-json php-gd -y
sudo apt autoremove



# Image procssing uils
sudo apt install libjpeg-progs  jpegoptim gifsicle optipng pngquant webp -y
sudo updatedb


sudo apt-get install php-pear php-dev
sudo apt-get -y install gcc make autoconf libc-dev pkg-config

sudo pecl channel-update pecl.php.net


# Install imagick
sudo apt-get -y install libmagickwand-dev
sudo pecl install imagick

#Install vips
sudo apt-get -y install libvips-dev
sudo pecl install vips
