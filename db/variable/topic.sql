
BEGIN;

  -- create empty schema for a single entity.
  CREATE SCHEMA IF NOT EXISTS "topic";

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.handle (
    value       HANDLE      UNIQUE NOT NULL DEFAULT generate_handle(),

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.post (
    value       HANDLE,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(value) REFERENCES post.handle(value),
    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.active (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.content (
    value       HEADER,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.searchable (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

COMMIT;
