ARG PHP_VERSION=7.3.10-apache

FROM php:${PHP_VERSION}

ENV WORKDIR=/var/www/html
ENV EE_INSTALL_MODE=TRUE

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

# Get ExpressionEngine source files from GitHub
RUN wget https://github.com/ExpressionEngine/ExpressionEngine/archive/stability.zip -P ${WORKDIR}
RUN bsdtar --strip-components=1 -xvf stability.zip && rm -f stability.zip

# Update files according to ExpressionEngine documentation
RUN touch ${WORKDIR}/system/user/config/config.php && rm -f ${WORKDIR}/.env.php
RUN find ${WORKDIR}/system/ee \( -type d -exec chmod 755 {} \; \) -o \( -type f -exec chmod 644 {} \; \)
RUN chmod 777 -R ${WORKDIR}/system/user/config ${WORKDIR}/system/user/cache ${WORKDIR}/themes/user ${WORKDIR}/system/user/templates

WORKDIR ${WORKDIR}

RUN usermod -u 1000 www-data

EXPOSE 8080
