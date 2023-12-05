
BEGIN;

  CREATE TABLE contact (
    handle      HANDLE    UNIQUE DEFAULT generate_handle(),
    usr         HANDLE    NOT NULL,
    email       EMAIL     UNIQUE NOT NULL,
    phone       PHONE     DEFAULT NULL,
    private     BOOLEAN   DEFAULT true,
    searchable  BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(usr) REFERENCES usr(handle)
  );

COMMIT;
