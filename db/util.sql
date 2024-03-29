-- create simplified data types.
CREATE DOMAIN USERNAME VARCHAR(32);
CREATE DOMAIN EMAIL VARCHAR(64);
CREATE DOMAIN PHONE VARCHAR(32);
CREATE DOMAIN HANDLE VARCHAR(32);
CREATE DOMAIN PASSWORD VARCHAR(32);
CREATE DOMAIN HEADER TEXT;
CREATE DOMAIN BODY TEXT;
CREATE DOMAIN STYLE TEXT;
CREATE DOMAIN ACTION VARCHAR(64);
CREATE DOMAIN TS TIMESTAMP WITHOUT TIME ZONE;


CREATE FUNCTION generate_handle() RETURNS HANDLE AS
  'SELECT SUBSTR(MD5(RANDOM()::TEXT), 0, 33)::HANDLE'
LANGUAGE SQL;

CREATE FUNCTION generate_string() RETURNS TEXT AS
  'SELECT SUBSTR(MD5(RANDOM()::TEXT), 0, 33)'
LANGUAGE SQL;

CREATE FUNCTION generate_boolean() RETURNS BOOLEAN AS
  'SELECT RANDOM()::INT::BOOLEAN'
LANGUAGE SQL;
