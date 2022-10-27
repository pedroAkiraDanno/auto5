--work_mem - POSTGRESQL: IMPROVING SORT PERFORMANCE

--Executor uses this area for sorting tuples by ORDER BY and DISTINCT operations, and for joining tables by merge-join and hash-join operations.  


 /timing 






-- TEST 2 PART 
      ALTER SYSTEM RESET work_mem;
      select pg_reload_conf();



/*
      postgres@instance-20220329-1520:~$ sudo systemctl restart postgresql


      postgres@instance-20220329-1520:~$ psql -U postgres -d test1 -a -f /var/lib/postgresql/scripts/benchmark_SelectFile.sql 
         Sort Method: top-N heapsort  Memory: 25kB
         Time: 11572.951 ms (00:11.573)

         Sort Method: external merge  Disk: 176216kB
         Time: 24350.670 ms (00:24.351)


      postgres@instance-20220329-1520:~$ watch ls -lath  /var/lib/postgresql/15/main/base/pgsql_tmp



      #postgres@instance-20220329-1520:~$ psql -U postgres -d test1 -a -f /var/lib/postgresql/scripts/benchmark_DeleteFile.sql

*/













--You can get this information in log file by setting parameter trace_sorts=on (http://www.postgresql.org/docs/9.4/static/runtime-config-developer.html)

/*
   postgres=# select name,context,setting,unit,reset_val from pg_settings where  name like '%trace_sort%' order by setting;
   postgres=# alter system set trace_sort to 'ON';
   postgres=# select pg_reload_conf();
   postgres@instance-20220329-1520:~$ sudo systemctl restart postgresql


   postgres@instance-20220308-1903:~$ tail -200f /var/lib/postgresql/15/main/log/server_log."`date +%a`"
*/




--IMPROVE - CREATE INDEX 



