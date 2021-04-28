
DO $$

  DECLARE author_handle HANDLE;
  DECLARE author_email EMAIL;
  DECLARE author_password PASSWORD;

  DECLARE post_handle HANDLE;
  DECLARE post_header HEADER;
  DECLARE post_content BODY;
  DECLARE post_style STYLE;

  DECLARE topic_handle HANDLE;
  DECLARE topic_content HEADER;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT handle INTO author_handle FROM author TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO post_handle FROM post TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO topic_handle FROM topic TABLESAMPLE SYSTEM(1) LIMIT 1;


    SELECT email, password
      INTO author_email, author_password
    FROM author
    WHERE handle = author_handle LIMIT 1;

    SELECT header, content, style
      INTO post_header, post_content, post_style
    FROM post
    WHERE handle = post_handle LIMIT 1;

    SELECT content
      INTO topic_content
    FROM topic
    WHERE handle = topic_handle LIMIT 1;

  END LOOP;

END;
$$
