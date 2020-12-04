#!/usr/bin/env bash

SITE_DIR=/var/www/html/

# =============================================================================
# Functions
# =============================================================================

function is_file() {
	local file=$1
	[[ -f $file ]]
}

function is_dir() {
	local dir=$1
	[[ -d $dir ]]
}




function write_permissions {
    # Use it only for setup and update Wordfance plugin
    sudo chown -R www-data:www-data ${SITE_DIR};
    sudo find ${SITE_DIR} -type d -exec chmod 775 {} \;
    sudo find ${SITE_DIR} -type f -exec chmod 664 {} \;

    if [ -d "${SITE_DIR}/wp-content/wflogs/" ]; then
        sudo chmod -Rf 775 ${SITE_DIR}/wp-content/wflogs/;
    fi

    if [ -f "${SITE_DIR}/wp-config.php" ]; then
        sudo chmod 775 ${SITE_DIR}/wp-config.php;
    fi

    if [ -f "${SITE_DIR}/wordfence-waf.php" ]; then
        sudo chmod 775 ${SITE_DIR}/wordfence-waf.php;
    fi

    if [ -f "${SITE_DIR}/wflogs/config-synced.php" ]; then
        sudo chmod 775 ${SITE_DIR}/wflogs/config-synced.php;
    fi


    if [ -f "${SITE_DIR}/.user.ini" ]; then
        sudo chmod 775 ${SITE_DIR}/.user.ini;
    fi
}

function default_permissions {


	# Understand Bitnami WordPress Filesystem Permissions
	# https://docs.bitnami.com/google/apps/wordpress/administration/understand-file-permissions/
	sudo chown -R www-data:www-data ${SITE_DIR};
	sudo find ${SITE_DIR} -type d -exec chmod 775 {} \;
	sudo find ${SITE_DIR} -type f -exec chmod 664 {} \;
	sudo chmod 640 ${SITE_DIR}/wp-config.php;
}

#default_permissions;
write_permissions;
