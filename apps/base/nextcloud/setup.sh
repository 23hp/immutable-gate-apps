#!/bin/sh
set -eu
echo "Running custom post-installation script..."
php occ maintenance:repair --include-expensive
# php -d memory_limit=512M ./occ app:install richdocumentscode