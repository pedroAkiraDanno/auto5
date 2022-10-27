--POSTGRESQL STRUCTURE
--Layout of Databases

\timing
\pset pager off

--oid of databases
SELECT datname, oid FROM pg_database;

-- tablename and oid for all database
SELECT relname, oid FROM pg_class;

--pg_relation_filepath for tables
select 'SELECT pg_relation_filepath ' || E'(\'' ||relname || E'\')' || ';'   from pg_class where reltuples > 0 and relispopulated = 'true';



--TEST TABLE STRUCUTE 
CREATE UNLOGGED TABLE IF NOT EXISTS COMPANY2(
   NAME           TEXT 
);

do
$do$
declare
     i int;
begin
for  i in 1..10000000
loop
            INSERT INTO COMPANY2 (NAME) SELECT MD5(random()::text);         
end loop;
end;
$do$;

do
$do$
declare
     i int;
begin
for  i in 1..10000000
loop
            INSERT INTO COMPANY2 (NAME) SELECT MD5(random()::text);         
end loop;
end;
$do$;

do
$do$
declare
     i int;
begin
for  i in 1..10000000
loop
            INSERT INTO COMPANY2 (NAME) SELECT MD5(random()::text);         
end loop;
end;
$do$;



--pg_relation_filepath for tables
SELECT pg_relation_filepath ('COMPANY2'); 

--NEED EXEC THIS COMMAND IN LINUX TO MONIT
select  'watch ls -lath /var/lib/postgresql/15/main/' || pg_relation_filepath ('COMPANY2') || '*';

--pg_sleep
SELECT clock_timestamp(), pg_sleep(10);


--DELETE --TRUNCATE IS FASTER THAN DELETE
--DELETE FROM COMPANY2;
TRUNCATE COMPANY2;

--vacuum
vacuum COMPANY2;

--DROP
drop table COMPANY2;




/*
Layout of Databases files: 
/var/lib/postgresql/
/var/lib/postgresql/15/main/base
*/



/*
references: 
PostgreSQL - SQL Basico Juliano Atanazio
5.3 UNLOGGED TABLE  Tabela Nao Logada
*/
