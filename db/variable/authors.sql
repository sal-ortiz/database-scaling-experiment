BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "author";

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.handle (
    value       HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.active (
    value       BOOLEAN,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.email (
    value       EMAIL     UNIQUE,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.password (
    value       PASSWORD,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.searchable (
    value       BOOLEAN,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.commenting (
    value       BOOLEAN,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

COMMIT;
