
DO $$

  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    INSERT INTO author.handle(value) VALUES (DEFAULT) RETURNING value INTO author_handle;

    INSERT INTO author.active(handle) VALUES (author_handle);
    INSERT INTO author.email(handle, value) VALUES (author_handle, generate_string());
    INSERT INTO author.password(handle, value) VALUES (author_handle, generate_string());
    INSERT INTO author.searchable(handle) VALUES (author_handle);
    INSERT INTO author.commenting(handle) VALUES (author_handle);


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
