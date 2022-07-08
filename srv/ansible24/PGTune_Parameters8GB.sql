--# DB Version: 14
--# OS Type: linux
--# DB Type: oltp
--# Total Memory (RAM): 8 GB
--# CPUs num: 1
--# Connections num: 1000
--# Data Storage: ssd

ALTER SYSTEM SET
 shared_buffers = '2GB';
ALTER SYSTEM SET
 effective_cache_size = '6GB';
ALTER SYSTEM SET
 maintenance_work_mem = '512MB';
ALTER SYSTEM SET
 checkpoint_completion_target = '0.9';
ALTER SYSTEM SET
 wal_buffers = '16MB';
ALTER SYSTEM SET
 default_statistics_target = '100';
ALTER SYSTEM SET
 random_page_cost = '1.1';
ALTER SYSTEM SET
 effective_io_concurrency = '200';
ALTER SYSTEM SET
 work_mem = '1048kB';
ALTER SYSTEM SET
 min_wal_size = '2GB';
ALTER SYSTEM SET
 max_wal_size = '8GB';


 --reference: 
 --https://pgtune.leopard.in.ua/#/