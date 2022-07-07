
/* vacuum */

\timing
\echo :AUTOCOMMIT
--\set AUTOCOMMIT on


DROP DATABASE IF EXISTS vacuum_test;
CREATE DATABASE  vacuum_test TEMPLATE template0;
\c vacuum_test;



CREATE TABLE IF NOT EXISTS vacuum_table (id int ) with (autovacuum_enabled = off);

--size will be zero, because the database just create the file without nothing
select pg_size_pretty(pg_relation_size('vacuum_table'));

--size will be 8kb
INSERT INTO vacuum_table(id) VALUES (0);

select pg_size_pretty(pg_relation_size('vacuum_table'));

insert into vacuum_table select * from generate_series(1,100000);

select pg_size_pretty(pg_relation_size('vacuum_table'));

ANALYZE VERBOSE vacuum_table;
select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%vacuum_table%';


update vacuum_table set id = id+1;

-- the double of size
select pg_size_pretty(pg_relation_size('vacuum_table'));

ANALYZE VERBOSE vacuum_table;
select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%vacuum_table%';


--vacuum verbose vacuum_table;
vacuum vacuum_table;

select pg_size_pretty(pg_relation_size('vacuum_table'));

ANALYZE VERBOSE vacuum_table;
select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%vacuum_table%';


--continue the same size, because postgres reuse the old places 
update vacuum_table set id = id+1;

select pg_size_pretty(pg_relation_size('vacuum_table'));

drop table vacuum_table;

\l




/*
EXEC

    cd /var/lib/postgresql/scripts
    vi vacuum.sql
    echo  "" > vacuum.sql

    psql -U postgres -d postgres -a -f /var/lib/postgresql/scripts/vacuum.sql


*/

