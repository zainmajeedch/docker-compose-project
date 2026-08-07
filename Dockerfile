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
    curl \
    unzip \
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

# Download Composer installer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

# Verify installer
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); exit(1); }"

# Install Composer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Remove installer
RUN php -r "unlink('composer-setup.php');"

# Verify installation
RUN composer --version

CMD ["php-fpm"]
