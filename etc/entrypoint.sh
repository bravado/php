#!/bin/bash

# Delete old pid files
/usr/bin/find /var/run/ -type f -name '*.pid' -delete

# Run init.d
for i in /init.d/*.sh; do
    bash $i
done

# Start supervisord
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
