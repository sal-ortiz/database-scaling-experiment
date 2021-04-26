
DO $$

  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    INSERT INTO author(email, password) VALUES
      (generate_string(), generate_string())
    RETURNING handle INTO author_handle;

    INSERT INTO post(author) VALUES
      (author_handle)
    RETURNING handle INTO post_handle;

    INSERT INTO topic(post) VALUES (post_handle);

  END LOOP;

END;
$$;
