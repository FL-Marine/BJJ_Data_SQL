CREATE TABLE "tournament_facts" (
  "tournament_date" DATE,
  "weight_class" VARCHAR(50),
  "weight_lbs" INTEGER
);

CREATE TABLE "match_style" (
  "match_style" VARCHAR(10)
);

CREATE TABLE "moves" (
  "move_id" VARCHAR(2),
  "move_name" VARCHAR(50),
  "category_id" VARCHAR(3),
  "category_name" VARCHAR(50)
);

CREATE TABLE "match_results" (
  "points_scored" INTEGER,
  "points_given_up" INTEGER,
  "results" VARCHAR(2),
  "match_id" VARCHAR(2),
  "move_id" VARCHAR(2)
);

CREATE TABLE "match_points" (
  "move_name" VARCHAR(50),
  "move_id" VARCHAR(2),
  "offense_attempted" INTEGER,
  "offense_succeeded" INTEGER,
  "defense_attempted" INTEGER,
  "defense_succeeded" INTEGER,
  "match_id" VARCHAR(2)
);

ALTER TABLE "match_results" ADD FOREIGN KEY ("match_id") REFERENCES "match_points" ("match_id");

ALTER TABLE "match_points" ADD FOREIGN KEY ("move_id") REFERENCES "moves" ("move_id");
