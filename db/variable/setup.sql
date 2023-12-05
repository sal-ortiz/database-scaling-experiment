
\include_relative ../util.sql
\include_relative usr.sql
\include_relative contact.sql
\include_relative author.sql
\include_relative post.sql
\include_relative topic.sql

SET search_path TO usr, contact, post, topic, author;
