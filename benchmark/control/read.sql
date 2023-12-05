
DO $$

  DECLARE usr_handle HANDLE;
  DECLARE usr_name USERNAME;
  DECLARE usr_password PASSWORD;
  DECLARE usr_active BOOLEAN;
  DECLARE usr_searchable BOOLEAN;
  DECLARE usr_commenting BOOLEAN;

  DECLARE contact_handle HANDLE;
  DECLARE contact_email EMAIL;
  DECLARE contact_phone PHONE;
  DECLARE contact_private BOOLEAN;
  DECLARE contact_searchable BOOLEAN;

  DECLARE author_handle HANDLE;
  DECLARE author_searchable BOOLEAN;

  DECLARE post_handle HANDLE;
  DECLARE post_header HEADER;
  DECLARE post_content BODY;
  DECLARE post_style STYLE;
  DECLARE post_active BOOLEAN;
  DECLARE post_searchable BOOLEAN;
  DECLARE post_commenting BOOLEAN;

  DECLARE topic_handle HANDLE;
  DECLARE topic_content HEADER;
  DECLARE topic_searchable BOOLEAN;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT handle INTO usr_handle FROM usr TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO contact_handle FROM contact WHERE usr = usr_handle LIMIT 1;
    SELECT handle INTO author_handle FROM author WHERE usr = usr_handle LIMIT 1;
    SELECT handle INTO post_handle FROM post WHERE author = author_handle LIMIT 1;
    SELECT handle INTO topic_handle FROM topic WHERE post = post_handle LIMIT 1;


    SELECT
      username,
      password,
      active,
      searchable,
      commenting
    INTO usr_name, usr_password,  usr_active, usr_searchable, usr_commenting
    FROM usr
    WHERE handle = usr_handle LIMIT 1;

    SELECT
      email,
      phone,
      private,
      searchable
    INTO contact_email, contact_phone, contact_private, contact_searchable
    FROM contact
    --WHERE handle = contact_handle LIMIT 1;
    WHERE usr = usr_handle LIMIT 1;

    SELECT
      searchable
    INTO author_searchable
    FROM author
    --WHERE handle = author_handle LIMIT 1;
    WHERE usr = usr_handle LIMIT 1;

    SELECT header, content, style, active, searchable, commenting
    INTO post_header, post_content, post_style,
      post_active, post_searchable, post_commenting
    FROM post
    --WHERE handle = post_handle LIMIT 1;
    WHERE author = author_handle LIMIT 1;

    SELECT
      content,
      searchable
    INTO topic_content, topic_searchable
    FROM topic
    --WHERE handle = topic_handle LIMIT 1;
    WHERE post = post_handle LIMIT 1;

  END LOOP;

END;
$$
