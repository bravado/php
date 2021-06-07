#!/usr/bin/env bash

[[ -z "$APACHE_ALIASES" ]] && exit 0

IFS=\; read -a aliases <<< "$APACHE_ALIASES"

for alias in "${aliases[@]}"; do
	echo "Alias ${alias//\ /\ $APACHE_DOCUMENT_ROOT}" >> /etc/apache2/sites-enabled/001-alias.conf
done
