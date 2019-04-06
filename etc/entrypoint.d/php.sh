#!/usr/bin/env bash

sed -ie "s/\(max_execution_time\ =\ \).*/\1$PHP_MAX_EXECUTION_TIME/" /etc/php/5.6/apache2/php.ini

# Configure opcache
cat << EOF > /etc/php/5.6/apache2/conf.d/10-opcache.ini
zend_extension=opcache.so

opcache.enable=$OPCACHE_ENABLE
opcache.fast_shutdown=$OPCACHE_FAST_SHUTDOWN
opcache.memory_comsuption=$OPCACHE_MEMORY_COMSUPTION
opcache.revalidate_path=$OPCACHE_REVALIDATE_PATH
opcache.max_accelerated_files=$OPCACHE_MAX_ACCELERATED_FILES
opcache.interned_strings_buffer=$OPCACHE_INTERNED_STRINGS_BUFFER
opcache.validate_timestamps=$OPCACHE_VALIDATE_TIMESTAMPS
opcache.revalidate_freq=$OPCACHE_REVALIDATE_FREQ
opcache.save_comments=$OPCACHE_SAVE_COMMENTS
EOF

# Configure apcu
cat << EOF > /etc/php/5.6/apache2/conf.d/20-apcu.ini
extension=apcu.so
apc.shm_size=$APC_SHM_SIZE
EOF

# Check if newrelic should be configured
if [[ ! -z "$NR_INSTALL_KEY" ]] && [[ ! -f /etc/php/5.6/apache2/conf.d/20-newrelic.ini ]]; then
    [ -z "$NR_APP_NAME" ] && NR_APP_NAME=app@`hostname`
    cat << EOF > /etc/php/5.6/mods-available/newrelic.ini
extension = "newrelic.so"

[newrelic]
newrelic.license = "$NR_INSTALL_KEY"
newrelic.logfile = "/dev/stderr"
newrelic.appname = "$NR_APP_NAME"
newrelic.daemon.logfile = "/dev/stderr"

EOF
    ln -s /etc/php/5.6/mods-available/newrelic.ini /etc/php/5.6/apache2/conf.d/20-newrelic.ini
fi
# end newrelic configuration
