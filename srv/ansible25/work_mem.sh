

psql -U postgres -d test1 -a -f /var/lib/postgresql/scripts/benchmark_InsertFile2.sql 


psql -U postgres -d test1 -a -f /var/lib/postgresql/scripts/benchmark_SelectFile.sql 


watch ls -lath  /var/lib/postgresql/14/main/base/pgsql_tmp



