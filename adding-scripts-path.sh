#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status.
set -e

echo "# The next line updates PATH for the WP248 scripts." >> /etc/profile
echo "# added by limitlessv script" >> /etc/profile
echo "if [ -f '/opt/limitlessv/scripts/path.bash.inc' ]; then . '/opt/limitlessv/scripts/path.bash.inc'; fi" >> /etc/profile

source /opt/limitlessv/scripts/path.bash.inc
