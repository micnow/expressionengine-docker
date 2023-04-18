ARG PHP_VERSION=8.0.28-apache

FROM php:${PHP_VERSION}

ENV WORKDIR=/var/www/html
ENV EE_INSTALL_MODE=TRUE

WORKDIR ${WORKDIR}

# Basic Linux update and add few libraries
RUN apt-get update && apt-get install -y \
    apt-utils \
    zlib1g-dev \
    libzip-dev \
    unzip \
    wget \
    bsdtar \
&& rm -rf /var/lib/apt/lists/*

# Install extensions required by ExpressionEngine
RUN docker-php-ext-install mysqli pdo_mysql zip

# Copy zipped EE files to final destination
COPY resources/ExpressionEngine7.2.15.zip ${WORKDIR}/ExpressionEngine7.2.15.zip
RUN bsdtar --strip-components=1 -xvf ExpressionEngine7.2.15.zip && rm -f ExpressionEngine7.2.15.zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.0

# Install vendors
RUN composer install --ignore-platform-reqs --working-dir=${WORKDIR}

# Update files according to ExpressionEngine documentation
RUN touch ${WORKDIR}/system/user/config/config.php && rm -f ${WORKDIR}/.env.php
RUN find ${WORKDIR}/system/ee \( -type d -exec chmod 755 {} \; \) -o \( -type f -exec chmod 644 {} \; \)
RUN chmod 777 -R ${WORKDIR}/system/user/config ${WORKDIR}/system/user/cache ${WORKDIR}/themes/user ${WORKDIR}/system/user/templates

RUN usermod -u 1000 www-data

EXPOSE 7215
