
BEGIN;

  CREATE TABLE author (
    handle      HANDLE    UNIQUE DEFAULT generate_handle(),
    active      BOOLEAN   DEFAULT true,
    email       EMAIL     UNIQUE NOT NULL,
    password    PASSWORD  NOT NULL,
    searchable  BOOLEAN   DEFAULT true,
    commenting  BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')

  );

  CREATE FUNCTION most_recent_author_handle() RETURNS HANDLE AS
    'SELECT handle FROM author ORDER BY created DESC LIMIT 1'
  LANGUAGE SQL;

COMMIT;
