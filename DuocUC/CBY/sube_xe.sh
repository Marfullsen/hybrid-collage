lsnrctl start

sqlplus << EOF
/ as sysdba
startup
EOF
