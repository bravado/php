#!/usr/bin/env bash

if [[ ! -z "$APACHE_ALIASES" ]]; then

	IFS=\; read -a aliases <<< "$APACHE_ALIASES"

	for alias in "${aliases[@]}"; do
		echo "Alias ${alias//\ /\ $APACHE_DOCUMENT_ROOT}" >> /etc/apache2/sites-enabled/001-alias.conf
	done
fi
