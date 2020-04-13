

BEGIN;

  CREATE TABLE topics (
    handle      HANDLE    UNIQUE,
    active      BOOLEAN,
    post        HANDLE,
    content     HEADER,
    searchable  BOOLEAN,
    commenting  BOOLEAN,

    FOREIGN KEY(post) REFERENCES posts(handle)
  );

COMMIT;
