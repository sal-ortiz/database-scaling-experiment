
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
      INSERT INTO usr.active(handle, value) VALUES (usr_handle, generate_boolean());
      INSERT INTO usr.password(handle, value) VALUES (usr_handle, generate_string());
      INSERT INTO usr.searchable(handle, value) VALUES (usr_handle, generate_boolean());
      INSERT INTO usr.commenting(handle, value) VALUES (usr_handle, generate_boolean());

      INSERT INTO contact.handle(value) VALUES (DEFAULT) RETURNING value INTO contact_handle;
      INSERT INTO contact.usr(handle, value) VALUES (contact_handle, usr_handle);
      INSERT INTO contact.email(handle, value) VALUES (contact_handle, generate_string());
      INSERT INTO contact.phone(handle, value) VALUES (contact_handle, generate_boolean());
      INSERT INTO contact.private(handle, value) VALUES (contact_handle, generate_boolean());
      INSERT INTO contact.searchable(handle, value) VALUES (contact_handle, generate_boolean());

      INSERT INTO author.handle(value) VALUES (DEFAULT) RETURNING value INTO author_handle;
      INSERT INTO author.usr(handle, value) VALUES (author_handle, usr_handle);
      INSERT INTO author.searchable(handle, value) VALUES (author_handle, generate_boolean());

      INSERT INTO post.handle(value) VALUES (DEFAULT) RETURNING value INTO post_handle;
      INSERT INTO post.author(handle, value) VALUES (post_handle, author_handle);
      INSERT INTO post.active(handle, value) VALUES (post_handle, generate_boolean());
      INSERT INTO post.header(handle, value) VALUES (post_handle, generate_string());
      INSERT INTO post.content(handle, value) VALUES (post_handle, generate_string());
      INSERT INTO post.style(handle, value) VALUES (post_handle, generate_string());
      INSERT INTO post.searchable(handle, value) VALUES (post_handle, generate_boolean());
      INSERT INTO post.commenting(handle, value) VALUES (post_handle, generate_boolean());

      INSERT INTO topic.handle(value) VALUES (DEFAULT) RETURNING value INTO topic_handle;
      INSERT INTO topic.post(handle, value) VALUES (topic_handle, post_handle);
      INSERT INTO topic.active(handle, value) VALUES (topic_handle, generate_boolean());
      INSERT INTO topic.content(handle, value) VALUES (topic_handle, generate_string());
      INSERT INTO topic.searchable(handle, value) VALUES (topic_handle, generate_boolean());

    END LOOP;

  END;

$$;
