
BEGIN;

  -- create empty schema for a single entity.
  CREATE SCHEMA IF NOT EXISTS "topic";

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.handle (
    value       HANDLE      UNIQUE NOT NULL DEFAULT generate_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  CREATE FUNCTION most_recent_topic_handle() RETURNS HANDLE AS
    'SELECT value FROM topic.handle ORDER BY created DESC LIMIT 1'
  LANGUAGE SQL;

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.post (
    value       HANDLE      DEFAULT most_recent_post_handle(),
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_topic_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(value) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.content (
    value       HEADER,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_topic_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.active (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_topic_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE topic.searchable (
    value       BOOLEAN     NOT NULL DEFAULT true,
    handle      HANDLE      UNIQUE NOT NULL DEFAULT most_recent_topic_handle(),

    readable    BOOLEAN     DEFAULT true,
    writeable   BOOLEAN     DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES topic.handle(value)
  );

COMMIT;
