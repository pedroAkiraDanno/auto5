\timing

--NEED EXEC THIS COMMAND IN LINUX TO MONIT
select  'watch ls -lath /var/lib/postgresql/14/main/base/pgsql_tmp';

EXPLAIN ANALYZE SELECT DISTINCT *  from test2 order by id limit 10;


EXPLAIN ANALYZE SELECT DISTINCT *  from test2 order by id;


/*
EXPLAIN(analyze,verbose, buffers,wal, timing, summary) SELECT DISTINCT *  from test2 order by id limit 10;
EXPLAIN(analyze,verbose, buffers,wal, timing)  SELECT DISTINCT *  from test2 order by id;
*/






/*
As of PostgreSQL 10 there are 3 types of sort algorithms in PostgreSQL:
external sort Disk
quicksort
top-N heapsort

top-N heapsort is used if you only want a couple of sorted rows. For example: The highest 10 values, the lowest 10 values and so on. top-N heapsort is pretty efficient and returns the desired data in almost no time:





reference: https://www.cybertec-postgresql.com/en/postgresql-improving-sort-performance/#
*/







