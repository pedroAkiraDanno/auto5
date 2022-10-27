alter system set archive_mode to 'on';
alter system set archive_command to 'cp %p /postgresql/archive/%f';
alter system set max_connections to 1000;


select pg_reload_conf();
select pg_switch_wal();
select pg_switch_wal();