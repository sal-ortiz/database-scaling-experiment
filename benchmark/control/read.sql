
DO $$

  DECLARE usr_handle HANDLE;
  DECLARE usr_name USERNAME;
  DECLARE usr_password PASSWORD;

  --DECLARE contact_handle HANDLE;
  DECLARE contact_email EMAIL;
  DECLARE contact_phone PHONE;

  DECLARE author_handle HANDLE;
  DECLARE author_searchable BOOLEAN;

  DECLARE post_handle HANDLE;
  DECLARE post_header HEADER;
  DECLARE post_content BODY;
  DECLARE post_style STYLE;

  --DECLARE topic_handle HANDLE;
  DECLARE topic_content HEADER;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT handle INTO usr_handle FROM usr TABLESAMPLE SYSTEM(1) LIMIT 1;

    --SELECT handle INTO contact_handle FROM contact TABLESAMPLE SYSTEM(1) LIMIT 1;
    --SELECT handle INTO contact_handle FROM contact WHERE usr = usr_handle LIMIT 1;

    --SELECT handle INTO author_handle FROM author TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO author_handle FROM author WHERE usr = usr_handle LIMIT 1;

    --SELECT handle INTO post_handle FROM post TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO post_handle FROM post WHERE author = author_handle LIMIT 1;

    --SELECT handle INTO topic_handle FROM topic TABLESAMPLE SYSTEM(1) LIMIT 1;


    SELECT username, password
      INTO usr_name, usr_password
    FROM usr
    WHERE handle = usr_handle LIMIT 1;

    SELECT email, phone
      INTO contact_email, contact_phone
    FROM contact
    --WHERE handle = contact_handle LIMIT 1;
    WHERE usr = usr_handle LIMIT 1;

    SELECT searchable
      INTO author_searchable
    FROM author
    --WHERE handle = author_handle LIMIT 1;
    WHERE usr = usr_handle LIMIT 1;

    SELECT header, content, style
      INTO post_header, post_content, post_style
    FROM post
    --WHERE handle = post_handle LIMIT 1;
    WHERE author = author_handle LIMIT 1;

    SELECT content
      INTO topic_content
    FROM topic
    --WHERE handle = topic_handle LIMIT 1;
    WHERE post = post_handle LIMIT 1;

  END LOOP;

END;
$$
