#!/bin/bash

# Set the paths to the shared folder and the Drupal root directory
SHARED_FOLDER="/opt/drupal/sync_scripts"
DRUPAL_ROOT="/opt/drupal/web"

cd $DRUPAL_ROOT


# Import Database
drush sql:drop -y

drush sql:cli < $SHARED_FOLDER/db/db.sql
drush cr

# Import the Drupal config files
drush config:import --source=$SHARED_FOLDER/config -y
drush cr

# Load the Algolia API_KEY
drush config-set "search_api.server.algolia" "backend_config.application_id" $ALGOLIA_APP_ID -y
drush config-set "search_api.server.algolia" "backend_config.api_key" $ALGOLIA_API_KEY -y
drush cr


