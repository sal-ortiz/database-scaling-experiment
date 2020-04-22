
BEGIN;

  -- create empty schema for a single entity.
  CREATE SCHEMA IF NOT EXISTS "topic";

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.handle (
    value       HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.post (
    value       HANDLE,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(value) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.content (
    value       HEADER      UNIQUE,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.active (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.searchable (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

COMMIT;
