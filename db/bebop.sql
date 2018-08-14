DROP TABLE IF EXISTS bounties;
CREATE TABLE bounties (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  bounty INT8,
  danger VARCHAR(255),
  fav_weapon VARCHAR(255)
);
