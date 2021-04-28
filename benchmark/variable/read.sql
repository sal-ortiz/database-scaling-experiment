
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

    SELECT value INTO author_handle FROM author.handle TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT value INTO post_handle FROM post.handle TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT value INTO topic_handle FROM topic.handle TABLESAMPLE SYSTEM(1) LIMIT 1;


    SELECT email.value, password.value
      INTO author_email, author_password
    FROM author.handle handle
    INNER JOIN
      author.email email ON email.handle = author_handle
    INNER JOIN
      author.password password ON password.handle = author_handle
    WHERE handle.value = author_handle;

    SELECT header.value, content.value, style.value
      INTO post_header, post_content, post_style
    FROM post.handle handle
    INNER JOIN
      post.header header ON header.handle = post_handle
    INNER JOIN
      post.content content ON content.handle = post_handle
    INNER JOIN
      post.style style ON style.handle = post_handle
    WHERE handle.value = post_handle;

    SELECT content.value
      INTO topic_content
    FROM topic.handle handle
    INNER JOIN
      topic.content content ON content.handle = topic_handle
    WHERE handle.value = topic_handle;

  END LOOP;

END;
$$
