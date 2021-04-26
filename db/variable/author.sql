BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "author";

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.handle (
    value       HANDLE    UNIQUE DEFAULT generate_handle(),

    readable    BOOLEAN   DEFAULT true,
    writeable   BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.active (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.email (
    value       EMAIL     UNIQUE NOT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,


    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.password (
    value       PASSWORD  NOT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,


    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.searchable (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,


    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.commenting (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

COMMIT;
