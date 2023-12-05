
DO $$

  DECLARE usr_handle HANDLE;
  DECLARE contact_handle HANDLE;
  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT value INTO usr_handle FROM usr.handle TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT handle INTO contact_handle FROM contact.usr WHERE value = usr_handle LIMIT 1;
    SELECT handle INTO author_handle FROM author.usr WHERE value = usr_handle LIMIT 1;
    SELECT handle INTO post_handle FROM post.author WHERE value = author_handle LIMIT 1;
    SELECT handle INTO topic_handle FROM topic.post WHERE value = post_handle LIMIT 1;

    UPDATE usr.username SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = usr_handle;

    UPDATE usr.password SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = usr_handle;

    UPDATE usr.active SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = usr_handle;

    UPDATE usr.searchable SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = usr_handle;

    UPDATE usr.commenting SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = usr_handle;


    UPDATE contact.email SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = contact_handle;

    UPDATE contact.phone SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = contact_handle;

    UPDATE contact.private SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = contact_handle;

    UPDATE contact.searchable SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = contact_handle;


    UPDATE author.searchable SET
      value = generate_boolean(),
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

   UPDATE post.active SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = post_handle;

   UPDATE post.searchable SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = post_handle;

   UPDATE post.commenting SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = post_handle;


    UPDATE topic.searchable SET
      value = generate_boolean(),
      updated = NOW()
    WHERE handle = topic_handle;

    UPDATE topic.content SET
      value = generate_string(),
      updated = NOW()
    WHERE handle = topic_handle;

  END LOOP;

END;
$$
