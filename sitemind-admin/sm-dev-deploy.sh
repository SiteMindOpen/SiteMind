#!/bin/bash

ls /var/www/html/sitemind > /tmp/deploy.temp

while read DIRECTORY
do

	rsync -av ~/sitemind-master/ /var/www/html/sitemind/$DIRECTORY

done </tmp/deploy.temp

chown -R www-data:www-data /var/www/html/sitemind && sudo chmod -R g+rw /var/www/html/sitemind

rm /tmp/deploy.temp
