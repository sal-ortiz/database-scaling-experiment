
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


BEGIN;

  CREATE VIEW topics AS
    SELECT
      handle.value AS handle,
      active.value AS active,
      post.value AS post,
      content.value AS content,
      searchable.value AS searchable

    FROM topic.handle handle
    INNER JOIN topic.active active ON handle.value = active.handle
    INNER JOIN topic.post post ON handle.value = post.handle
    INNER JOIN topic.content content ON handle.value = content.handle
    INNER JOIN topic.searchable searchable ON handle.value = searchable.handle

    ORDER BY handle.created, handle.updated, handle.value DESC;

COMMIT;


BEGIN;

  CREATE RULE insertTopicsHandle AS ON INSERT TO topics
    DO INSTEAD
      INSERT INTO topic.handle(value)
      VALUES (NEW.handle);

  CREATE RULE insertTopicsActive AS ON INSERT TO topics
    DO INSTEAD
      INSERT INTO topic.active(value)
      VALUES (NEW.active);

  CREATE RULE insertTopicsPost AS ON INSERT TO topics
    DO INSTEAD
      INSERT INTO topic.post(value)
      VALUES (NEW.post);

  CREATE RULE insertTopicsContent AS ON INSERT TO topics
    DO INSTEAD
      INSERT INTO topic.content(value)
      VALUES (NEW.content);

  CREATE RULE insertTopicsSearchable AS ON INSERT TO topics
    DO INSTEAD
      INSERT INTO topic.searchable(value)
      VALUES (NEW.searchable);


  CREATE RULE updateTopicsActive AS ON UPDATE TO topics
    DO INSTEAD
      UPDATE topic.active active
      SET
        value = NEW.active
      WHERE NEW.active <> OLD.active
        AND active.handle = NEW.handle;

  CREATE RULE updateTopicsPost AS ON UPDATE TO topics
    DO INSTEAD
      UPDATE topic.post post
      SET
        value = NEW.post
      WHERE NEW.post <> OLD.post
        AND post.handle = NEW.handle;

  CREATE RULE updateTopicsContent AS ON UPDATE TO topics
    DO INSTEAD
      UPDATE topic.content content
      SET
        value = NEW.content
      WHERE NEW.content <> OLD.content
        AND content.handle = NEW.handle;

  CREATE RULE updateTopicsSearchable AS ON UPDATE TO topics
    DO INSTEAD
      UPDATE topic.searchable searchable
      SET
        value = NEW.searchable
      WHERE NEW.searchable <> OLD.searchable
        AND searchable.handle = NEW.handle;


COMMIT;
