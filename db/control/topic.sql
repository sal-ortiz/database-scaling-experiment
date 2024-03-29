

BEGIN;

  CREATE TABLE topic (
    handle      HANDLE    UNIQUE DEFAULT generate_handle(),
    active      BOOLEAN   DEFAULT true,
    post        HANDLE    NOT NULL,
    content     HEADER,
    searchable  BOOLEAN   DEFAULT true,

    created     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    updated     TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),

    FOREIGN KEY(post) REFERENCES post(handle)
  );

  CREATE INDEX control_topic_post_index ON topic(post);

COMMIT;
