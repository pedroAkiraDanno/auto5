\timing

--Enable pg_stat_statements
ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';

--Create a EXTENSION to pg_stat_statements
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

--Verify that pg_stat_statements returns data
SELECT calls, query FROM pg_stat_statements LIMIT 1;