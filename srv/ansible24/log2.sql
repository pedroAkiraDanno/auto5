/************************************************#
# NAME      : log2.sql                           #
# objective  : Script to log maintenance         #
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
    root@instance-20220524-1858:~# sudo find / -name pg\*.conf
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

--configurate log files about size rotation and files log names 
ALTER SYSTEM SET  log_filename ='server_log.%a';
ALTER SYSTEM SET  log_rotation_size = 500000 ; --500MB 500000KB --1GB 1048576  --https://postgresqlco.nf/doc/en/param/log_rotation_size/      
    --Default:10240 (10MB)
    --Max:2097151 (2097151kB)
    --Unit:KB
    --Restart:false
--grep log_rotation_age ${PGDATA}/postgresql.conf    
--RESET log_rotation_age; --or SET log_rotation_age TO DEFAULT;
SELECT pg_reload_conf();


--show all settings about log
select name,setting,unit from pg_settings where name like '%log%';

--reboot postgresql 
--sudo  systemctl restart postgresql

--will generate a new log file immediately in a pg_log directory.
--direcoty /var/lib/postgresql/14/main/log/
--SELECT *FROM pg_rotate_logfile();

--
-- ls -lath /var/lib/postgresql/14/main/log/


--directorys 
--  ls -lath /var/log/postgresql
-- ls -lath /var/lib/postgresql/14/main/log/

---SHOW CURRENT FILE 
--cd /var/lib/postgresql/14/main
--cat current_logfiles



/*
SHOW ALL
The SHOW ALL command displays the current setting of run-time parameters in 3 columns.

SHOW ALL ;

*/


/*
postgresql.auto.conf VS postgresql.conf

postgresql.auto.conf
A configuration file located in the data directory which stores configuration settings generated via PostgreSQL
postgresql.auto.conf is a configuration file with the same format as postgresql.conf, but which is located in the data directory and is managed by PostgreSQL itself (via the ALTER SYSTEM command) or client applications (e.g. pg_basebackup in PostgreSQL 12 and later). Normally it should not be edited manually.

postgresql.auto.conf is always evaluated last, so configuration settings stored here will always override settings in other files.

https://pgpedia.info/p/postgresql-auto-conf.html#:~:text=postgresql.-,auto.,should%20not%20be%20edited%20manually.
*/





/*
little explain 


Logging settings
By default, PostgreSQL log files are not rotated, which can lead to the log files using a large amount of disk space. When using PostgreSQL with Deep Security, we recommend that you use these four parameters in the postgresql.conf file to configure log rotation:

log_filename
log_rotation_age
log_rotation_size
log_truncate_on_rotation
log_rotation_age and log_rotation_size control when a new log file is created. For example, setting log_rotation_age to 1440 will create a new log file every 1440 minutes (1 day), and setting log_rotation_size to 10000 will create a new log file when the previous one reaches 10 000 KB.

log_filename controls the name given to every log file. You can use time and date format conversion in the name. For a complete list, see http://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html.

When log_truncate_on_rotation is set to "on", it will overwrite any log file that has the same name as a newly created log file.

There are several combinations of parameters that you can use to achieve a log rotation to suit your requirements. Here is one example:

log_filename = 'postgresql-%a.log' (every log file has the first 3 letters of the weekday in its name)
log_rotation_age = 1440 (a new log file is created daily)
log_rotation_size = 0. (setting is disabled to prevent the overwriting of the daily log file every time this limit is exceeded)
log_truncate_on_rotation = on (enable log file overwrite)




*/






/*


log_rotation_age (integer)
When logging_collector is enabled, this parameter determines the maximum lifetime of a single log file, and then a new log file is created. If this value is specified without units, it is taken as minutes. The default is 24 hours. You can set it to zero to disable the time-based generation of new log files.

log_rotation_size (integer)
When logging_collector is enabled, this parameter determines the maximum size of a single log file. After this amount of data is sent to a log file, a new log file will be created. If this value is specified without units, it is taken in kilobytes. The default value is 10 megabytes. You can set it to zero to disable the creation of new log files based on size.

log_truncate_on_rotation (boolean)
When logging_collector is enabled, this parameter causes PostgreSQL to truncate (overwrite) instead of appending it to any existing log file with the same name.


https://dbtut.com/index.php/2021/03/03/postgresql-conf-settings-in-postgresql/
*/






/*
EXEC OR TEST 

    cd /var/lib/postgresql/scripts/
    vi log2.sql
    psql -U postgres  -a -f /var/lib/postgresql/scripts/log2.sql

    rm log2.sql
    cd ~


*/















/* 
REFES:

    https://help.deepsecurity.trendmicro.com/11_3/aws/postgresql-tuning.html
    https://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html
    https://www.dbrnd.com/2017/02/postgresql-pg_rotate_logfile-to-switch-and-rotate-the-server-log-file-pg_log/
    https://postgresqlco.nf/doc/en/param/log_rotation_age/?category=reporting-and-logging




*/



