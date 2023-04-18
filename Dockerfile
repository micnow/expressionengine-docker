ARG PHP_VERSION=8.0.28-apache

FROM php:${PHP_VERSION}

ENV WORKDIR=/var/www/html
ENV EE_INSTALL_MODE=TRUE
ENV COMPOSER_ALLOW_SUPERUSER=1

# Basic Linux update and add few libraries
RUN apt-get update && apt-get install -y \
    apt-utils \
    zlib1g-dev \
    libzip-dev \
    unzip \
    wget \
&& rm -rf /var/lib/apt/lists/*

# Install extensions required by ExpressionEngine
RUN docker-php-ext-install mysqli pdo_mysql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.0

# Install vendors
#RUN composer install --ignore-platform-reqs --working-dir=${WORKDIR}

# Update files according to ExpressionEngine documentation
#RUN touch ${WORKDIR}/system/user/config/config.php && rm -f ${WORKDIR}/.env.php
#RUN find ${WORKDIR}/system/ee \( -type d -exec chmod 755 {} \; \) -o \( -type f -exec chmod 644 {} \; \)
#RUN chmod 777 -R ${WORKDIR}/system/user/config ${WORKDIR}/system/user/cache ${WORKDIR}/themes/user ${WORKDIR}/system/user/templates

RUN chown www-data:www-data -R ${WORKDIR}

RUN usermod -u 1000 www-data
WORKDIR ${WORKDIR}
EXPOSE 7215
