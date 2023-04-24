#!/bin/bash

UUID=6178c2cf-1a27-4d32-9ee9-4c1d0ffdce01
CONFIG=/opt/drupal/web/config/config_dev

# Export the Drupal config files
cd /opt/drupal

echo 'memory_limit =2048M' >> /usr/local/etc/php/conf.d/docker-php-ram-limit.ini
php -r "echo ini_get('memory_limit').PHP_EOL;"

composer update
composer install

cd /opt/drupal/web
chmod 777 sites/default/default.settings.php

drush si demo_umami install_configure_form.enable_update_status_emails=NULL --db-url=$DRUPAL_DATABASE_USER:@DRUPAL_DATABASE_PASSWORD@db/$DRUPAL_DATABASE_NAME --account-pass=$DRUPAL_USER_PASSWORD --account-name=$DRUPAL_USER_NAME -y
drush config-set "system.site" uuid $UUID -y
drush cr

php -r "echo ini_get('memory_limit').PHP_EOL;"

# Import Backup DB & Config
# /opt/drupal/sync_scripts/import.sh


# Keep it running
# tail -f /dev/null