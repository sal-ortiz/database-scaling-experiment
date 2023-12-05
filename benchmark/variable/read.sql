
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
  DECLARE topic_active BOOLEAN;
  DECLARE topic_searchable BOOLEAN;


BEGIN

  -- TODO: perform each table update from it's own transaction


  FOR idx IN 1..1000 LOOP

    SELECT value INTO usr_handle FROM usr.handle TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO contact_handle FROM contact.usr WHERE value = usr_handle LIMIT 1;
    SELECT handle INTO author_handle FROM author.usr WHERE value = usr_handle LIMIT 1;
    SELECT handle INTO post_handle FROM post.author WHERE value = author_handle LIMIT 1;
    SELECT handle INTO topic_handle FROM topic.post WHERE value = post_handle LIMIT 1;

    SELECT
      username.value,
      password.value,
      active.value,
      searchable.value,
      commenting.value
    INTO usr_name, usr_password, usr_active, usr_searchable, usr_commenting
    FROM usr.handle handle
    INNER JOIN
      usr.username username ON username.handle = usr_handle
    INNER JOIN
      usr.password password ON password.handle = usr_handle
    INNER JOIN usr.active active ON active.handle = usr_handle
    INNER JOIN usr.searchable searchable ON searchable.handle = usr_handle
    INNER JOIN usr.commenting commenting ON commenting.handle = usr_handle
    WHERE handle.value = usr_handle
    LIMIT 1;

    SELECT
      email.value,
      phone.value,
      private.value,
      searchable.value
    INTO contact_email, contact_phone, contact_private, contact_searchable
    FROM contact.handle handle
    INNER JOIN contact.email email ON email.handle = contact_handle
    INNER JOIN contact.phone phone ON phone.handle = contact_handle
    INNER JOIN contact.private private ON private.handle = contact_handle
    INNER JOIN contact.searchable searchable ON searchable.handle = contact_handle
    INNER JOIN contact.usr usr ON usr.handle = contact_handle
    WHERE usr.value = usr_handle
    LIMIT 1;

    SELECT
      searchable.value
    INTO author_searchable
    FROM author.handle handle
    INNER JOIN author.searchable searchable ON searchable.handle = author_handle
    INNER JOIN author.usr usr ON usr.handle = author_handle
    WHERE usr.value = usr_handle
    LIMIT 1;

    SELECT
      header.value,
      content.value,
      style.value,
      active.value,
      searchable.value,
      commenting.value
    INTO post_header, post_content, post_style, post_active,
      post_searchable, post_commenting
    FROM post.handle handle
    INNER JOIN post.header header ON header.handle = post_handle
    INNER JOIN post.content content ON content.handle = post_handle
    INNER JOIN post.style style ON style.handle = post_handle
    INNER JOIN post.active ON active.handle = post_handle
    INNER JOIN post.searchable ON searchable.handle = post_handle
    INNER JOIN post.commenting ON commenting.handle = post_handle
    INNER JOIN post.author author ON author.handle = post_handle
    WHERE author.value = author_handle
    LIMIT 1;

    SELECT
      content.value,
      searchable.value
    INTO topic_content, topic_searchable
    FROM topic.handle handle
    INNER JOIN topic.content content ON content.handle = topic_handle
    INNER JOIN topic.searchable searchable ON searchable.handle = topic_handle
    INNER JOIN topic.post post ON post.handle = topic_handle
    WHERE post.value = post_handle
    LIMIT 1;

  END LOOP;

END;
$$
