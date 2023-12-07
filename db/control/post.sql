

BEGIN;

  CREATE TABLE post (
    handle      HANDLE    UNIQUE DEFAULT generate_handle(),
    active      BOOLEAN   DEFAULT true,
    author      HANDLE    NOT NULL,
    header      HEADER,
    content     BODY,
    style       STYLE,
    searchable  BOOLEAN   DEFAULT true,
    commenting  BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(author) REFERENCES author(handle)
  );

  CREATE INDEX control_post_author_index ON post(author);

COMMIT;
