
DO $$

  DECLARE usr_handle HANDLE;
  DECLARE contact_handle HANDLE;
  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

      INSERT INTO usr(handle, username, active, password, searchable, commenting)
        VALUES (
          DEFAULT,
          generate_string(),
          DEFAULT,
          generate_string(),
          DEFAULT,
          DEFAULT
        )
      RETURNING handle INTO usr_handle;

      INSERT INTO contact(handle, usr, email, phone, private, searchable)
        VALUES (
          DEFAULT,
          usr_handle,
          generate_string(),
          DEFAULT,
          DEFAULT,
          DEFAULT
        )
      RETURNING handle INTO contact_handle;

      INSERT INTO author(handle, usr, searchable)
        VALUES (
          DEFAULT,
          usr_handle,
          DEFAULT
        )
      RETURNING handle INTO author_handle;

      INSERT INTO post(handle, author, active, header, content, style, searchable, commenting)
        VALUES (
          DEFAULT,
          author_handle,
          DEFAULT,
          generate_string(),
          generate_string(),
          generate_string(),
          DEFAULT,
          DEFAULT
        )
      RETURNING handle INTO post_handle;

      INSERT INTO topic(handle, post, active, content, searchable)
        VALUES (
          DEFAULT,
          post_handle,
          DEFAULT,
          generate_string(),
          DEFAULT
        )
      RETURNING handle INTO topic_handle;

  END LOOP;

END;
$$;
