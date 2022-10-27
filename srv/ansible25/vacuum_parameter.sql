
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

 
--test tabl with autovacuum_enabled = off
CREATE TABLE IF NOT EXISTS vacuum_table1 (id int ) with (autovacuum_enabled = off);
SELECT reloptions FROM pg_class WHERE relname='vacuum_table1';
--SELECT * FROM pg_class WHERE relname='vacuum_table1';
ALTER TABLE vacuum_table1 SET (autovacuum_enabled = true);
--drop table vacuum_table1;



--about databases and n_dead_tup
SELECT * FROM   pg_stat_database db;
SELECT relname, n_dead_tup FROM pg_stat_user_tables;



--Last time (auto)vacuum run
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
--grep autovacuum /var/lib/postgresql/15/main/log/*
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













-----





--ABOUT PARAMETERS
--log_autovacuum_min_duration
  --enable to zero, enable log every about vacuum
  alter system set log_autovacuum_min_duration TO 0; 
  --refe: https://postgresqlco.nf/doc/en/param/log_autovacuum_min_duration/








--ABOUT PARAMETERS 
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


    SELECT current_setting('autovacuum_naptime');
    select name,setting,unit,reset_val from pg_settings where name like '%autovacuum_naptime%';
    SET autovacuum_naptime TO DEFAULT;
    reset  autovacuum_naptime;


   -- DELETE FROM rand;
   -- DELETE FROM rand2;
   -- DELETE FROM rand3;        
   -- DELETE FROM rand4;    

    DROP TABLE rand,rand2,rand3,rand4;
  --https://postgresqlco.nf/doc/en/param/log_autovacuum_min_duration/
 










--ABOUT PARAMETERS 
--autovacuum_vacuum_scale_factor 

  --show all settings about vacuum
    select name,setting,unit,pending_restart from pg_settings where name like '%vacuum%';

    CREATE TABLE IF NOT EXISTS t AS SELECT generate_series(1, 10000) AS seq, MD5(random()::text);
    SELECT * from t order by seq desc limit 10;

    ALTER TABLE t SET (autovacuum_vacuum_scale_factor = 0);
    ALTER TABLE t SET (autovacuum_vacuum_threshold = 10000);

    --Getting statistics of all databases
    -- ANALYZE;
    --Getting statistics of a specific database
    --ANALYZE VERBOSE;
    --Getting the statistics of a table
    --ANALYZE VERBOSE t;
    ANALYZE VERBOSE t;

    \x
    select relname,n_live_tup,n_dead_tup,last_vacuum, vacuum_count,last_autovacuum,autovacuum_count,last_analyze,analyze_count,last_autoanalyze,autoanalyze_count
     from pg_stat_all_tables where relname like 't';

    --select the size
    select pg_size_pretty(pg_relation_size('t'));

    INSERT INTO t (seq) SELECT x  FROM generate_series(1,10000) AS x;

    select relname,n_live_tup,n_dead_tup,last_vacuum, vacuum_count,last_autovacuum,autovacuum_count,last_analyze,analyze_count,last_autoanalyze,autoanalyze_count
     from pg_stat_all_tables where relname like 't';

    UPDATE t set seq = seq +1;

    select pg_sleep(3);

    select relname,n_live_tup,n_dead_tup,last_vacuum, vacuum_count,last_autovacuum,autovacuum_count,last_analyze,analyze_count,last_autoanalyze,autoanalyze_count
     from pg_stat_all_tables where relname like 't';    

    DROP TABLE t;
--refe: https://www.2ndquadrant.com/en/blog/autovacuum-tuning-basics/
--      https://postgresqlco.nf/doc/en/param/autovacuum_vacuum_scale_factor/15/?category=autovacuum

  /*
  autovacuum_vacuum_scale_factor


  PARAMETER INFO
  Type:real
  Default:0.2
  Min:0
  Max:100
  Context:sighup
  Restart:false

  DESCRIPTION
  Number of tuple updates or deletes prior to vacuum as a fraction of reltuples
  Specifies a fraction of the table size to add to autovacuum_vacuum_threshold when deciding whether to trigger a VACUUM. The default is 0.2 (20% of table size). This parameter can only be set in the postgresql.conf file or on the server command line; but the setting can be overridden for individual tables by changing table storage parameters.

  */







/* test 1 autovacuum_vacuum_scale_factor*/

  --show all settings about vacuum
    select name,setting,unit,pending_restart,reset_val from pg_settings where name like '%autovacuum_vacuum_scale_factor%';
    
    
    SELECT current_setting('autovacuum_vacuum_scale_factor');
    select name,setting,unit,reset_val from pg_settings where name like '%autovacuum_naptime%';


    --set the naptime to 0.1 to see the autovacuum_max_workers works 
    alter system set autovacuum_vacuum_scale_factor TO 0.1;  


    select pg_reload_conf();
    --systemctl restart postgresql 


    CREATE TABLE IF NOT EXISTS t_scale_factor AS SELECT generate_series(1, 5000) AS seq, MD5(random()::text);
    SELECT * from t_scale_factor order by seq desc limit 10;

    ALTER TABLE t_scale_factor SET (autovacuum_vacuum_scale_factor = 0.1);
    ALTER TABLE t_scale_factor SET (autovacuum_vacuum_threshold = 0);


    --INSERT INTO t_scale_factor (seq) SELECT x  FROM generate_series(1,5000) AS x;

    --select the size
    select pg_size_pretty(pg_relation_size('t_scale_factor'));

    ANALYZE VERBOSE t_scale_factor;


    select relname,n_live_tup,n_dead_tup,last_vacuum, vacuum_count,last_autovacuum,autovacuum_count,last_analyze,analyze_count,last_autoanalyze,autoanalyze_count
     from pg_stat_all_tables where relname like 't_scale_factor';

    --- update just 10% of table
    update t_scale_factor set seq = seq +1 where seq in (select seq from t_scale_factor order by seq desc limit (5000*0.2) offset 12);


    select relname,n_live_tup,n_dead_tup,last_vacuum, vacuum_count,last_autovacuum,autovacuum_count,last_analyze,analyze_count,last_autoanalyze,autoanalyze_count
     from pg_stat_all_tables where relname like 't_scale_factor';

    ---*****most important column about parameter autovacuum_vacuum_scale_factor is reltuples
    \x
    SELECT relname,reltuples,reloptions FROM pg_class WHERE relname  like '%t_scale_factor%';

    --not change nothing , autovacuum is not call, because change little rows/lines
    update t_scale_factor set seq = seq +1 where seq in (select seq from t_scale_factor order by seq desc limit (5000*0.02) offset 12);

    SET autovacuum_vacuum_scale_factor TO DEFAULT;
    reset  autovacuum_vacuum_scale_factor;

    DROP TABLE t_scale_factor;











--find bloated tables postgres













/*
EXEC

    cd /var/lib/postgresql/scripts
    vi vacuum.sql
    echo  "" > vacuum.sql

    psql -U postgres -d postgres -a -f /var/lib/postgresql/scripts/vacuum.sql


*/

