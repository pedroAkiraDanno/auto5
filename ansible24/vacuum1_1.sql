
/* vacuum */

\timing
\echo :AUTOCOMMIT
--\set AUTOCOMMIT on


DROP DATABASE IF EXISTS vacuum_test;
CREATE DATABASE  vacuum_test TEMPLATE template0;
\c vacuum_test;



CREATE TABLE IF NOT EXISTS t_person (id serial, gender int, data char(40)) with (autovacuum_enabled = off);


select pg_size_pretty(pg_relation_size('t_person'));

--size will be 8kb
insert into t_person (gender,data) values (1,'a');

select pg_size_pretty(pg_relation_size('t_person'));

--size will be like 
INSERT INTO t_person (gender, data)    SELECT x % 2 + 1, 'data' FROM generate_series(1,5000000) AS x;

select pg_size_pretty(pg_relation_size('t_person'));

ANALYZE VERBOSE t_person;
select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%t_person%';

--file name of table 
SELECT oid from pg_database WHERE datname = 'vacuum_test';
SELECT relname, relfilenode FROM pg_class WHERE relname = 't_person'; 

--pg_lsclusters
--pg_ctl status -D /var/lib/postgresql/14/main

SELECT pg_relation_filepath('t_person');




--select with gruop by
SELECT gender, count(*) from t_person  GROUP BY 1;



update t_person set id = id+1;

-- the double of size
select pg_size_pretty(pg_relation_size('t_person'));

ANALYZE VERBOSE t_person;
select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%t_person%';



--vacuum verbose t_person;
vacuum t_person;

select pg_size_pretty(pg_relation_size('t_person'));

ANALYZE VERBOSE t_person;
select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%t_person%';


--continue the same size, because postgres reuse the old places 
update t_person set id = id+1;

select pg_size_pretty(pg_relation_size('t_person'));

drop table t_person;

\l




/*
EXEC

    cd /var/lib/postgresql/scripts
    vi vacuum.sql
    echo  "" > vacuum.sql

    psql -U postgres -d postgres -a -f /var/lib/postgresql/scripts/vacuum.sql


*/

