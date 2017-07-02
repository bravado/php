#!/bin/bash

# Delete old pid files
/usr/bin/find /var/run/ -type f -name '*.pid' -delete

# Run entrypoint.d
for i in /etc/entrypoint.d/*.sh; do
    bash $i
done

# Start supervisord
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
