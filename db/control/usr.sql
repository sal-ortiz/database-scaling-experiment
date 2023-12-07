
BEGIN;

  CREATE TABLE usr (
    handle      HANDLE    UNIQUE DEFAULT generate_handle(),
    username    USERNAME  UNIQUE NOT NULL,
    active      BOOLEAN   DEFAULT true,
    password    PASSWORD  NOT NULL,
    searchable  BOOLEAN   DEFAULT true,
    commenting  BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
  );

  CREATE INDEX control_usr_handle_index ON usr(handle);

COMMIT;
