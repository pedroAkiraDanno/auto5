	today=$(date +"%Y-%m-%d-%H%M%S")
	pgbadger  /var/lib/postgresql/15/main/log/server* -O  /var/lib/postgresql/pgbadger/ -o /var/lib/postgresql/pgbadger/pgbadger_$today.html
