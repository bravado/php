cat << EOF > /etc/msmtprc
# Set default values for all following accounts.
defaults
port 587
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account smtp
auth $SMTP_METHOD
host $SMTP_SERVER
user $SMTP_USER
passwordeval echo \$SMTP_PASS

# Set a default account
account default : smtp
EOF
