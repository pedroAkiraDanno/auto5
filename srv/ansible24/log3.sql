/************************************************#
# NAME      : log3.sql                           #
# objective  : Script to test log name and size  #
# CREATION   : 26-05-2022                        #
# VERSION    : 1.0                               #
# AUTHOR     : Pedro Akira Danno Lima            #
#************************************************/


\timing
\pset pager off
\pset border 2


--show all settings about log
select name,setting,unit from pg_settings where name like '%log%';


/*
-- or can use this too

    root@instance-20220524-1858:~# find / -name postgresql.conf
    postgres@instance-20220524-1858:~$ cat /etc/postgresql/14/main/postgresql.conf | grep log


*/


--confuguration log files 
 ALTER SYSTEM SET log_duration=on;
 ALTER SYSTEM SET log_executor_stats=on;
 ALTER SYSTEM SET log_hostname=on;
 ALTER SYSTEM SET log_parser_stats=on;
 ALTER SYSTEM SET log_planner_stats=on;
 ALTER SYSTEM SET log_replication_commands=on;
 ALTER SYSTEM SET wal_log_hints=on;

 ALTER SYSTEM SET log_checkpoints=on;
 ALTER SYSTEM SET log_connections=on;
 ALTER SYSTEM SET log_disconnections=on;
 ALTER SYSTEM SET log_lock_waits=on;
 ALTER SYSTEM SET log_truncate_on_rotation=on;
 ALTER SYSTEM SET logging_collector=on;

 ALTER SYSTEM SET  log_temp_files=0;

--configurate log files 
ALTER SYSTEM SET  log_filename ='server_log.%F_%T';
ALTER SYSTEM SET  log_rotation_size = 10240; --https://postgresqlco.nf/doc/en/param/log_rotation_size/
SELECT pg_reload_conf();


--show all settings about log
select name,setting,unit from pg_settings where name like '%log%';

--reboot postgresql 
--sudo  systemctl restart postgresql

--will generate a new log file immediately in a pg_log directory.
--direcoty /var/lib/postgresql/14/main/log/
SELECT *FROM pg_rotate_logfile();

--
-- ls -lath /var/lib/postgresql/14/main/log/






/*
EXEC OR TEST 

    cd /var/lib/postgresql/scripts/
    vi log3.sql
    psql -U postgres  -a -f /var/lib/postgresql/scripts/log3.sql

    rm log3.sql
    cd ~


*/















/* 
REFES:

    https://help.deepsecurity.trendmicro.com/11_3/aws/postgresql-tuning.html
    https://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html
    https://www.dbrnd.com/2017/02/postgresql-pg_rotate_logfile-to-switch-and-rotate-the-server-log-file-pg_log/
    https://postgresqlco.nf/doc/en/param/log_rotation_age/?category=reporting-and-logging
    https://www.postgresql.org/docs/14/runtime-config-logging.html#GUC-LOG-ROTATION-AGE




*/



