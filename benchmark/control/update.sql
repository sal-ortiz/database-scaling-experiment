
DO $$

  DECLARE usr_handle HANDLE;
  DECLARE contact_handle HANDLE;
  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT handle INTO usr_handle FROM usr TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO contact_handle FROM contact WHERE usr = usr_handle LIMIT 1;
    SELECT handle INTO author_handle FROM author WHERE usr = usr_handle LIMIT 1;
    SELECT handle INTO post_handle FROM post WHERE author = author_handle LIMIT 1;
    SELECT handle INTO topic_handle FROM topic WHERE post = post_handle LIMIT 1;


    UPDATE usr SET
      username = generate_string(),
      password = generate_string(),
      active = generate_boolean(),
      searchable = generate_boolean(),
      commenting = generate_boolean(),
      updated = NOW()
    WHERE handle = usr_handle;

    UPDATE contact SET
      email = generate_string(),
      phone = generate_string(),
      private = generate_boolean(),
      searchable = generate_boolean(),
      updated = NOW()
    WHERE usr = usr_handle;

    UPDATE author SET
      searchable = generate_boolean(),
      updated = NOW()
    WHERE usr = usr_handle;

    UPDATE post SET
      header = generate_string(),
      content = generate_string(),
      style = generate_string(),
      active = generate_boolean(),
      searchable = generate_boolean(),
      commenting = generate_boolean(),
      updated = NOW()
    WHERE author = author_handle;

    UPDATE topic SET
      content = generate_string(),
      searchable = generate_boolean(),
      updated = NOW()
    WHERE post = post_handle;

  END LOOP;

END;
$$
