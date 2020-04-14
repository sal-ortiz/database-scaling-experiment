CREATE SCHEMA IF NOT EXISTS "statistics";

BEGIN;

  CREATE TABLE statistics.operations (
    handle    HANDLE UNIQUE NOT NULL
  );

  INSERT INTO statistics.operations(handle)
    VALUES ('create'), ('retrieve'), ('update'), ('delete');

  CREATE TABLE statistics.steps (
    handle    HANDLE UNIQUE NOT NULL
  );

  INSERT INTO statistics.steps(handle)
    VALUES ('begin'), ('end');

  CREATE TABLE statistics.actions (
    timestamp   REAL,
    operation   HANDLE,
    size        BIGINT,
    step        HANDLE,

    FOREIGN KEY(operation) REFERENCES statistics.operations(handle),
    FOREIGN KEY(step) REFERENCES statistics.steps(handle)
  );

COMMIT;
