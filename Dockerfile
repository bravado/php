FROM bravado/debian:stretch

USER root

# add non-free repository
RUN echo "deb http://http.us.debian.org/debian stretch contrib non-free" >> /etc/apt/sources.list

# add php repository
RUN curl -L https://packages.sury.org/php/apt.gpg | apt-key add - \
	&& echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list

# add newrelic repository
RUN curl https://download.newrelic.com/548C16BF.gpg | apt-key add - \
	&& echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' > /etc/apt/sources.list.d/newrelic.list

# Update the package lists and install everything
RUN apt-get update && \
  DEBIAN_FRONTEND="noninteractive" apt-get upgrade -y && \
  DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends  \
    apache2 \
    libapache2-mod-php5.6 \
    php5.6-apcu \
    php5.6-bz2 \
    php5.6-cli \
    php5.6-curl \
    php5.6-gd \
    php5.6-ldap \
    php5.6-memcache \
    php5.6-mysqlnd \
    php5.6-mbstring \
    php5.6-imagick \
    php5.6-imap \
    php5.6-intl \
    php5.6-pgsql \
    php5.6-redis \
    php5.6-soap \
    php5.6-sqlite3 \
    php5.6-xml \
    php5.6-zip \
    php5.6 \
    python \
    newrelic-daemon newrelic-php5 newrelic-php5-common \
    ssmtp \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*.log

# Set the default timezone in cli and fpm configs
# Setup logging to stderr
# Enable apache modules
RUN a2enmod actions expires headers rewrite proxy setenvif \
    && sed -ie 's/\;date\.timezone\ \=/date\.timezone\ \=\ America\/Sao_Paulo/g' /etc/php/5.6/cli/php.ini \
    && sed -ie 's/\;date\.timezone\ \=/date\.timezone\ \=\ America\/Sao_Paulo/g' /etc/php/5.6/apache2/php.ini \
    && sed -ie 's/${APACHE_LOG_DIR}\/error.log/\/proc\/self\/fd\/2/' /etc/apache2/apache2.conf \
    && rm /etc/apache2/conf-enabled/other-vhosts-access-log.conf \
    && rm /etc/php/5.6/apache2/conf.d/20-newrelic.ini \
    && rm /var/www/html/index.html

RUN usermod -a -G www-data app; chown -R app /var/www

# container parameters that may be set at runtime
ENV NR_APP_NAME ""
ENV NR_INSTALL_KEY ""

# Apache vars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_CONF_DIR /etc/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_DOCUMENT_ROOT /var/www/html

# PHP vars
ENV PHP_MEMORY_LIMIT 128M
ENV PHP_SESSION_SAVE_HANDLER files
ENV PHP_SESSION_SAVE_PATH /var/lib/php/sessions
ENV PHP_UPLOAD_MAX_FILESIZE 50M
ENV PHP_POST_MAX_SIZE 50M
ENV PHP_SHORT_OPEN_TAG On
ENV PHP_MAX_INPUT_VARS 1000
ENV PHP_MAX_EXECUTION_TIME 30

# Opcache
ENV OPCACHE_ENABLE 1
ENV OPCACHE_FAST_SHUTDOWN 0
ENV OPCACHE_MEMORY_COMSUPTION 64
ENV OPCACHE_REVALIDATE_PATH 1
ENV OPCACHE_MAX_ACCELERATED_FILES 7963
ENV OPCACHE_INTERNED_STRINGS_BUFFER 4
ENV OPCACHE_VALIDATE_TIMESTAMPS 1
ENV OPCACHE_REVALIDATE_FREQ 15
ENV OPCACHE_SAVE_COMMENTS 1

ENV APC_SHM_SIZE 128M
# end of parameters

EXPOSE 80

ENV SMTP_SERVER mailout
ENV SMTP_USER ""
ENV SMTP_PASS ""
ENV SMTP_METHOD LOGIN

ADD etc /etc

WORKDIR /var/www

USER app
