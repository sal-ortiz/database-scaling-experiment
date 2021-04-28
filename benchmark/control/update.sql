
DO $$

  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT handle INTO author_handle FROM author TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO post_handle FROM post TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO topic_handle FROM topic TABLESAMPLE SYSTEM(1) LIMIT 1;


    UPDATE author SET
      email = generate_string(),
      password = generate_string(),
      updated = NOW()
    WHERE handle = author_handle;

    UPDATE post SET
      header = generate_string(),
      content = generate_string(),
      style = generate_string(),
      updated = NOW()
    WHERE handle = post_handle;

    UPDATE topic SET
      content = generate_string(),
      updated = NOW()
    WHERE handle = topic_handle;


  END LOOP;

END;
$$
