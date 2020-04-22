
-- create empty schema for a single entityy.
--CREATE SCHEMA IF NOT EXISTS "public";

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

\include_relative authors.sql
\include_relative posts.sql
\include_relative topics.sql

SET search_path TO public;
