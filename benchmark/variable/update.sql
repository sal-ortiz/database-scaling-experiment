
DO $$

  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT value INTO author_handle FROM author.handle TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT value INTO post_handle FROM post.handle TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT value INTO topic_handle FROM topic.handle TABLESAMPLE SYSTEM(1) LIMIT 1;


    UPDATE author.email SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = author_handle;

    UPDATE author.password SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = author_handle;


    UPDATE post.header SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = post_handle;

    UPDATE post.content SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = post_handle;

    UPDATE post.style SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = post_handle;


    UPDATE topic.content SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = topic_handle;


  END LOOP;

END;
$$
