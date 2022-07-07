\timing

DROP INDEX foo_idx;
CREATE INDEX foo_idx ON  test2(id);

--pg_relation_filepath for tables
SELECT pg_relation_filepath ('foo_idx'); 

--NEED EXEC THIS COMMAND IN LINUX TO MONIT
select  'watch ls -lath /var/lib/postgresql/14/main/' || pg_relation_filepath ('foo_idx') || '*';
