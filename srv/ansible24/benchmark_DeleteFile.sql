\timing


        -- size of table 
        SELECT pg_size_pretty( pg_total_relation_size('test2') );

--pg_sleep
SELECT clock_timestamp(), pg_sleep(10);


--DELETE --TRUNCATE IS FASTER THAN DELETE
--DELETE FROM test2;
TRUNCATE test2;

        -- size of table 
        SELECT pg_size_pretty( pg_total_relation_size('test2') );

--vacuum
vacuum test2;

        -- size of table 
        SELECT pg_size_pretty( pg_total_relation_size('test2') );


--DROP
drop table test2;

