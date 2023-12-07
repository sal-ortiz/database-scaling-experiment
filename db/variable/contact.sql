BEGIN;

  -- create empty schema for a single entityy.
  CREATE SCHEMA IF NOT EXISTS "contact";

  CREATE TABLE contact.handle (
    value       HANDLE    UNIQUE DEFAULT generate_handle(),

    readable    BOOLEAN   DEFAULT true,
    writeable   BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  CREATE TABLE contact.usr (
    value       HANDLE    UNIQUE NOT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES contact.handle(value),
    FOREIGN KEY(value) REFERENCES usr.handle(value)
  );

  CREATE TABLE contact.email (
    value       EMAIL     UNIQUE NOT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES contact.handle(value)
  );

  CREATE TABLE contact.phone (
    value       PHONE     DEFAULT NULL,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES contact.handle(value)
  );

  CREATE TABLE contact.private (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES contact.handle(value)
  );

  CREATE TABLE contact.searchable (
    value       BOOLEAN   NOT NULL DEFAULT true,
    handle      HANDLE    UNIQUE NOT NULL,

    readable    BOOLEAN   NOT NULL DEFAULT true,
    writeable   BOOLEAN   NOT NULL DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(handle) REFERENCES contact.handle(value)
  );

  CREATE INDEX variable_contact_handle_value_index ON contact.handle(value);

  CREATE INDEX variable_contact_usr_value_index ON contact.usr(value);
  CREATE INDEX variable_contact_usr_handle_index ON contact.usr(handle);

  CREATE INDEX variable_contact_email_handle_index ON contact.email(handle);

  CREATE INDEX variable_contact_phone_handle_index ON contact.phone(handle);

  CREATE INDEX variable_contact_private_handle_index ON contact.private(handle);

  CREATE INDEX variable_contact_searchable_handle_index ON contact.searchable(handle);

COMMIT;
