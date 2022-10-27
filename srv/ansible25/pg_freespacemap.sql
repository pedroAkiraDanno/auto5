/*
    pg_freespacemap
    Free Space Mapping file in details
*/











/*
pg_freespacemap
Free Space Mapping file in details




REF: https://www.highgo.ca/2020/10/23/free-space-mapping-file-in-details/

*/

/* pg_freespacemap*/

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


--ls  /usr/share/postgresql/15/extension/pg_freespacemap*


--Check extension details by query pg_extension and pg_available_extensions.
SELECT * FROM pg_extension;
SELECT * FROM pg_available_extensions;



--
 create extension pg_freespacemap;

 drop table orders1;
 create table orders1 (id int4, test text);

 insert into orders1 values(generate_series(1,1000), 'hello world!');

 vacuum orders1;
 
 SELECT oid::regclass AS tbl, relpages FROM   pg_class WHERE  relname = 'orders1'; 

 SELECT * FROM pg_freespace('orders1');




--
delete from orders1 where id%2=1 and id < 158;

delete from orders1 where id%4=1 and id >= 158 and id < 315;

delete from orders1 where id%8=1 and id >= 315 and id < 472;

delete from orders1 where id%16=1 and id >= 472 and id < 629;

delete from orders1 where id%32=1 and id >= 629 and id < 786;

delete from orders1 where id%64=1 and id >= 786;

vacuum orders1;
SELECT * FROM pg_freespace('orders1');



--
SELECT * FROM pg_freespace('orders1', 3);




--
insert into orders1 values(generate_series(1,65), 'hello world!');

vacuum orders1;
SELECT * FROM pg_freespace('orders1');




--
SELECT count(*) as "number of pages",  pg_size_pretty(cast(avg(avail) as bigint)) as "Av. freespace size",
       round(100 * avg(avail)/8192 ,2) as "Av. freespace ratio"
       FROM pg_freespace('orders1');


SELECT avail, count(*) 
  FROM pg_freespace ('orders1') 
 GROUP BY avail 
 ORDER BY 1;



--source code about pg_freespacemap
--https://github.com/postgres/postgres/tree/master/contrib/pg_freespacemap




