#!/usr/bin/env bash
# Check if newrelic should be installed
if [ ! -z "$NR_INSTALL_KEY" ]; then
    [ -z "$NR_APP_NAME" ] && NR_APP_NAME=app@`hostname`
    # check if already installed
    dpkg -s newrelic-php5 > /dev/null 2>&1 || ( \
    echo newrelic-php5 newrelic-php5/application-name string "$NR_APP_NAME" | DEBIAN_FRONTEND=noninteractive debconf-set-selections; \
    echo newrelic-php5 newrelic-php5/license-key string "$NR_INSTALL_KEY" | DEBIAN_FRONTEND=noninteractive debconf-set-selections; \
    dpkg -i /opt/newrelic-php5-common*.deb && \
    dpkg -i /opt/newrelic-daemon*.deb && \
    dpkg -i /opt/newrelic-php5_*.deb \
    );
fi