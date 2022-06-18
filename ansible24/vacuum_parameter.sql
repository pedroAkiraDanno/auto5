
/* vacuum parameter*/

  \timing
  \pset pager off
  \pset border 2

  \l
  --\x 

  --show all settings about vacuum
  select name,setting,unit from pg_settings where name like '%vacuum%';





--Autovacuum may be disabled on certain tables
DROP DATABASE IF EXISTS vacuum_test;
CREATE DATABASE  vacuum_test TEMPLATE template0;
\c vacuum_test;

 

CREATE TABLE IF NOT EXISTS vacuum_table1 (id int ) with (autovacuum_enabled = off);
SELECT reloptions FROM pg_class WHERE relname='vacuum_table1';
--SELECT * FROM pg_class WHERE relname='vacuum_table1';
ALTER TABLE vacuum_table1 SET (autovacuum_enabled = true);
--drop table vacuum_table1;



--about databases and n_dead_tup
SELECT * FROM   pg_stat_database db;
SELECT relname, n_dead_tup FROM pg_stat_user_tables;



--Last time (auto)vacuum ran
SELECT relname, last_vacuum, last_autovacuum FROM pg_stat_user_tables;

select relname,last_vacuum, vacuum_count from pg_stat_all_tables where relname= 'vacuum_table1';

select relname,last_vacuum, last_autovacuum, last_analyze, last_autoanalyze from pg_stat_user_tables;

SELECT
  schemaname, relname,
  last_vacuum, last_autovacuum,
  vacuum_count, autovacuum_count  -- not available on 9.0 and earlier
FROM pg_stat_user_tables;



--Is autovacuum running?
--Grep System Process Status
--ps -axww | grep autovacuum
--Grep Postgres Log
--grep autovacuum /var/lib/postgresql/14/main/log/*
SELECT name, setting FROM pg_settings WHERE name='autovacuum';
select count(*) from pg_stat_activity where backend_type like 'autovacuum%';

CREATE OR REPLACE FUNCTION public.pg_autovacuum_count() RETURNS bigint
AS 'select count(*) from pg_stat_activity where backend_type like ''autovacuum%'';'
LANGUAGE SQL
STABLE
SECURITY DEFINER;

select pg_autovacuum_count();







-- SQL to check table statistics about the number of dead tuples
SELECT relname, n_live_tup, n_dead_tup, trunc(100*n_dead_tup/(n_live_tup+1))::float "ratio%",
to_char(last_autovacuum, 'YYYY-MM-DD HH24:MI:SS') as autovacuum_date, 
to_char(last_autoanalyze, 'YYYY-MM-DD HH24:MI:SS') as autoanalyze_date
FROM pg_stat_all_tables 
ORDER BY last_autovacuum;

--ref: https://aws.amazon.com/blogs/database/a-case-study-of-tuning-autovacuum-in-amazon-rds-for-postgresql/












--ABOUT PARAMETERS 
--enable to zero, enable log every about vacuum
alter system set log_autovacuum_min_duration TO 0; 


--autovacuum_max_workers
    --show all settings about vacuum
    select name,setting,unit from pg_settings where name like '%autovacuum_max_workers%';

    alter system set autovacuum_max_workers TO 7; 

    SELECT datname FROM pg_database WHERE datistemplate = false;
    SELECT count(*) FROM pg_database WHERE datistemplate = false;

    --ps -ef | grep autovacuum*
    --ps aux|grep autovacuum*|grep -v grep
    -- top -p <PID>
    -- top -Hp <PID>           --see theds 
    -- top -p <PID> -c -H      --see command

    select pg_reload_conf();
    --systemctl restart postgresql 

    --set the naptime to 5s to see the autovacuum_max_workers works 
    alter system set autovacuum_naptime TO 3;  


    --create a tables
    CREATE TABLE IF NOT EXISTS rand AS SELECT generate_series(1, 100) AS seq, MD5(random()::text);
    CREATE TABLE IF NOT EXISTS rand2 AS SELECT generate_series(1, 100) AS seq, MD5(random()::text);
    CREATE TABLE IF NOT EXISTS rand3 AS SELECT generate_series(1, 100) AS seq, MD5(random()::text);
    CREATE TABLE IF NOT EXISTS rand4 (seq int,md5 text);
    INSERT INTO rand4 (seq) SELECT x % 2 + 1 FROM generate_series(1,100) AS x;


    --select the size
    select pg_size_pretty(pg_relation_size('rand')), pg_size_pretty(pg_relation_size('rand2')),pg_size_pretty(pg_relation_size('rand3')),pg_size_pretty(pg_relation_size('rand4'));

    --update the statiscs and see pg_stat_all_tables about tables 
    ANALYZE VERBOSE rand,rand2,rand3,rand4;
    select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%rand%';




    --updates tables
    update rand set seq = seq+1;

    UPDATE rand2 set seq = seq +1 WHERE seq%2 = 0;
    --DELETE FROM rand2;

    UPDATE rand3 set seq = seq +1 WHERE seq%2 = 1;
    --DELETE FROM rand3;

    UPDATE rand4 set seq = seq +1;
    --DELETE FROM rand4;

    --select the size
    select pg_size_pretty(pg_relation_size('rand')), pg_size_pretty(pg_relation_size('rand2')),pg_size_pretty(pg_relation_size('rand3')),pg_size_pretty(pg_relation_size('rand4'));


    --Getting statistics of all databases
    -- ANALYZE;
    --Getting statistics of a specific database
    --ANALYZE VERBOSE;
    --Getting the statistics of a table
    --ANALYZE VERBOSE rand;
    ANALYZE VERBOSE rand,rand2,rand3,rand4;

    select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%rand%';



    select pg_sleep(2);
    --vacuum rand;

    select pg_sleep(2);
    vacuum ;
    VACUUM(FULL, ANALYZE, VERBOSE) rand2;
    VACUUM(ANALYZE, VERBOSE) rand2;


    --select the size
    select pg_size_pretty(pg_relation_size('rand')), pg_size_pretty(pg_relation_size('rand2')),pg_size_pretty(pg_relation_size('rand3')),pg_size_pretty(pg_relation_size('rand4'));


    ANALYZE VERBOSE rand,rand2,rand3,rand4;

    select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%rand%';



    --updates tables
    update rand set seq = seq+1;

    UPDATE rand2 set seq = seq +1 WHERE seq%2 = 0;
    --DELETE FROM rand2;

    UPDATE rand3 set seq = seq +1 WHERE seq%2 = 1;
    --DELETE FROM rand3;

    UPDATE rand4 set seq = seq +1;
    --DELETE FROM rand4;

    --select the size
    select pg_size_pretty(pg_relation_size('rand')), pg_size_pretty(pg_relation_size('rand2')),pg_size_pretty(pg_relation_size('rand3')),pg_size_pretty(pg_relation_size('rand4'));

    ANALYZE VERBOSE rand,rand2,rand3,rand4;

    select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%rand%';





   -- DELETE FROM rand;
   -- DELETE FROM rand2;
   -- DELETE FROM rand3;        
   -- DELETE FROM rand4;    

    DROP TABLE rand,rand2,rand3,rand4;








--find bloated tables postgres













/*
EXEC

    cd /var/lib/postgresql/scripts
    vi vacuum.sql
    echo  "" > vacuum.sql

    psql -U postgres -d postgres -a -f /var/lib/postgresql/scripts/vacuum.sql


*/

