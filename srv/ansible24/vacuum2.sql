
/* vacuum */

/timing 

CREATE TABLE foobar(id INTEGER, val TEXT);

--SELECT datid, datname FROM pg_stat_database WHERE datname = 'test1';
--SELECT relfilenode,relname FROM pg_class WHERE relname = 'foobar';

--NEED EXEC THIS COMMAND IN LINUX TO MONIT
--select  'watch  ls -lh $PGDATA/base/16384/16418*';





--CHECK SIZE OF TABLE in LINUX 
do $$
declare
   v_datid integer; 
   v_relfilenode oid; 
begin
   -- select the number of films from the actor table
     SELECT datid into v_datid FROM pg_stat_database WHERE datname = 'test1';

     SELECT relfilenode into v_relfilenode FROM pg_class WHERE relname = 'foobar';

   -- show the number of films
   --raise notice 'datid: %', v_datid;
   --raise notice 'v_relfilenode: %', v_relfilenode;   

   -- show the number of films
   raise notice ' ls -lh $PGDATA/base/%/%* ', v_datid,v_relfilenode;


end; $$;





INSERT INTO foobar(id, val) VALUES (1, 'abc');

select  'watch  ls -lh $PGDATA/base/16386/16475*';

EXPLAIN ANALYZE SELECT * FROM foobar WHERE id = 1;

INSERT INTO foobar(id, val) SELECT id,md5(clock_timestamp()::TEXT) AS val FROM generate_series(1,10000000) AS id;

SELECT COUNT(*) FROM foobar;


SELECT * FROM foobar LIMIT 5;


select  'watch  ls -lh $PGDATA/base/16386/16475*';

EXPLAIN ANALYZE SELECT * FROM foobar WHERE id = 1;

DELETE FROM foobar WHERE id <= 9999999;

SELECT COUNT(*) FROM foobar;

select  'watch  ls -lh $PGDATA/base/16386/16475*';

EXPLAIN ANALYZE SELECT * FROM foobar WHERE id = 1;

INSERT INTO foobar(id, val) SELECT id,md5(clock_timestamp()::TEXT) AS val FROM generate_series(1,10000000) AS id;

select count(*) from foobar;

select  'watch  ls -lh $PGDATA/base/16386/16475*';

 EXPLAIN ANALYZE SELECT * FROM foobar WHERE id = 1;

DELETE FROM foobar WHERE id <= 9999999;

select count(*) from foobar;

EXPLAIN ANALYZE SELECT * FROM foobar WHERE id = 1;

VACUUM foobar;

select  'watch  ls -lh $PGDATA/base/16386/16475*';

INSERT INTO foobar(id, val) SELECT id,md5(clock_timestamp()::TEXT) AS val FROM generate_series(1,10000000) AS id;

select  'watch  ls -lh $PGDATA/base/16386/16475*';

INSERT INTO foobar(id, val) SELECT id,md5(clock_timestamp()::TEXT) AS val FROM generate_series(1,10000000) AS id;

select  'watch  ls -lh $PGDATA/base/16386/16475*';



--drop table foobar;



