#!/usr/bin/env bash

# Check if newrelic should be configured
if [[ ! -z "$NR_INSTALL_KEY" ]] && [[ ! -f /etc/php/7.4/apache2/conf.d/20-newrelic.ini ]]; then
    [ -z "$NR_APP_NAME" ] && NR_APP_NAME=app@`hostname`
    cat << EOF > /etc/php/7.4/mods-available/newrelic.ini
extension = "newrelic.so"

[newrelic]
newrelic.license = "$NR_INSTALL_KEY"
newrelic.logfile = "/dev/stderr"
newrelic.appname = "$NR_APP_NAME"
newrelic.daemon.logfile = "/dev/stderr"

EOF
    ln -s /etc/php/7.4/mods-available/newrelic.ini /etc/php/7.4/apache2/conf.d/20-newrelic.ini
fi
# end newrelic configuration
