CREATE SCHEMA bjj_tournament;
SET search_path = bjj_tournament;

CREATE TABLE identifiers (
  "match_id" INTEGER,
  "move_id" INTEGER,
  "tournament_date" DATE,
  "opponent_name" VARCHAR(50),
  "weight_class" VARCHAR(50),
  "match_style" VARCHAR(50)
 );
 
 INSERT INTO identifiers
 	("match_id", "move_id",  "tournament_date", "weight_class",  "match_style")
 VALUES
 ('1', '1', '2021-11-06', 'cruiserweight', 'gi'), 
