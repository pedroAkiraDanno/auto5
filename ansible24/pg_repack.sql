
/* pg_repack */





























/*
    source code: 
    https://github.com/reorg/pg_repack

*/









/*

pg_repack -- Reorganize tables in PostgreSQL databases with minimal locks
Homepage: https://reorg.github.io/pg_repack
Download: https://pgxn.org/dist/pg_repack/
Development: https://github.com/reorg/pg_repack
Bug Report: https://github.com/reorg/pg_repack/issues
Linux and OSX build status

pg_repack is a PostgreSQL extension which lets you remove bloat from tables and indexes, and optionally restore the physical order of clustered indexes. Unlike CLUSTER and VACUUM FULL it works online, without holding an exclusive lock on the processed tables during processing. pg_repack is efficient to boot, with performance comparable to using CLUSTER directly.

Please check the documentation (in the doc directory or online) for installation and usage instructions.

What about pg_reorg?
pg_repack is a fork of the pg_reorg project, which has proven hugely successful. Unfortunately new feature development on pg_reorg has slowed or stopped since late 2011.

pg_repack was initially released as a drop-in replacement for pg_reorg, addressing some of the shortcomings of the last pg_reorg version (such as support for PostgreSQL 9.2 and EXTENSION packaging) and known bugs.

pg_repack 1.2 introduces further new features (parallel index builds, ability to rebuild only indexes) and bugfixes. In some cases its behaviour may be different from the 1.1.x release so it shouldn't be considered a drop-in replacement: you are advised to check the documentation before upgrading from previous versions.



ref: https://github.com/reorg/pg_repack
*/






/*
Using pg_repack to Rebuild PostgreSQL Database Objects Online


*/






/*
Part 22 - PostgreSQL : What is Pg_repack utility ( Online object rebuild ).

What is pg_repack utility in PotsgreSQL

pg_repack utility to rebuld postgresql database objects online.

pg_repack is a postgresql extension which lets you remove bloat from table and indexes.

restore the physical order of clustered indexes. 

pg_repack is an extension available for postgresql that helps to rebuld a table onle 



Advantages of using pg_repack

release storege from a table to disk/fs 

rebuld a table reduces I/O

RELEASE storege piled due dead tuples as bloat 
and not cleared by autovaccum process 



step1. how to install pg_repack

    # yum install pg_repack12

    sudo su - postgresql 

    psql 
    psql# set shared_preload_libraries = 'pg_repack';

    /usr/pgsql-14/bin/pg_ctl -D $PGDATA restart -mf





step2. create this extension in database/s where you are planning to execute it. 

    sudo su - postgres

    psql 
    postgres# \c test; 
    postgres# CREATE EXTENSION pg_repack; 



step 3. pg_repack utility to Rebuild table online. 
    $ pg_repack --dry-run -d pgbench --table pgbench_accounts
    $ pg_repack -d pgbench --table pgbench_accounts 

    or 

step4. how to rebuild an entire database using pg_repack 
    $ pg_repack --dry-run -d pgbench 
    $ pg_repack -d pgbench -j 2


This can be run remotely also, only condition is version of pg_repack must be same. 

Appendix 

DROP EXTENSION pg_repack; 

yum remove pg_repack12




ref: https://www.youtube.com/watch?v=jfn1FA6zyUE
*/




