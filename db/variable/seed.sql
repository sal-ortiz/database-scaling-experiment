
DO $$

  DECLARE usr_handle HANDLE;
  DECLARE contact_handle HANDLE;
  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    INSERT INTO usr.handle(value) VALUES (DEFAULT) RETURNING value INTO usr_handle;
    INSERT INTO usr.username(handle, value) VALUES (usr_handle, generate_string());
    INSERT INTO usr.active(handle) VALUES (usr_handle);
    INSERT INTO usr.password(handle, value) VALUES (usr_handle, generate_string());
    INSERT INTO usr.searchable(handle) VALUES (usr_handle);
    INSERT INTO usr.commenting(handle) VALUES (usr_handle);

    INSERT INTO contact.handle(value) VALUES (DEFAULT) RETURNING value INTO contact_handle;
    INSERT INTO contact.usr(handle, value) VALUES (contact_handle, usr_handle);
    INSERT INTO contact.email(handle, value) VALUES (contact_handle, generate_string());
    INSERT INTO contact.phone(handle) VALUES (contact_handle);
    INSERT INTO contact.private(handle) VALUES (contact_handle);
    INSERT INTO contact.searchable(handle) VALUES (contact_handle);

    INSERT INTO author.handle(value) VALUES (DEFAULT) RETURNING value INTO author_handle;
    INSERT INTO author.usr(handle, value) VALUES (author_handle, usr_handle);
    INSERT INTO author.searchable(handle) VALUES (author_handle);

    INSERT INTO post.handle(value) VALUES (DEFAULT) RETURNING value INTO post_handle;
    INSERT INTO post.author(handle, value) VALUES (post_handle, author_handle);
    INSERT INTO post.active(handle) VALUES (post_handle);
    INSERT INTO post.header(handle) VALUES (post_handle);
    INSERT INTO post.content(handle) VALUES (post_handle);
    INSERT INTO post.style(handle) VALUES (post_handle);
    INSERT INTO post.searchable(handle) VALUES (post_handle);
    INSERT INTO post.commenting(handle) VALUES (post_handle);

    INSERT INTO topic.handle(value) VALUES (DEFAULT) RETURNING value INTO topic_handle;
    INSERT INTO topic.post(handle, value) VALUES (topic_handle, post_handle);
    INSERT INTO topic.active(handle) VALUES (topic_handle);
    INSERT INTO topic.content(handle) VALUES (topic_handle);
    INSERT INTO topic.searchable(handle) VALUES (topic_handle);

  END LOOP;

END;
$$;
