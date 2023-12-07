
BEGIN;

  CREATE TABLE author (
    handle      HANDLE    UNIQUE DEFAULT generate_handle(),
    usr         HANDLE    NOT NULL,
    searchable  BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(usr) REFERENCES usr(handle)
  );

  CREATE INDEX control_author_usr_index ON author(usr);

COMMIT;
