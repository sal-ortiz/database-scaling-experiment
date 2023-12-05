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

  CREATE TABLE author.usr (
    value       HANDLE    UNIQUE NOT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES author.handle(value),
    FOREIGN KEY(value) REFERENCES usr.handle(value)
  );

  CREATE TABLE author.searchable (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,


    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

COMMIT;
