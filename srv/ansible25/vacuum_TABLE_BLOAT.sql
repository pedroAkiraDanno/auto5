
/* vacuum and bloated tables */

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

 


 

--bloated tables postgres
















/*
Why Bloat Happens

For those of you newer to PostgreSQL administration, and this is the first time you may be hearing about bloat, I figured I’d take the time to explain why this scenario exists and why tools like this are necessary (until they’re hopefully built into the database itself someday). It’s something most don’t understand unless someone first explains it to them or you run into the headaches it causes when it’s not monitored and you learn about it the hard way.

MVCC (multi-version concurrency control) is how Postgres has chosen to deal with multiple transactions/sessions hitting the same rows at (nearly) the same time. The documentation, along with Wikipedia provide excellent and extensive explanations of how it all works, so I refer you there for all the details. Bloat is a result of one particular part of MVCC, concentrated around the handling of updates and deletes.

Whenever you delete a row, it’s not actually deleted, it is only marked as unavailableto all future transactions taking place after the delete occurs. The same happens with an update: the old version of a row is kept active until all currently running transactions have finished, then it is marked as unavailable. I emphasize the word unavailable because the row still exists on disk, it’s just not visible any longer. The VACUUM process in Postgres then comes along and marks any unavailable rows as space that is now available for future inserts or updates. The auto-vacuum process is configured to run VACUUM automatically after so many writes to a table (follow the link for the configuration options), so it’s not something you typically have to worry about doing manually very often (at least with more modern versions of Postgres).

People often assume that VACUUM is the process that should return the disk space to the file system. It does do this but only in very specific cases. That used space is contained in page files that make up the tables and indexes (called objects from now on) in the Postgres database system. Page files all have the same size and differently sized objects just have as many page files as they need. If VACUUM happens to mark every row in a page file as unavailable AND that page also happens to be the final page for the entire object, THEN the disk space is returned to the file system. If there is a single available row, or the page file is any other but the last one, the disk space is never returned by a normal VACUUM. This is bloat. Hopefully this explanation of what bloat actually is shows you how it can sometimes be advantageous for certain usage patterns of tables as well, and why I’ve included the option to ignore objects in the report.

If you give the VACUUM command the special flag FULL, then all of that reusable space is returned to the file system. But VACUUM FULL does this by completely rewriting the entire table (and all its indexes) to new pages and takes an exclusive lock on the table the entire time it takes to run (CLUSTER does the same thing, but what that does is outside the scope of this post). For large tables in frequent use, this is problematic. pg_repack has been the most common tool we’ve used to get around that. It recreates the table in the background, tracking changes to it, and then takes a brief lock to swap the old bloated table with the new one.

Why bloat is actually a !problem when it gets out of hand is not just the disk space it uses up. Every time a query is run against a table, the visibility flags on individual rows and index entries is checked to see if is actually available to that transaction. On large tables (or small tables with a lot of bloat) that time spent checking those flags builds up. This is especially noticeable with indexes where you expect an index scan to improve your query performance and it seems to be making no difference or is actually worse than a sequential scan of the whole table. And this is why index bloat is checked independently of table bloat since a table could have little to no bloat, but one or more of its indexes could be badly bloated. Index bloat (as long as it’s not a primary key) is easier to solve because you can either just reindex that one index, or you can concurrently create a new index on the same column and then drop the old one when it’s done.





ref: https://www.crunchydata.com/blog/checking-for-postgresql-bloat

*/









--DROP EXTENSION IF EXISTS <extension name>;
CREATE  EXTENSION pgstattuple;

--ls  /usr/share/postgresql/15/extension/pgstattuple*


--Check extension details by query pg_extension and pg_available_extensions.
SELECT * FROM pg_extension;
SELECT * FROM pg_available_extensions;





/*
How to check and resolve Bloat in PostgreSQL

Bloating in database is created when tables or indexes are updated, an update is essentially a delete and insert operation. The diskspace used by the delete is available for reuse but it is not reclaimed hence creating the bloat. Same is the case with PostgreSQL database, frequent UPDATE and DELETE operations can leave a lot of unused space in table or index relation files on disk. Over the time this space can build up and cause the performance degradation for both tables and indexes. This buildup is referred to as bloated tables or indexes.

How does it happen:
The PostgreSQL system implements the MVCC (Multiversion Concurrency Control) and the way MVCC is implemented, it can introduce bloat’s in your system.

When an UPDATE or DELETE statement is used in PostgreSQL, it does not physically remove that row from the disk. In an UPDATE case, it marks the effected rows as invisible and INSERTs the new version of those rows. While DELETE is little simple the effected rows are just marked as invisibles. These invisibles rows are also called dead rows or dead tuples.

What this means? and why is it of any significance? Over the time these dead tuples can accumulate to a huge number and in some worst case scenarios, it possible that this accumulation is even greater that the actual rows in the table becomes unusable. 

You see, these rows were marked invisible but they are still part of the table and are consuming the disk space… Assuming there are a million rows in a table, where each row takes 100bytes of disk space. This table is assumed to be consuming around 100MB of disk space. Now let’s assume there are 30% invisible rows present in the table, that would mean that 130MB’s of disk space is being utilised by the dead tuples. This looks insignificant amount but consider the real world scenario where tables use GB/TB’s of data and it becomes a serious problem.



So how to detect bloats?
There are couple of ways to detect the bloat and identify the problematic areas  in your database. We will be looking at one particular method that I believe is the more accurate one.




refe: https://www.highgo.ca/2021/03/20/how-to-check-and-resolve-bloat-in-postgresql/
*/
DROP TABLE IF EXISTS test_highgo;
DROP INDEX IF EXISTS test_highgo_x_idx;

CREATE TABLE test_highgo as SELECT x, md5(random()::text) as y FROM generate_Series(1, 1000000) x;
ALTER TABLE test_highgo  SET (autovacuum_enabled = off);
\d+ test_highgo
CREATE INDEX ON test_highgo (x);

--SELECT    tablename,    indexname,    indexdef FROM    pg_indexes WHERE    schemaname = 'public' ORDER BY   tablename,   indexname;
SELECT    tablename,    indexname,    indexdef FROM    pg_indexes WHERE    tablename = 'test_highgo' ORDER BY   tablename,   indexname;

SELECT pg_size_pretty(pg_relation_size('test_highgo')) as table_size, 
       pg_size_pretty(pg_relation_size('test_highgo_x_idx')) as index_size,
       (pgstattuple('test_highgo')).dead_tuple_percent;

DELETE FROM test_highgo WHERE x % 3 = 0;
ANALYZE test_highgo;

 SELECT pg_size_pretty(pg_relation_size('test_highgo')) as table_size, 
       pg_size_pretty(pg_relation_size('test_highgo_x_idx')) as index_size,
       (pgstattuple('test_highgo')).dead_tuple_percent;


--See the table size remains the same, however the output of pgstattuple shows that 29.78% of disk space is wasted. It’s taking the space in table but not useable anymore.

 SELECT pg_relation_size('test_highgo') as table_size, 
       pg_relation_size('test_highgo_x_idx') as index_size,
       100-(pgstatindex('test_highgo_x_idx')).avg_leaf_density as bloat_ratio;



UPDATE test_highgo SET x = x + 2 WHERE x % 2 = 0;

 SELECT pg_relation_size('test_highgo') as table_size, 
       pg_relation_size('test_highgo_x_idx') as index_size,
       100-(pgstatindex('test_highgo_x_idx')).avg_leaf_density as bloat_ratio;


SELECT pg_size_pretty(pg_relation_size('test_highgo')) as table_size, 
       pg_size_pretty(pg_relation_size('test_highgo_x_idx')) as index_size,
       (pgstattuple('test_highgo')).dead_tuple_percent;


--After the above operations, index has become 41.08% bloated. That means that the performance of this index will degrade because that much entries are either empty or pointing to dead tuples.










/*
Dealing with significant Postgres database bloat — what are your options?

What is “bloat”? How much do I have?
Before we go any further, it’s essential to understand what bloat is in the first place. It’s most likely what lead you to this article, but understanding how it occurs in the first place is worth knowing so you can prevent it before it starts.

When an existing record is updated, it results in a dead tuple, the previous version of the record, as well as a new record. When the rate of dead tuples being created exceeds the database’s ability to clean up dead tuples automatically, bloat occurs. Let’s imagine a scenario where an application is updating or deleting records at an average of 1,000 records per second. The autovacuum daemon is removing dead tuples at an average rate of 800 per second. Each second, 200 tuples of bloat will occur. Keep in mind this is a hypothetical scenario — it’s impossible to tune the autovacuum daemon to remove dead tuples at 800/sec.


What problems does bloat cause?
When a database table is suffering from bloat, query performance will suffer dramatically.

In Postgres, the query planner is responsible for determining the best execution plan for a query. The planner must consider aggregate table statistics, the indices on the table, and the type of data being queried. The planner will then recommend a certain execution path to get the data in the quickest, most resource-efficient way.

When a table is bloated, Postgres’s ANALYZE tool calculates poor/inaccurate information that the query planner uses. Consider the case when a table has 350 million dead tuples, but only 50 million active rows. The bloat score on this table is a 7 since the dead tuples to active records ratio is 7:1. This score is exceptionally high, so when the query planner tries to query this table, it gives horrible instructions, leading to slow queries (because they use an inferior index, for example).

Imagine asking for directions in your parent’s hometown, and they’re using a mental model of their hometown from 30 years ago. Tons of stuff has changed, so their directions are only partially correct. You may eventually get there, but it’s going to be a winding, slow, frustrating trip.

After removing the database bloat in this example, the query took 37ms to complete, a reduction of 99.7% in execution time.


How does database bloat typically get cleaned up?
Typically, Postgres’s autovacuum daemon handles regular cleaning of this data. Postgres’ default is when the dead tuples in the table represent 20% of the total records. Numerous parameters can be tuned to achieve this. Still, specific values depend on your database’s workload and your business rules for acceptable performance. This is especially true since the autovacuum process consumes resources that would otherwise be used for regular operation (think CPU/memory/disk IO).



ref: https://medium.com/compass-true-north/dealing-with-significant-postgres-database-bloat-what-are-your-options-a6c1814a03a5
*/

--# Find all tables and when they were last vacuumed/analyzed, either manually or automatically
SELECT relname, 
       last_vacuum, 
       last_autovacuum, 
       last_analyze, 
       last_autoanalyze 
FROM   pg_stat_all_tables 
WHERE  schemaname = 'public' 
ORDER  BY last_vacuum DESC;

--# Find any running processes that are doing autovacuum and which tables they're working on
SELECT   pid, 
         Age(query_start, Clock_timestamp()), 
         usename, 
         query 
FROM     pg_stat_activity 
WHERE    query != '<IDLE>' 
AND      query ilike '%vacuum%' 
ORDER BY query_start ASC;

--# Find table/index sizes for all tables in a schema
SELECT *, 
       Pg_size_pretty(total_bytes) AS total, 
       Pg_size_pretty(index_bytes) AS INDEX, 
       Pg_size_pretty(toast_bytes) AS toast, 
       Pg_size_pretty(table_bytes) AS TABLE 
FROM   (SELECT *, 
               total_bytes - index_bytes - Coalesce(toast_bytes, 0) AS 
               table_bytes 
        FROM   (SELECT c.oid, 
                       nspname                               AS table_schema, 
                       relname                               AS TABLE_NAME, 
                       c.reltuples                           AS row_estimate, 
                       Pg_total_relation_size(c.oid)         AS total_bytes, 
                       Pg_indexes_size(c.oid)                AS index_bytes, 
                       Pg_total_relation_size(reltoastrelid) AS toast_bytes 
                FROM   pg_class c 
                       LEFT JOIN pg_namespace n 
                              ON n.oid = c.relnamespace 
                WHERE  relkind = 'r') a 
        WHERE  table_schema = 'public' 
        ORDER  BY total_bytes DESC) a; 


/*
When bloat can’t automatically be cleaned up, what can you do?

Ok — the reason you’re all here. When you are in a situation where bloat accumulates faster than the database can clean it up, the first and most urgent step is to resolve the root cause of the bloat creation. This root cause may be an over-zealous background job that’s updating records far too frequently or a lack of rate limiting, but ultimately is something specific to your application.

Once you’ve stemmed the bleeding on this front, the next stage is to repair the damage. Unfortunately, when you have table bloat in the 5+ range for a large table (10–100+ GB), the regular VACUUM ANALYZE VERBOSE table_name_here; command is going to take a prohibitively long time (think 4+ days, or even longer).

We identified 3 potential options
VACUUM FULL. Pros: can be faster than VACUUM ANALYZE and will eliminate all bloat in the table while also shrinking the table’s physical size on disk. Cons: Requires an exclusive read/write lock on the table for the operation’s duration, which can cause application outages depending on the table. Imagine not being able to access your users table temporarily — a non-starter.

pg_repack. Pros: Very fast, and doesn’t require a read/write lock on the table. Cons: Very resource-intensive, which can degrade overall database performance. It also can cause significant replication lag, as well as OOM !errors when using replication slots (details below).

pgcompacttable. Does the same thing as pg_repack, but modifies the rows in place. I won’t go into detail here, but it uses significantly fewer resources and operates much slower, so it’s not as problematic for replication slots. However, in our case, pgcompacttable was far too slow to remove the amount of bloat we had.

We decided to go with pg_repack, and pay the brief performance penalty. No downtime, and was the quickest path to resolution.






https://medium.com/compass-true-north/dealing-with-significant-postgres-database-bloat-what-are-your-options-a6c1814a03a5

*/



















/*

Bloat removal by tuples moving


I had a 350GB table, which had many rows inserted, but never removed or updated. Then, at some point in time, client made a decision to remove all rows older than 4 months. These rows were removed, but this didn't decrease the table size. Why?

Because all free pages are at the beginning of the table “file" (well, it's several files, but let's assume it's single file).

Normal vacuum can shrink the table only if the trailing page(s) are empty – it just truncates the table file by how many empty pages are at the very end.

You can use VACUUM FULL, but this has drawbacks:

it locks the table for the whole duration
depending on version it might: bloat indexes and/or take ages to finish


The !problem was that quick estimate told us that if we removed 100% of bloat, the table (with indexes) would use ~ 150GB, and we had only 50GB of free disk space, so using pg_reorg is not an option.


https://www.depesz.com/2013/06/21/bloat-removal-by-tuples-moving/

*/
 CREATE EXTENSION pageinspect;

DROP TABLE IF EXISTS test;
 create table test (id serial primary key, payload text);
 insert into test (payload) select repeat('depesz', 100) from generate_series(1,1000000);

 select pg_size_pretty(pg_relation_size('test'));
 ANALYZE VERBOSE test;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%test%';
 SELECT * FROM pgstattuple('test');

 \dt+ test  

 --Now, let's remove first 80% of the table:
 delete from test where id < 800000;

 select pg_table_size('test');

 select pg_size_pretty(pg_relation_size('test'));
 ANALYZE VERBOSE test;
 --- note see the diff about tuple_percent and free_percent
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%test%';
 SELECT * FROM pgstattuple('test');

 \dt+ test

 --for i in {1..5}; do vacuumdb -t test; done
 vacuum test;
 

 select pg_table_size('test');

 select pg_size_pretty(pg_relation_size('test'));
 ANALYZE VERBOSE test;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%test%';
 SELECT * FROM pgstattuple('test');

 --Now, let's insert first 80% of the table:
 insert into test (payload) select repeat('depesz', 100) from generate_series(1,800000);


 select pg_table_size('test');

 select pg_size_pretty(pg_relation_size('test'));
 ANALYZE VERBOSE test;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%test%';
 SELECT * FROM pgstattuple('test');


DROP TABLE IF EXISTS test;






/* pedro test */
CREATE EXTENSION pageinspect;

CREATE SCHEMA scott;

--about UPDATE 
-- UPDATE double the size 
DROP TABLE scott.employee ;
CREATE TABLE scott.employee (emp_id INT, emp_name VARCHAR(100), dept_id INT);
INSERT into scott.employee VALUES (generate_series(1,10),'avi',1);
UPDATE scott.employee SET emp_name = 'avii';
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));


vacuum scott.employee;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));



--about DELETE  
-- DELETE just mark lines like delete 
DROP TABLE scott.employee ;
CREATE TABLE scott.employee (emp_id INT, emp_name VARCHAR(100), dept_id INT);
INSERT into scott.employee VALUES (generate_series(1,10),'avi',1);
DELETE FROM  scott.employee WHERE  emp_id%2 = 0;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));


vacuum scott.employee;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));









/* pedro test 2*/
CREATE EXTENSION pageinspect;

CREATE SCHEMA scott;

--about UPDATE 
-- UPDATE double the size 
DROP TABLE scott.employee ;
CREATE TABLE scott.employee (emp_id INT, emp_name VARCHAR(100), dept_id INT);
INSERT into scott.employee VALUES (generate_series(1,10),'avi',1);
UPDATE scott.employee SET emp_name = 'avii';
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));

 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE scott.employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');





vacuum scott.employee;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));

 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE scott.employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');



--about DELETE  
-- DELETE just mark lines like delete 
DROP TABLE scott.employee ;
CREATE TABLE scott.employee (emp_id INT, emp_name VARCHAR(100), dept_id INT);
INSERT into scott.employee VALUES (generate_series(1,10),'avi',1);
DELETE FROM  scott.employee WHERE  emp_id%2 = 0;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));

 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE scott.employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');




vacuum scott.employee;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));


 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE scott.employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');



























/* pedro test 3*/
CREATE EXTENSION pageinspect;

CREATE SCHEMA scott;

--about UPDATE 
-- UPDATE double the size 
DROP TABLE scott.employee ;
CREATE TABLE scott.employee (emp_id INT, emp_name VARCHAR(100), dept_id INT);
BEGIN;
INSERT into scott.employee VALUES (generate_series(1,10),'avi',1);
COMMIT;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));
BEGIN;
UPDATE scott.employee SET emp_name = 'avii';
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));
ROLLBACK;


 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE scott.employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');




vacuum scott.employee;
SELECT t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));

 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE scott.employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');



--about DELETE  
-- DELETE just mark lines like delete 
DROP TABLE scott.employee ;
CREATE TABLE scott.employee (emp_id INT, emp_name VARCHAR(100), dept_id INT);
BEGIN;
INSERT into scott.employee VALUES (generate_series(1,100),'avi',1);
COMMIT;
SELECT heap_page_items.t_ctid,t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));
SELECT oid::regclass AS tbl, relpages FROM   pg_class WHERE  relname = 'employee'; 
SELECT * FROM pg_freespace('scott.employee');
BEGIN;
DELETE FROM  scott.employee WHERE  emp_id%2 = 0;
SELECT heap_page_items.t_ctid,t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));
ROLLBACK; 


 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');




vacuum scott.employee;
SELECT heap_page_items.t_ctid,t_xmin, t_xmax, tuple_data_split('scott.employee'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('scott.employee', 0));


 select pg_size_pretty(pg_relation_size('scott.employee'));
 ANALYZE VERBOSE scott.employee;
 select relname,last_vacuum, vacuum_count,n_live_tup,n_dead_tup from pg_stat_all_tables where relname like '%employee%';
 SELECT * FROM pgstattuple('scott.employee');






DROP TABLE IF EXISTS test;







/*
EXEC

    cd /var/lib/postgresql/scripts
    vi vacuum.sql
    echo  "" > vacuum.sql

    psql -U postgres -d postgres -a -f /var/lib/postgresql/scripts/vacuum.sql


*/

