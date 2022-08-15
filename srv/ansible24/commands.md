# commands: 

Ïmportant commands about postgresql  

---



begin: 




## POSTGRESQL log:
	postgres@instance-20220308-1903:~$ tail -200f /var/lib/postgresql/14/main/log/server_log.Wed
	postgres@instance-20220308-1903:~$ echo  tail -200f /var/lib/postgresql/14/main/log/server_log."`date +%a`"
	postgres@instance-20220308-1903:~$ tail -200f /var/lib/postgresql/14/main/log/server_log."`date +%a`"	


## PGBACKREST:
	postgres@instance-20220308-1903:~$ pgbackrest info
	postgres@instance-20220308-1903:~$ cat /etc/pgbackrest.conf


## POSTGRESQL: 
	postgres@instance-20220308-1903:~$  psql -U postgres -d test1 
	test1=# \x
	test1=# SELECT COUNT(*) FROM TEST1;
	--SIZE
	-- return bytes
	test1=# select pg_database_size('test1');
	test1=# select (pg_database_size('test1')/1024/1024) as database_size_MB;
	test1=# select (pg_database_size('test1')/1024/1024/1024) as database_size_GB;
	--table size
	test1=# SELECT  pg_size_pretty (pg_relation_size('public.test1'));

	postgres@instance-20220308-1903:~$  psql -U postgres -d pgbench
	pgbench=# \d
    	pgbench=#  \pset border 2
    	pgbench=#  \pset pager off
    	pgbench=#  \timing
	pgbench=#  select 'SELECT COUNT(*) ' || 'FROM ' || tablename || ';'   from pg_catalog.pg_tables where schemaname ='public';
	pgbench=# select *  from pgbench_accounts where false;
	pgbench=# \d+ pgbench_accounts 
	pgbench=# SELECT	column_name FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'pgbench_accounts';
	
	PASSWORD
	postgres=# ALTER USER postgres PASSWORD 'postgres';
	or
	postgres=#  \password

	CHECK TEMP FILES 
	postgres@instance-20220308-1903:~$ cd /var/lib/postgresql/14/main/base/pgsql_tmp
	postgres@instance-20220308-1903:~$ watch ls -lath 

	ACTIVE USERS CONNECTED TO A POSTGRESQL
	postgres=# SELECT count(*) FROM pg_stat_activity WHERE state = 'active';	
	postgres=# \x	
	postgres=# SELECT pid,datname,usename,application_name,client_hostname,client_port,backend_start,query_start,query,state FROM pg_stat_activity WHERE state = 'active';

	KILL ALL OTHER ACTIVE CONNECTIONS
    	pgbench=#  \pset border 2
    	pgbench=#  \pset pager off
    	pgbench=#  \timing
	postgres=# SELECT  pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE  pg_stat_activity.datname = 'test1' AND pid <> pg_backend_pid();
	postgres=# SELECT  pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE  pid <> pg_backend_pid();


	PostgreSQL: Show size of all databases
		postgres=# SELECT pg_database.datname as "database_name", pg_database_size(pg_database.datname)/1024/1024 AS size_in_mb FROM pg_database ORDER by size_in_mb DESC;
		#refe: https://makandracards.com/makandra/37935-postgresql-show-size-of-all-databases



## LINUX:
	root@instance-20220308-1903:/var/# sudo apt-get update && sudo apt-get upgrade -y
	root@instance-20220308-1903:/var/# apt list --upgradable

	PASSWORD
	root@instance-20220308-1903:/var/# sudo passwd postgres

	RESTART POSTGRESQL 
	root@instance-20220308-1903:~# systemctl restart postgresql

	TREE
	root@instance-20220308-1903:~# tree -L 5 /postgresql/

	LOG MAIL
	root@instance-20220308-1903:~# tail -200f /var/mail/postgres

	LOG syslog 
	root@instance-20220308-1903:~# tail -200f /var/log/syslog

	LOG APT
	root@instance-20220308-1903:~#  tail -200f  /var/log/apt/term.log

	SIZE 
 	root@instance-20220308-1903:~#  sudo du -sh /postgresql/
 	root@instance-20220308-1903:~#  sudo du -shc /postgresql/*
 	root@instance-20220308-1903:~#  sudo du -h --max-depth=2 /postgresql/
 	root@instance-20220308-1903:~#  sudo du -sh --apparent-size /postgresql/

	COUNT FILES 
 	root@instance-20220308-1903:~#  ls -l | wc -l
 	root@instance-20220308-1903:~#  find /postgresql/pgbackrest/archive/pgbackrest/14-1  -type f | wc -l

	INSTALL
	root@instance-20220308-1903:~#  dpkg --status postgresql
	root@instance-20220308-1903:~# /usr/include/postgresql
	root@instance-20220308-1903:~# which psql 



## LINUX about disks and size:





## PGMETRICS: 
	postgres@instance-20220308-1903:~$ pgmetrics --no-password
	postgres@instance-20220308-1903:~$  pgmetrics --no-password --all-dbs








end: