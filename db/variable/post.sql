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

  CREATE INDEX variable_post_handle_value_index ON post.handle(value);

  CREATE INDEX variable_post_author_value_index ON post.author(value);
  CREATE INDEX variable_post_author_handle_index ON post.author(handle);

  CREATE INDEX variable_post_active_handle_index ON post.active(handle);

  CREATE INDEX variable_post_header_handle_index ON post.header(handle);

  CREATE INDEX variable_post_content_handle_index ON post.content(handle);

  CREATE INDEX variable_post_style_handle_index ON post.style(handle);

  CREATE INDEX variable_post_searchable_handle_index ON post.searchable(handle);

  CREATE INDEX variable_post_commenting_handle_index ON post.commenting(handle);

COMMIT;
