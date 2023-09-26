#!/bin/sh

wp --allow-root --path=/var/www core install \
  --url="$DOMAIN_NAME" \
  --title="Germans WordPress" \
  --admin_user="$WPADUSER" \
  --admin_password="$WPADPASS" \
  --admin_email="gchernys@student.42abudhabi.ae"

wp user create "$WPUSER1" "user1@student.42abudhabi.ae" \
  --role=author \
  --user_pass="$WPUSER1PASS" \
  --allow-root

wp --allow-root --path=/var/www option update blogname "Germans WordPress"
wp --allow-root --path=/var/www option update blogdescription "The Inception of Things"
wp --allow-root --path=/var/www option update blog_public 0

wp theme install twentytwentyone --activate --allow-root

wp plugin update --all --allow-root

/usr/sbin/php-fpm81 -F