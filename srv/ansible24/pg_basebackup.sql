create table posts (
  id integer,
  title character varying(100),
  content text,
  published_at timestamp without time zone,
  type character varying(100)
);


insert into posts (id, title, content, published_at, type) values
(100, 'Intro to SQL', 'Epic SQL Content', '2018-01-01', 'SQL'),
(101, 'Intro to PostgreSQL', 'PostgreSQL is awesome!', now(), 'PostgreSQL');