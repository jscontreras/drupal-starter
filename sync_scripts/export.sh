#!/bin/bash

# Set the paths to the shared folder and the Drupal root directory
SHARED_FOLDER="/opt/drupal/sync_scripts"
DRUPAL_ROOT="/opt/drupal/web"

# # Prevent Algolia API info from possible keys exposure
# # Replace Algolia API_KEY APP_ID values
# drush config-set "search_api.server.algolia" "backend_config.application_id" APPK3YH3R3 -y
# drush config-set "search_api.server.algolia" "backend_config.api_key" 1sn0t4s3cur3k3yt0putcr3d3nt14lsh -y
# drush cr

# Export the Drupal config files
cd $DRUPAL_ROOT
drush config:export --destination=$SHARED_FOLDER/config -y

# Dump the database to a file
drush sql-dump --result-file=$SHARED_FOLDER/db/db.sql

# # Reload valid Algolia API Configuration
# drush config-set "search_api.server.algolia" "backend_config.application_id" $ALGOLIA_APP_ID -y
# drush config-set "search_api.server.algolia" "backend_config.api_key" $ALGOLIA_API_KEY -y
# drush cr