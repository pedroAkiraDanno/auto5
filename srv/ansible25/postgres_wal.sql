--POSTGRESQL WAL FILES 

\timing
\pset pager off

--qtd wal files in pg_wal - /var/lib/postgresql/14/main/pg_wal
SELECT COUNT(*) FROM pg_ls_dir('pg_wal') WHERE pg_ls_dir ~ '^[0-9A-F]{24}';
--SELECT COUNT(*) FROM pg_ls_dir('pg_wal');

--show setting about wal and archive 
select name,context,setting,unit,reset_val from pg_settings where  name like '%wal%' or name like '%archive%' order by setting,name;

--Get current WAL filename
SELECT pg_walfile_name(pg_current_wal_lsn());

-- switch wal file
select pg_switch_wal();

--size 
select sum(size) from pg_ls_waldir();


--NEED EXEC THIS COMMAND IN LINUX TO MONIT
select  'watch ls -lath /var/lib/postgresql/14/main/pg_wal/';



--TEST WAL FILES  
CREATE TABLE IF NOT EXISTS randomtbl(
   NAME           TEXT 
);

do
$do$
declare
     i int;
begin
for  i in 1..10000000
loop
            INSERT INTO randomtbl (NAME) SELECT MD5(random()::text);         
end loop;
end;
$do$;

do
$do$
declare
     i int;
begin
for  i in 1..10000000
loop
            INSERT INTO randomtbl (NAME) SELECT MD5(random()::text);         
end loop;
end;
$do$;




--pg_sleep
SELECT clock_timestamp(), pg_sleep(10);

--DELETE --truncate is fast than delete 
--DELETE FROM randomtbl;
TRUNCATE randomtbl;

--vacuum
vacuum randomtbl;

--DROP
drop table randomtbl;




/*
Layout of Databases files: 
/var/lib/postgresql/
/var/lib/postgresql/14/main/base
/var/lib/postgresql/14/main/pg_wal
*/



/*
references: 

*/
