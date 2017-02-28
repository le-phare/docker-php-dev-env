FROM php:7.0-fpm

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    locales \
    git \
    ssh \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libmemcached-dev \
    zlib1g-dev \
    libicu-dev \
    libpq-dev \
    libssh2-1-dev \
    libxml2-dev \
    libmagickwand-dev  \
  && rm -rf /var/lib/apt/lists/*

RUN dpkg-reconfigure -f noninteractive locales \
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
  && echo 'fr_FR.UTF-8 UTF-8' >> /etc/locale.gen \
  && locale-gen

RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) intl mcrypt gd opcache mbstring zip pdo_pgsql pdo_mysql soap pgsql mysqli

# imagick module
RUN pecl install imagick && docker-php-ext-enable imagick

# ssh2 module
RUN pecl install ssh2-1.0 \
  && echo "extension=ssh2.so" > $PHP_INI_DIR/conf.d/ext-ssh2.ini

# Install Blackfire
RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
  && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
  && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
  && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
  && echo "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707" > $PHP_INI_DIR/conf.d/blackfire.ini

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

WORKDIR /var/www/html

# Config
COPY symfony.ini $PHP_INI_DIR/conf.d/
COPY symfony.pool.conf $PHP_INI_DIR/pool.d/
