BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "post";

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.handle (
    value       HANDLE      UNIQUE NOT NULL DEFAULT generate_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  CREATE FUNCTION most_recent_post_handle() RETURNS HANDLE AS
    'SELECT value FROM post.handle ORDER BY created DESC LIMIT 1'
  LANGUAGE SQL;

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.author (
    value       HANDLE      UNIQUE DEFAULT most_recent_author_handle(),
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_post_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(value) REFERENCES author.handle(value),
    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.active (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_post_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.header (
    value       HEADER,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_post_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.content (
    value       BODY,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_post_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.style (
    value       STYLE,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_post_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.searchable (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_post_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.commenting (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_post_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

COMMIT;
