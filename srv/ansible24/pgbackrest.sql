alter system set archive_mode to 'on';
alter system set archive_command to 'pgbackrest --stanza=pgbackrest archive-push %p';



select pg_reload_conf();
select pg_switch_wal();
select pg_switch_wal();