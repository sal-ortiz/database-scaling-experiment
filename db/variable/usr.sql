BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "usr";

  CREATE TABLE usr.handle (
    value       HANDLE    UNIQUE DEFAULT generate_handle(),

    readable    BOOLEAN   DEFAULT true,
    writeable   BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  CREATE TABLE usr.username (
    value       USERNAME  UNIQUE NOT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES usr.handle(value)
  );

  CREATE TABLE usr.active (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES usr.handle(value)
  );

  CREATE TABLE usr.password (
    value       PASSWORD  NOT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES usr.handle(value)
  );

  CREATE TABLE usr.searchable (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES usr.handle(value)
  );

  CREATE TABLE usr.commenting (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES usr.handle(value)
  );

  CREATE INDEX variable_usr_handle_value_index ON usr.handle(value);

  CREATE INDEX variable_usr_username_handle_index ON usr.username(handle);

  CREATE INDEX variable_usr_active_handle_index ON usr.active(handle);

  CREATE INDEX variable_usr_password_handle_index ON usr.password(handle);

  CREATE INDEX variable_usr_searchable_handle_index ON usr.searchable(handle);

  CREATE INDEX variable_usr_commenting_handle_index ON usr.commenting(handle);

COMMIT;
