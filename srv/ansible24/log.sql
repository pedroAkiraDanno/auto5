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


ALTER SYSTEM SET  log_rotation_size = '1000';
ALTER SYSTEM SET  log_filename ='server_log.%a';
ALTER SYSTEM SET  log_rotation_age = 1440;

SELECT pg_reload_conf();





