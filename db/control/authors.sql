
BEGIN;

  CREATE TABLE authors (
    handle      HANDLE    UNIQUE,
    active      BOOLEAN,
    email       EMAIL     UNIQUE,
    password    PASSWORD,
    searchable  BOOLEAN,
    commenting  BOOLEAN
  );

COMMIT;
