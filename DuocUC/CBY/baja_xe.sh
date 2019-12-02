lsnrctl stop

sqlplus << EOF
/ as sysdba
shutdown immediate
EOF
