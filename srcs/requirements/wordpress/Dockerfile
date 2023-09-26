FROM alpine:3.17.5
ARG PHP_VERSION=81  \
    DB_NAME         \
    DB_ROOT         \
    DB_USER         \
    DB_PASS         \
    WPADUSER        \
    WPADPASS        \
    WPUSER1         \
    WPUSER1PASS

# Update the package repository, upgrade installed packages, and install PHP and some PHP extensions
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    wget \
    curl \
    php-phar \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php81/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar && php wp-cli.phar --info \
  && cp wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

COPY ./requirements/wordpress/conf/wp-config-create.sh .
COPY ./requirements/wordpress/conf/setup.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/setup.sh
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

CMD ["/usr/local/bin/setup.sh"]