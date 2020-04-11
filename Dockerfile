ARG PHP_VERSION=7.3.10-apache

FROM php:${PHP_VERSION}

ENV WORKDIR=/var/www/html

# Basic Linux update and add few libraries
RUN apt-get update && apt-get install -y \
    apt-utils \
    zlib1g-dev \
    libzip-dev \
    unzip

# Install extensions required by ExpressionEngine
RUN docker-php-ext-install mysqli pdo_mysql zip

# Put ExpressionEngine source files into container
COPY ee-source/expressionengine-5-3.zip ${WORKDIR}
RUN unzip expressionengine-5-3.zip && rm -f expressionengine-5-3.zip

# Update files according to ExpressionEngine documentation
RUN find ${WORKDIR}/system/ee \( -type d -exec chmod 755 {} \; \) -o \( -type f -exec chmod 644 {} \; \)
RUN chmod 777 -R ${WORKDIR}/system/user/config ${WORKDIR}/system/user/cache ${WORKDIR}/themes/user ${WORKDIR}/system/user/templates

WORKDIR ${WORKDIR}

RUN usermod -u 1000 www-data

EXPOSE 8080
