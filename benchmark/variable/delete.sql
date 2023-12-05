
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


    DELETE FROM contact.usr WHERE handle = contact_handle;
    DELETE FROM contact.email WHERE handle = contact_handle;
    DELETE FROM contact.phone WHERE handle = contact_handle;
    DELETE FROM contact.private WHERE handle = contact_handle;
    DELETE FROM contact.searchable WHERE handle = contact_handle;
    --DELETE FROM contact.handle WHERE value = contact_handle;

    DELETE FROM usr.username WHERE handle = usr_handle;
    DELETE FROM usr.active WHERE handle = usr_handle;
    DELETE FROM usr.password WHERE handle = usr_handle;
    DELETE FROM usr.searchable WHERE handle = usr_handle;
    DELETE FROM usr.commenting WHERE handle = usr_handle;
    --DELETE FROM usr.handle WHERE value = usr_handle;

    DELETE FROM topic.post WHERE handle = topic_handle;
    DELETE FROM topic.content WHERE handle = topic_handle;
    DELETE FROM topic.searchable WHERE handle = topic_handle;
    DELETE FROM topic.active WHERE handle = topic_handle;
    --DELETE FROM topic.handle WHERE value = topic_handle;

    DELETE FROM post.author WHERE handle = post_handle;
    DELETE FROM post.active WHERE handle = post_handle;
    DELETE FROM post.header WHERE handle = post_handle;
    DELETE FROM post.content WHERE handle = post_handle;
    DELETE FROM post.style WHERE handle = post_handle;
    DELETE FROM post.searchable WHERE handle = post_handle;
    DELETE FROM post.commenting WHERE handle = post_handle;
    --DELETE FROM post.handle WHERE value = post_handle;

    DELETE FROM author.usr WHERE handle = author_handle;
    DELETE FROM author.searchable WHERE handle = author_handle;
    --DELETE FROM author.handle WHERE value = author_handle;

    DELETE FROM topic.handle WHERE value = topic_handle;
    DELETE FROM post.handle WHERE value = post_handle;
    DELETE FROM author.handle WHERE value = author_handle;
    DELETE FROM contact.handle WHERE value = contact_handle;
    DELETE FROM usr.handle WHERE value = usr_handle;

  END LOOP;

END;
$$
