BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "author";

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.handle (
    value       HANDLE      UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.active (
    value       BOOLEAN,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.email (
    value       EMAIL     UNIQUE,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.password (
    value       PASSWORD,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.searchable (
    value       BOOLEAN,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

  -- add a table, representing a single entity attribute.
  CREATE TABLE author.commenting (
    value       BOOLEAN,
    handle      HANDLE    UNIQUE,

    readable    BOOLEAN,
    writeable   BOOLEAN,

    created     TIMESTAMP,
    updated     TIMESTAMP,

    FOREIGN KEY(handle) REFERENCES author.handle(value)
  );

COMMIT;

BEGIN;

  CREATE VIEW authors AS
    SELECT
      handle.value AS handle,
      active.value AS active,
      email.value AS email,
      password.value AS password,
      searchable.value AS searchable,
      commenting.value AS commenting

    FROM author.handle handle
    INNER JOIN author.active active ON handle.value = active.handle
    INNER JOIN author.email email ON handle.value = email.handle
    INNER JOIN author.password password ON handle.value = password.handle
    INNER JOIN author.searchable searchable ON handle.value = searchable.handle
    INNER JOIN author.commenting commenting ON handle.value = commenting.handle

    ORDER BY handle.created, handle.updated, handle.value DESC;

COMMIT;

BEGIN;

  CREATE RULE insertAuthorsHandle AS ON INSERT TO authors
    DO INSTEAD
      INSERT INTO author.handle(value)
      VALUES (NEW.handle);

  CREATE RULE insertAuthorsActive AS ON INSERT TO authors
    DO INSTEAD
      INSERT INTO author.active(value)
      VALUES (NEW.active);

  CREATE RULE insertAuthorsEmail AS ON INSERT TO authors
    DO INSTEAD
      INSERT INTO author.email(value)
      VALUES (NEW.email);

  CREATE RULE insertAuthorsPassword AS ON INSERT TO authors
    DO INSTEAD
      INSERT INTO author.password(value)
      VALUES (NEW.password);

  CREATE RULE insertAuthorsSearchable AS ON INSERT TO authors
    DO INSTEAD
      INSERT INTO author.searchable(value)
      VALUES (NEW.searchable);

  CREATE RULE insertAuthorsCommenting AS ON INSERT TO authors
    DO INSTEAD
      INSERT INTO author.commenting(value)
      VALUES (NEW.commenting);

COMMIT;

BEGIN;

  CREATE RULE updateAuthorsActive AS ON UPDATE TO authors
    DO INSTEAD
      UPDATE author.active active
      SET
        value = NEW.active
      WHERE NEW.active <> OLD.active
        AND active.handle = NEW.handle;

  CREATE RULE updateAuthorsEmail AS ON UPDATE TO authors
    DO INSTEAD
      UPDATE author.email email
      SET
        value = NEW.email
      WHERE NEW.email <> OLD.email
        AND email.handle = NEW.handle;

  CREATE RULE updateAuthorsPassword AS ON UPDATE TO authors
    DO INSTEAD
      UPDATE author.password password
      SET
        value = NEW.password
      WHERE NEW.password <> OLD.password
        AND password.handle = NEW.handle;

  CREATE RULE updateAuthorsSearchable AS ON UPDATE TO authors
    DO INSTEAD
      UPDATE author.searchable searchable
      SET
        value = NEW.searchable
      WHERE NEW.searchable <> OLD.searchable
        AND searchable.handle = NEW.handle;

  CREATE RULE updateAuthorsCommenting AS ON UPDATE TO authors
    DO INSTEAD
      UPDATE author.commenting commenting
      SET
        value = NEW.commenting
      WHERE NEW.commenting <> OLD.commenting
        AND commenting.handle = NEW.handle;

COMMIT;
