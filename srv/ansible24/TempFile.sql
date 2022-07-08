CREATE  temp TABLE COMPANY1(
   NAME           TEXT    NOT NULL
);

create temp table testnumeric (
  id1  numeric,
  id2  numeric,
  id3  numeric,
  id4  numeric,
  id5  numeric,
  id6  numeric,
  id7  numeric,
  id8  numeric,
  id9  numeric,
  id10 numeric)
with (oids = false);



do
$do$
declare
     i int;
begin
for  i in 1..10000
loop
            INSERT INTO COMPANY1 (NAME) SELECT MD5(random()::text);
end loop;
end;
$do$;

do
$do$
declare
     i int;
begin
for  i in 1..10000
loop
    insert into testnumeric  values (random(), i * random(), i / random(), i + random(), i * random(), i / random(), i + random(), i * random(), i / random(), i + random());
end loop;
end;
$do$;



do
$do$
declare
     i int;
begin
for  i in 1..10
loop
            INSERT INTO COMPANY1 (NAME) SELECT sha512('random()::text');
end loop;
end;
$do$;
