FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

ARG PHP_VERSION="7.2"

# Workaround: install runit separately when in non-interactive mode
RUN apt-get update \
    && apt-get -y install runit \
    && apt-get -y upgrade \
    && apt-get -y install \
        acl \
        ca-certificates \
        curl \
        git \
        nginx \
        software-properties-common \
        sudo \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update \
    && apt-get -y install \
        composer \
        ffmpeg \
        memcached \
        php${PHP_VERSION}-apcu \
        php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-bz2 \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-dev \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-gmp \
        php${PHP_VERSION}-imagick \
        php${PHP_VERSION}-imap \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-memcached \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-phpdbg \
        php${PHP_VERSION}-redis \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-zip \
        php-ssh2 \
        redis-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# update php-fpm socket name
RUN sed -i -r 's/^listen = \/run\/php\/php'${PHP_VERSION}'-fpm.sock/listen = \/run\/php\/php-fpm.sock/g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

COPY service /etc/service

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY runit_bootstrap /usr/sbin/runit_bootstrap
RUN chmod 755 /usr/sbin/runit_bootstrap \
    && chmod -R 755 /etc/service

ARG MAGENTO_VERSION=2.3

WORKDIR /var/www
RUN git clone https://github.com/magento/magento2.git -b ${MAGENTO_VERSION} magento \
    && cd magento \
    && composer install --no-dev --prefer-dist \
    && composer require --update-no-dev --prefer-dist mageplaza/magento-2-french-language-pack:dev-master \
    && chown -R www-data:www-data /var/www/magento
WORKDIR /var/www/magento

EXPOSE 80

CMD ["/usr/sbin/runit_bootstrap", "/etc/service"]
