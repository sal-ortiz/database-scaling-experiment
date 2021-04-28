
DO $$

  DECLARE author_handle HANDLE;
  DECLARE post_handle HANDLE;
  DECLARE topic_handle HANDLE;

BEGIN

  FOR idx IN 1..1000 LOOP

    SELECT value INTO author_handle FROM author.handle TABLESAMPLE SYSTEM(1) LIMIT 1;
    SELECT value INTO post_handle FROM post.handle WHERE value = author_handle LIMIT 1;
    SELECT value INTO topic_handle FROM topic.handle WHERE value = post_handle LIMIT 1;


    DELETE FROM topic.handle WHERE value = topic_handle;
    DELETE FROM topic.post WHERE handle = topic_handle;
    DELETE FROM topic.active WHERE handle = topic_handle;
    DELETE FROM topic.content WHERE handle = topic_handle;
    DELETE FROM topic.searchable WHERE handle = topic_handle;

    DELETE FROM post.handle WHERE value = post_handle;
    DELETE FROM post.author WHERE handle = author_handle;
    DELETE FROM post.active WHERE handle = post_handle;
    DELETE FROM post.header WHERE handle = post_handle;
    DELETE FROM post.content WHERE handle = post_handle;
    DELETE FROM post.style WHERE handle = post_handle;
    DELETE FROM post.searchable WHERE handle = post_handle;
    DELETE FROM post.commenting WHERE handle = post_handle;

    DELETE FROM topic.handle WHERE value = topic_handle;
    DELETE FROM topic.post WHERE handle = post_handle;
    DELETE FROM topic.active WHERE handle = topic_handle;
    DELETE FROM topic.content WHERE handle = topic_handle;
    DELETE FROM topic.searchable WHERE handle = topic_handle;


  END LOOP;

END;
$$