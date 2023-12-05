
-- create simplified data types.
CREATE DOMAIN USERNAME VARCHAR(32);
CREATE DOMAIN EMAIL VARCHAR(64);
CREATE DOMAIN PHONE VARCHAR(32);
CREATE DOMAIN HANDLE VARCHAR(32);
CREATE DOMAIN PASSWORD VARCHAR(32);
CREATE DOMAIN HEADER TEXT;
CREATE DOMAIN BODY TEXT;
CREATE DOMAIN STYLE TEXT;
CREATE DOMAIN ACTION VARCHAR(64);
CREATE DOMAIN TS TIMESTAMP WITHOUT TIME ZONE;

\include_relative ../util.sql
\include_relative usr.sql
\include_relative contact.sql
\include_relative author.sql
\include_relative post.sql
\include_relative topic.sql

SET search_path TO usr, contact, post, topic, author;
