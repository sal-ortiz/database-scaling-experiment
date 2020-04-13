

BEGIN;

  CREATE TABLE posts (
    handle      HANDLE    UNIQUE,
    active      BOOLEAN,
    author      HANDLE,
    header      HEADER,
    content     BODY,
    style       STYLE,
    searchable  BOOLEAN,
    commenting  BOOLEAN,

    FOREIGN KEY(author) REFERENCES authors(handle)
  );

COMMIT;
