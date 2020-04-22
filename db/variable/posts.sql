BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "post";

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.handle (
    value       HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.author (
    value       HANDLE,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(value) REFERENCES author.handle(value),
    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.active (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.header (
    value       HEADER,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.content (
    value       BODY,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.style (
    value       STYLE,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.searchable (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.commenting (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

COMMIT;
