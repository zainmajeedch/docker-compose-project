FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libxslt1-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libbz2-dev \
    libgmp-dev \
    libldap2-dev \
    libpq-dev \
    libsqlite3-dev \
    libpspell-dev \
    aspell \
    aspell-en \
    libsnmp-dev \
    libtidy-dev \
    libenchant-2-dev \
&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
  && docker-php-ext-configure ldap \
  && docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    enchant \
    exif \
    ftp \
    gd \
    gettext \
    gmp \
    ldap \
    intl \
    mysqli \
    opcache \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    pspell \
    shmop \
    snmp \
    soap \
    sockets \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    xsl \
    zip


RUN pecl install redis \
    && docker-php-ext-enable redis


CMD ["php-fpm"]
