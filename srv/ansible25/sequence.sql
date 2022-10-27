--POSTGRESQL SEQUENCE

\timing
\pset pager off


CREATE SEQUENCE mysequence
INCREMENT 1
START 1;

SELECT nextval('mysequence');

SELECT currval('mysequence');



-- Creating a sequence associated with a table column
CREATE  TABLE testsequencetbl(
   ID   integer    NOT NULL
);


CREATE SEQUENCE testsequencetbl_id
START 1
INCREMENT 1
MINVALUE 1
OWNED BY testsequencetbl.ID;



do
$do$
declare
     i int;
begin
for  i in 1..10000
loop
          INSERT INTO     testsequencetbl(id) VALUES     (nextval('testsequencetbl_id'));
end loop;
end;
$do$;




--SELECT 
SELECT
     ID
FROM
    testsequencetbl;     


--Listing all sequences in a database
SELECT
    relname sequence_name
FROM 
    pg_class 
WHERE 
    relkind = 'S';


--drop sequence 
DROP SEQUENCE mysequence;
DROP SEQUENCE testsequencetbl_id;


--drop table 
drop table testsequencetbl;




/*
Layout of Databases files: 
     /var/lib/postgresql/
     /var/lib/postgresql/15/main/base
*/



/*
references: 


*/
