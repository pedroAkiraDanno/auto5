sudo -S <<< "postgres" systemctl stop postgresql

rm /var/lib/postgresql/15/main/* -r
sleep 3
pgbackrest --stanza=pgbackrest --delta restore   

sudo -S <<< "postgres" systemctl start postgresql