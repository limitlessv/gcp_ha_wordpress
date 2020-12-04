#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status.
set -e

echo "# The next line updates PATH for the WP248 scripts." >> /etc/profile
echo "# added by wp248 script" >> /etc/profile
echo "if [ -f '/opt/wp248/scripts/path.bash.inc' ]; then . '/opt/wp248/scripts/path.bash.inc'; fi" >> /etc/profile

source /opt/wp248/scripts/path.bash.inc
