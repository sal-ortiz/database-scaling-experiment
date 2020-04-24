
-- create simplified data types.
CREATE DOMAIN ID INTEGER;
CREATE DOMAIN EMAIL VARCHAR(320);
CREATE DOMAIN HANDLE VARCHAR(64);
CREATE DOMAIN PASSWORD CHAR(512);
CREATE DOMAIN HEADER TEXT;
CREATE DOMAIN BODY TEXT;
CREATE DOMAIN STYLE TEXT;
CREATE DOMAIN TOPIC VARCHAR(24);
CREATE DOMAIN ACTION VARCHAR(64);

\include_relative ../util.sql
\include_relative author.sql
\include_relative post.sql
\include_relative topic.sql

SET search_path TO post, topic, author;
