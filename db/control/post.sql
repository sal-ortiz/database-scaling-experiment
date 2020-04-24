

BEGIN;

  CREATE TABLE post (
    handle      HANDLE    UNIQUE DEFAULT generate_handle(),
    active      BOOLEAN   DEFAULT true,
    author      HANDLE    DEFAULT most_recent_author_handle(),
    header      HEADER,
    content     BODY,
    style       STYLE,
    searchable  BOOLEAN   DEFAULT true,
    commenting  BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(author) REFERENCES author(handle)
  );

  CREATE FUNCTION most_recent_post_handle() RETURNS HANDLE AS
    'SELECT handle FROM post ORDER BY created DESC LIMIT 1'
  LANGUAGE SQL;

COMMIT;
