BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "post";

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.handle (
    value       HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.author (
    value       HANDLE,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(value) REFERENCES author.handle(value),
    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.active (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.header (
    value       HEADER,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.content (
    value       BODY,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.style (
    value       STYLE,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.searchable (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE post.commenting (
    value       BOOLEAN,
    handle      HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES post.handle(value)
  );

COMMIT;

BEGIN;

  CREATE VIEW posts AS
    SELECT
      handle.value AS handle,
      active.value AS active,
      author.value AS author,
      header.value AS header,
      content.value AS content,
      style.value AS style,
      searchable.value AS searchable,
      commenting.value AS commenting

    FROM post.handle handle
    INNER JOIN post.active active ON handle.value = active.handle
    INNER JOIN post.author author ON handle.value = author.handle
    INNER JOIN post.header header ON handle.value = header.handle
    INNER JOIN post.style style ON handle.value = style.handle
    INNER JOIN post.content content ON handle.value = style.handle
    INNER JOIN post.searchable searchable ON handle.value = searchable.handle
    INNER JOIN post.commenting commenting ON handle.value = commenting.handle

    ORDER BY handle.created, handle.updated, handle.value DESC;

COMMIT;

BEGIN;

  CREATE RULE insertPostsHandle AS ON INSERT TO posts
    DO INSTEAD
      INSERT INTO post.handle(value)
      VALUES (NEW.handle);

  CREATE RULE insertPostsAuthor AS ON INSERT TO posts
    DO INSTEAD
      INSERT INTO post.author(value)
      VALUES (NEW.author);

  CREATE RULE insertPostsHeader AS ON INSERT TO posts
    DO INSTEAD
      INSERT INTO post.header(value)
      VALUES (NEW.header);

  CREATE RULE insertPostsContent AS ON INSERT TO posts
    DO INSTEAD
      INSERT INTO post.content(value)
      VALUES (NEW.content);

  CREATE RULE insertPostsStyle AS ON INSERT TO posts
    DO INSTEAD
      INSERT INTO post.style(value)
      VALUES (NEW.style);

  CREATE RULE insertPostsSearchable AS ON INSERT TO posts
    DO INSTEAD
      INSERT INTO post.searchable(value)
      VALUES (NEW.searchable);

  CREATE RULE insertPostsCommenting AS ON INSERT TO posts
    DO INSTEAD
      INSERT INTO post.commenting(value)
      VALUES (NEW.commenting);

COMMIT;

BEGIN;

  CREATE RULE updatePostsActive AS ON UPDATE TO posts
    DO INSTEAD
      UPDATE post.active active
      SET
        value = NEW.active
      WHERE NEW.active <> OLD.active
        AND active.handle = NEW.handle;

  CREATE RULE updatePostsAuthor AS ON UPDATE TO posts
    DO INSTEAD
      UPDATE post.author author
      SET
        value = NEW.author
      WHERE NEW.author <> OLD.author
        AND author.handle = NEW.handle;

  CREATE RULE updatePostsHeader AS ON UPDATE TO posts
    DO INSTEAD
      UPDATE post.header header
      SET
        value = NEW.header
      WHERE NEW.header <> OLD.header
        AND header.handle = NEW.handle;

  CREATE RULE updatePostsContent AS ON UPDATE TO posts
    DO INSTEAD
      UPDATE post.content content
      SET
        value = NEW.content
      WHERE NEW.content <> OLD.content
        AND content.handle = NEW.handle;

  CREATE RULE updatePostsStyle AS ON UPDATE TO posts
    DO INSTEAD
      UPDATE post.style style
      SET
        value = NEW.style
      WHERE NEW.style <> OLD.style
        AND style.handle = NEW.handle;

  CREATE RULE updatePostsSearchable AS ON UPDATE TO posts
    DO INSTEAD
      UPDATE post.searchable searchable
      SET
        value = NEW.searchable
      WHERE NEW.searchable <> OLD.searchable
        AND searchable.handle = NEW.handle;

  CREATE RULE updatePostsCommenting AS ON UPDATE TO posts
    DO INSTEAD
      UPDATE post.commenting commenting
      SET
        value = NEW.commenting
      WHERE NEW.commenting <> OLD.commenting
        AND commenting.handle = NEW.handle;

COMMIT;
