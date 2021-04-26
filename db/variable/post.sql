BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "post";

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.handle (
    value       HANDLE      UNIQUE NOT NULL DEFAULT generate_handle(),

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.author (
    value       HANDLE      UNIQUE,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(value) REFERENCES author.handle(value),
    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.active (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.header (
    value       HEADER,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.content (
    value       BODY,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.style (
    value       STYLE,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.searchable (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.commenting (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL,

    readable    BOOLEAN     NOT NULL DEFAULT true,
    writeable   BOOLEAN     NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

COMMIT;
