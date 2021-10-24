#!/bin/bash

heroku builds:cache:purge -a mac-and-cheese-admin --confirm mac-and-cheese-admin
git commit --allow-empty -m "Purge cache"
git push heroku HEAD:master













