\timing

select * from generate_series(1,90000000) order by 1 LIMIT 1;
select * from generate_series(1,90000000) order by 1 LIMIT 1;
select * from generate_series(1,90000000) order by 1 LIMIT 1;


--watch temp files was creted 
-- watch ls -lath /var/lib/postgresql/14/main/base/pgsql_tmp


-- you can decomment
--select pg_stat_reset();

--PostgreSQL "size of temporary files"
SELECT temp_files AS "Temporary files"
     , temp_bytes AS "Size of temporary files"
FROM   pg_stat_database db;


--PostgreSQL "size of temporary files"
SELECT datname AS "database name", temp_files AS "Temporary files"
     , temp_bytes/1024/1024/1024 AS "Size of temporary files by GB"
FROM   pg_stat_database db ORDER BY temp_bytes;

