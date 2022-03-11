Table "tournament_facts" {
  "tournament_date" DATE
  "weight_class" VARCHAR(50)
  "weight_lbs" INTEGER
}

Table "match_style" {
  "match_style" VARCHAR(10)
}

Table "moves" {
  "move_id" VARCHAR(2)
  "move_name" VARCHAR(50)
  "category_id" VARCHAR(3)
  "category_name" VARCHAR(50)
}

Table "match_results" {
  "points_scored" INTEGER
  "points_given_up" INTEGER
  "results" VARCHAR(2)
  "match_id" VARCHAR(2)
  "move_id" VARCHAR(2)
}

Table "match_points" {
  "move_name" VARCHAR(50)
  "move_id" VARCHAR(2)
  "offense_attempted" INTEGER
  "offense_succeeded" INTEGER
  "defense_attempted" INTEGER
  "defense_succeeded" INTEGER
  "match_id" VARCHAR(2)
}

TABLE "points_scoring_system" {
  "move_score" INTEGER
  "move_name" VARCHAR(50)
  "category_name" VARCHAR(50)
   }

Ref: "match_points"."match_id" < "match_results"."match_id"

Ref: "moves"."move_id" < "match_points"."move_id"

Ref: "points_scoring_system"."move_name" < "match_points"."move_name"

Ref: "points_scoring_system"."category_name" < "moves"."category_name"
