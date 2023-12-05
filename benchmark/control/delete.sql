
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

    DELETE FROM topic WHERE handle = topic_handle;
    DELETE FROM post WHERE handle = post_handle;
    DELETE FROM author WHERE handle = author_handle;
    DELETE from contact WHERE handle = contact_handle;
    DELETE from usr WHERE handle = usr_handle;

  END LOOP;

END;
$$
