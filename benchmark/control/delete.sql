
DO $$

  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT handle INTO author_handle FROM author TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO post_handle FROM post WHERE author = author_handle LIMIT 1;
    SELECT handle INTO topic_handle FROM topic WHERE post = post_handle LIMIT 1;


    DELETE FROM topic WHERE handle = topic_handle;
    DELETE FROM post WHERE handle = post_handle;
    DELETE FROM author WHERE handle = author_handle;


  END LOOP;

END;
$$
