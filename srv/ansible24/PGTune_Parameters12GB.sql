# DB Version: 14
# OS Type: linux
# DB Type: oltp
# Total Memory (RAM): 12 GB
# CPUs num: 4
# Connections num: 200
# Data Storage: ssd

ALTER SYSTEM SET
 max_connections = '200';
ALTER SYSTEM SET
 shared_buffers = '3GB';
ALTER SYSTEM SET
 effective_cache_size = '9GB';
ALTER SYSTEM SET
 maintenance_work_mem = '768MB';
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
 work_mem = '7864kB';
ALTER SYSTEM SET
 min_wal_size = '2GB';
ALTER SYSTEM SET
 max_wal_size = '8GB';
ALTER SYSTEM SET
 max_worker_processes = '4';
ALTER SYSTEM SET
 max_parallel_workers_per_gather = '2';
ALTER SYSTEM SET
 max_parallel_workers = '4';
ALTER SYSTEM SET
 max_parallel_maintenance_workers = '2';