/* vacuum pgstattuple*/

  \timing
  \pset pager off
  \pset border 2

  \l
  --\x 


--show all settings about vacuum
select name,setting,unit from pg_settings where name like '%vacuum%';



--create the database to test vacuum
DROP DATABASE IF EXISTS vacuum_test;
CREATE DATABASE  vacuum_test TEMPLATE template0;
\c vacuum_test;


--DROP EXTENSION IF EXISTS <extension name>;
CREATE  EXTENSION pgstattuple;

--ls  /usr/share/postgresql/14/extension/pgstattuple*


--Check extension details by query pg_extension and pg_available_extensions.
SELECT * FROM pg_extension;
SELECT * FROM pg_available_extensions;


--test
CREATE TABLE IF NOT EXISTS demo (a int, b int);
insert into demo select generate_series(1,10) as a, generate_series(1,10) as b;

SELECT * FROM pgstattuple('demo');
--SELECT * FROM pgstattuple_approx('pg_catalog.pg_proc'::regclass);

delete from demo where a in (4,5,6);
SELECT * FROM pgstattuple('demo');
vacuum demo;
SELECT * FROM pgstattuple('demo');



/*
Whereas pgstattuple always performs a full-table scan and returns an exact count of live and dead tuples (and their sizes) and free space, pgstattuple_approx tries to avoid the full-table scan and returns exact dead tuple statistics along with an approximation of the number and size of live tuples and free space.

*/


/*
pgstattuple

The pgstattuple module provides various functions to obtain tuple-level statistics.

Because these functions return detailed page-level information, access is restricted by default. By default, only the role pg_stat_scan_tables has EXECUTE privilege. Superusers of course bypass this restriction. After the extension has been installed, users may issue GRANT commands to change the privileges on the functions to allow others to execute them. However, it might be preferable to add those users to the pg_stat_scan_tables role instead.


F.31.1. Functions
pgstattuple(regclass) returns record
pgstattuple returns a relation's physical length, percentage of “dead” tuples, and other info. This may help users to determine whether vacuum is necessary or not. The argument is the target relation's name (optionally schema-qualified) or OID. For example:


test=> SELECT * FROM pgstattuple('pg_catalog.pg_proc');
-[ RECORD 1 ]------+-------
table_len          | 458752
tuple_count        | 1470
tuple_len          | 438896
tuple_percent      | 95.67
dead_tuple_count   | 11
dead_tuple_len     | 3157
dead_tuple_percent | 0.69
free_space         | 8932
free_percent       | 1.95


Column	Type	Description
table_len	bigint	Physical relation length in bytes
tuple_count	bigint	Number of live tuples
tuple_len	bigint	Total length of live tuples in bytes
tuple_percent	float8	Percentage of live tuples
dead_tuple_count	bigint	Number of dead tuples
dead_tuple_len	bigint	Total length of dead tuples in bytes
dead_tuple_percent	float8	Percentage of dead tuples
free_space	bigint	Total free space in bytes
free_percent	float8	Percentage of free space



refe: https://www.postgresql.org/docs/current/pgstattuple.html
*/












/*
DETECTING TABLE BLOAT


ref: https://www.cybertec-postgresql.com/en/detecting-table-bloat/
*/

\timing 

DROP TABLE t_test;
CREATE TABLE t_test AS SELECT * FROM generate_series(1, 10000);

 SELECT * FROM pgstattuple('t_test');

 DELETE FROM t_test WHERE generate_series % 3 = 0;

 ANALYZE t_test;

 SELECT * FROM pgstattuple('t_test');

 VACUUM t_test;

 SELECT * FROM pgstattuple('t_test');


 /*Checking many tables*/

 SELECT relname, pgstattuple(oid) FROM pg_class WHERE relkind = 'r' LIMIT 3;
 SELECT relname, (pgstattuple(oid)).* FROM pg_class WHERE relkind = 'r' LIMIT 3;






/*

https://dbalifeeasy.com/tag/create-extension-pgstattuple/
*/










/*
Find bloated tables and indexes in PostgreSQL without extensions


-- Perform ANALYZE on your table
ANALYZE <table_name>;

-- Get the number of deadlines in your tables.
select schemaname,
relname,
pg_size_pretty(pg_relation_size(schemaname|| '.' || relname)) as size,
n_live_tup,
n_dead_tup,
CASE WHEN n_live_tup > 0 THEN round((n_dead_tup::float / 
n_live_tup::float)::numeric, 4) END AS dead_tup_ratio,
last_autovacuum,
last_autoanalyze
from pg_stat_user_tables
order by dead_tup_ratio desc NULLS LAST;
The higher the dead_tup_ratio, the higher the bloat of your table. But these are approximate data collected in the course of collecting statistics! The best way to know for sure about bloat is to use the pgstattuple extension.




https://dba.stackexchange.com/questions/302507/find-bloated-tables-and-indexes-in-postgresql-without-extensions
*/



DROP TABLE IF EXISTS t2_person;
CREATE TABLE IF NOT EXISTS t2_person (id serial, gender int, data char(40)) with (autovacuum_enabled = off);

INSERT INTO t2_person (gender, data)    SELECT x % 2 + 1, 'data' FROM generate_series(1,5000) AS x;


 --DELETE FROM t2_person WHERE gender % 3 = 0;

 UPDATE t2_person set gender = gender +1 WHERE gender%2 = 0;

    
    ANALYZE t2_person;

    select schemaname,
    relname,
    pg_size_pretty(pg_relation_size(schemaname|| '.' || relname)) as size,
    n_live_tup,
    n_dead_tup,
    CASE WHEN n_live_tup > 0 THEN round((n_dead_tup::float / 
    n_live_tup::float)::numeric, 4) END AS dead_tup_ratio,
    last_autovacuum,
    last_autoanalyze
    from pg_stat_user_tables
    order by dead_tup_ratio desc NULLS LAST;
    











/*
EXEC

    cd /var/lib/postgresql/scripts
    vi vacuum.sql
    echo  "" > vacuum.sql

    psql -U postgres -d postgres -a -f /var/lib/postgresql/scripts/vacuum.sql


*/






