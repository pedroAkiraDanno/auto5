\timing

CREATE UNLOGGED TABLE IF NOT EXISTS test2(
        id bigint 
);


CREATE OR REPLACE FUNCTION random_between(low INT ,high INT) 
   RETURNS INT AS
$$
BEGIN
   RETURN floor(random()* (high-low + 1) + low);
END;
$$ language 'plpgsql' STRICT;


--pg_relation_filepath for tables
SELECT pg_relation_filepath ('test2'); 

--NEED EXEC THIS COMMAND IN LINUX TO MONIT
select  'watch ls -lath /var/lib/postgresql/14/main/' || pg_relation_filepath ('test2') || '*';

INSERT INTO test2 (id) SELECT * FROM generate_series(1, 1000000000);  
--INSERT INTO test2 (id) SELECT random() FROM generate_series(1, 10000000);  
INSERT INTO test2 (id) SELECT random_between(1,10000) FROM generate_series(1, 1000000000);  


-- size of table 
SELECT pg_size_pretty( pg_total_relation_size('test2') );

/*
Layout of Databases files: 
/var/lib/postgresql/
/var/lib/postgresql/14/main/base
*/



/*
references: 
PostgreSQL - SQL Basico Juliano Atanazio
5.3 UNLOGGED TABLE  Tabela Nao Logada = not create wal files 


https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-random-range/
*/
