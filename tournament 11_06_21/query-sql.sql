**Tournament Facts**

SELECT *
FROM bjj_tournament.tournament_facts;

| tournament_date          | weight_class  | weight_lbs |
| ------------------------ | ------------- | ---------- |
| 2021-11-06T00:00:00.000Z | cruiserweight | 182        |

SELECT *
FROM bjj_tournament.match_style;

| match_style |
| ----------- |
| gi          |
| nogi        |

---------------------------------------------------

**Offensive & Defensive points per match**

SELECT 
  points_scored / 5 AS points_scored_per_match, 
  points_given_up / 5 AS points_lost_per_match 
FROM 
  bjj_tournament.match_results 
WHERE 
  points_scored IS NOT NULL;

-- Scored an avg of 7 points per match
-- Gave up an avg of just 2 points per match 

| points_scored_per_match | points_lost_per_match |
| ----------------------- | --------------------- |
| 7                       | 2                     |

-- Nick Newby interview from NuView Analytics asked if I could write this query a different way. We came up with CTE and came to same result

WITH match_points AS (
 	SELECT COUNT (DISTINCT match_id) AS total_day_matches, 
    SUM(points_scored) AS points_scored, 
    SUM( points_given_up) AS points_given_up
 	FROM bjj_tournament.match_results 
    )
    SELECT
     points_scored / total_day_matches AS points_scored, 
    points_given_up / total_day_matches AS points_given_up
    FROM match_points
    
| points_scored | points_given_up |
| ----------------------- | --------------------- |
| 7                       | 2                     |

---------------------------------------------------
**Win/Loss result**

SELECT 
  results 
FROM 
  bjj_tournament.match_results;
-- Total of 5 matches, lost 1.--

| results |
| ------- |
| W       |
| W       |
| W       |
| W       |
| L       |
|         |

---------------------------------------------------

**Moves**

SELECT * 
FROM bjj_tournament.moves;

| move_id | move_name     | category_id | category_name  |
| ------- | ------------- | ----------- | -------------- |
| 1       | guard pull    | td          | takedown       |
| 2       | single leg    | td          | takedown       |
| 3       | double leg    | td          | takedown       |
| 4       | arm drag      | td          | takedown       |
| 5       | trip          | td          | takedown       |
| 6       | lateral throw | td          | takedown       |
| 7       | guard         | pos         | position       |
| 8       | half guard    | pos         | position       |
| 9       | side control  | pos         | position       |
| 10      | mount         | pos         | position       |
| 11      | back          | pos         | position       |
| 12      | sweep         | trn         | transition     |
| 13      | guard pass    | trn         | transition     |
| 14      | arm bar       | sa          | submission arm |
| 15      | americana     | sa          | submission arm |
| 16      | kimura        | sa          | submission arm |
| 17      | rear naked    | c           | choke          |
| 18      | front collar  | c           | choke          |
| 19      | triangle      | c           | choke          |
| 20      | arm_triangle  | c           | choke          |
| 21      | guillotine    | c           | choke          |

--------------------------------------------------

**Match_Points**

SELECT * 
FROM bjj_tournament.match_points;

| move_name     | move_id | offense_attempted | offense_succeeded | defense_attempted | defense_succeeded | match_id |
| ------------- | ------- | ----------------- | ----------------- | ----------------- | ----------------- | -------- |
| arm drag      | 4       | 3                 | 0                 | 0                 | 3                 | M1       |
| trip          | 5       | 0                 | 0                 | 0                 | 5                 | M1       |
| lateral throw | 6       | 1                 | 0                 | 0                 | 0                 | M1       |
| guard         | 7       | 1                 | 0                 | 0                 | 0                 | M1       |
| single leg    | 2       | 0                 | 0                 | 0                 | 1                 | M1       |
| trip          | 5       | 0                 | 0                 | 0                 | 2                 | M2       |
| lateral throw | 6       | 0                 | 1                 | 0                 | 0                 | M2       |
| guard         | 7       | 0                 | 1                 | 0                 | 0                 | M2       |
| side control  | 9       | 0                 | 3                 | 0                 | 0                 | M2       |
| mount         | 10      | 0                 | 2                 | 0                 | 0                 | M2       |
| sweep         | 12      | 0                 | 0                 | 1                 | 1                 | M2       |
| guard pass    | 13      | 3                 | 2                 | 0                 | 0                 | M2       |
| arm bar       | 14      | 1                 | 0                 | 0                 | 1                 | M2       |
| triangle      | 19      | 0                 | 0                 | 0                 | 1                 | M2       |
| double leg    | 3       | 0                 | 0                 | 0                 | 1                 | M3       |
| lateral throw | 6       | 0                 | 1                 | 0                 | 0                 | M3       |
| guard         | 7       | 0                 | 1                 | 0                 | 2                 | M3       |
| half guard    | 8       | 0                 | 1                 | 0                 | 0                 | M3       |
| side control  | 9       | 0                 | 0                 | 1                 | 0                 | M3       |
| mount         | 10      | 0                 | 2                 | 0                 | 2                 | M3       |
| back          | 11      | 0                 | 1                 | 0                 | 0                 | M3       |
| sweep         | 12      | 0                 | 0                 | 2                 | 1                 | M3       |
| guard pass    | 13      | 1                 | 1                 | 0                 | 0                 | M3       |
| rear naked    | 17      | 1                 | 0                 | 0                 | 0                 | M3       |
| triangle      | 19      | 2                 | 0                 | 0                 | 0                 | M3       |
| guard pull    | 1       | 0                 | 0                 | 1                 | 0                 | M4       |
| single leg    | 2       | 0                 | 0                 | 0                 | 0                 | M4       |
| double leg    | 3       | 1                 | 0                 | 0                 | 0                 | M4       |
| trip          | 5       | 1                 | 0                 | 0                 | 0                 | M4       |
| guard         | 7       | 0                 | 0                 | 1                 | 0                 | M4       |
| half guard    | 8       | 0                 | 2                 | 1                 | 0                 | M4       |
| back          | 11      | 0                 | 0                 | 0                 | 2                 | M4       |
| sweep         | 12      | 0                 | 0                 | 1                 | 1                 | M4       |
| guard pass    | 13      | 3                 | 0                 | 0                 | 0                 | M4       |
| arm bar       | 14      | 0                 | 0                 | 1                 | 0                 | M4       |
| kimura        | 16      | 0                 | 0                 | 1                 | 1                 | M4       |
| single leg    | 2       | 0                 | 0                 | 0                 | 3                 | M5       |
| double leg    | 3       | 0                 | 0                 | 0                 | 3                 | M5       |
| lateral throw | 6       | 0                 | 5                 | 0                 | 0                 | M5       |
| guard         | 7       | 0                 | 4                 | 0                 | 0                 | M5       |
| half guard    | 8       | 0                 | 2                 | 0                 | 0                 | M5       |
| side control  | 9       | 0                 | 2                 | 0                 | 0                 | M5       |
| sweep         | 12      | 0                 | 2                 | 0                 | 2                 | M5       |
| guard pass    | 13      | 5                 | 0                 | 0                 | 0                 | M5       |
| triangle      | 19      | 0                 | 0                 | 0                 | 1                 | M5       |

--------------------------------------------------

**Points Scoring System**

    SELECT *
    FROM bjj_tournament.points_scoring_system;

| move_score | move_name     | category_name |
| ---------- | ------------- | ------------- |
| 2          | guard pull    | takedown      |
| 2          | single leg    | takedown      |
| 2          | double leg    | takedown      |
| 2          | arm drag      | takedown      |
| 2          | trip          | takedown      |
| 2          | lateral throw | takedown      |
| 4          | mount         | position      |
| 4          | back          | position      |
| 3          | sweep         | transition    |
| 3          | guard pass    | transition    |

--------------------------------------------------

**Offense Attempts**
SELECT 
  move_name, 
  SUM(offense_attempted) AS offensive_attempts 
FROM 
  bjj_tournament.match_points 
WHERE 
  offense_attempted > 0 
GROUP BY 
  move_name;

| move_name     | offensive_attempts |
| ------------- | ------------------ |
| triangle      | 2                  |
| arm bar       | 1                  |
| arm drag      | 3                  |
| guard pass    | 12                 |
| guard         | 1                  |
| double leg    | 1                  |
| rear naked    | 1                  |
| trip          | 1                  |
| lateral throw | 1                  |
---------------------------------------------------

**Offense Success**
SELECT 
  move_name, 
  SUM(offense_succeeded) AS offensive_successes 
FROM 
  bjj_tournament.match_points 
WHERE 
  offense_succeeded > 0 
GROUP BY 
  move_name;

| move_name     | offensive_successes |
| ------------- | ------------------- |
| mount         | 4                   |
| half guard    | 5                   |
| guard pass    | 3                   |
| side control  | 5                   |
| guard         | 6                   |
| back          | 1                   |
| sweep         | 2                   |
| lateral throw | 7                   |

---------------------------------------------------

**Offense points scored per move and match**

    SELECT match_points.move_name, 
    pss.category_name, 
    pss.move_score, 
    SUM(offense_succeeded) AS offensive_successes, 
    SUM(offense_succeeded) * move_score AS points_scored, 
    match_points.match_id 
    FROM 
      bjj_tournament.match_points 
      INNER JOIN bjj_tournament.points_scoring_system AS pss 
      ON match_points.move_name = pss.move_name 
    WHERE 
      offense_succeeded > 0 
    GROUP BY 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      match_points.match_id 
    ORDER BY 
      match_points.match_id;

| move_name     | category_name | move_score | offensive_successes | points_scored | match_id |
| ------------- | ------------- | ---------- | ------------------- | ------------- | -------- |
| guard pass    | transition    | 3          | 2                   | 6             | M2       |
| lateral throw | takedown      | 2          | 1                   | 2             | M2       |
| mount         | position      | 4          | 2                   | 8             | M2       |
| back          | position      | 4          | 1                   | 4             | M3       |
| guard pass    | transition    | 3          | 1                   | 3             | M3       |
| lateral throw | takedown      | 2          | 1                   | 2             | M3       |
| mount         | position      | 4          | 2                   | 8             | M3       |
| lateral throw | takedown      | 2          | 5                   | 10            | M5       |
| sweep         | transition    | 3          | 2                   | 6             | M5       |

---------------------------------------------------

**Deffense points prevented per move and match***

    SELECT 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      SUM(defense_succeeded) AS defense_successes, 
      SUM(defense_succeeded) * move_score AS points_defended, 
      match_points.match_id 
    FROM 
      bjj_tournament.match_points 
      INNER JOIN bjj_tournament.points_scoring_system AS pss 
      ON match_points.move_name = pss.move_name 
    WHERE 
      defense_succeeded > 0 
    GROUP BY 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      match_points.match_id 
    ORDER BY 
      match_points.match_id;

| move_name  | category_name | move_score | defense_successes | points_defended | match_id |
| ---------- | ------------- | ---------- | ----------------- | --------------- | -------- |
| arm drag   | takedown      | 2          | 3                 | 6               | M1       |
| single leg | takedown      | 2          | 1                 | 2               | M1       |
| trip       | takedown      | 2          | 5                 | 10              | M1       |
| sweep      | transition    | 3          | 1                 | 3               | M2       |
| trip       | takedown      | 2          | 2                 | 4               | M2       |
| double leg | takedown      | 2          | 1                 | 2               | M3       |
| mount      | position      | 4          | 2                 | 8               | M3       |
| sweep      | transition    | 3          | 1                 | 3               | M3       |
| back       | position      | 4          | 2                 | 8               | M4       |
| sweep      | transition    | 3          | 1                 | 3               | M4       |
| double leg | takedown      | 2          | 3                 | 6               | M5       |
| single leg | takedown      | 2          | 3                 | 6               | M5       |
| sweep      | transition    | 3          | 2                 | 6               | M5       |

---------------------------------------------------

**Offense points attempted per move and match***

    SELECT 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      SUM(offense_attempted) AS offensive_attempts, 
      SUM(offense_attempted) * move_score AS points_attempt, 
      match_points.match_id 
    FROM 
      bjj_tournament.match_points 
      INNER JOIN bjj_tournament.points_scoring_system AS pss 
      ON match_points.move_name = pss.move_name 
    WHERE 
      offense_attempted > 0 
    GROUP BY 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      match_points.match_id 
    ORDER BY 
      match_points.match_id;

| move_name     | category_name | move_score | offensive_attempts | points_attempt | match_id |
| ------------- | ------------- | ---------- | ------------------ | -------------- | -------- |
| arm drag      | takedown      | 2          | 3                  | 6              | M1       |
| lateral throw | takedown      | 2          | 1                  | 2              | M1       |
| guard pass    | transition    | 3          | 3                  | 9              | M2       |
| guard pass    | transition    | 3          | 1                  | 3              | M3       |
| double leg    | takedown      | 2          | 1                  | 2              | M4       |
| guard pass    | transition    | 3          | 3                  | 9              | M4       |
| trip          | takedown      | 2          | 1                  | 2              | M4       |
| guard pass    | transition    | 3          | 5                  | 15             | M5       |

---------------------------------------------------

**Defensive points lost per move and match**

    SELECT 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      SUM(defense_attempted) AS defense_attempts, 
      SUM(defense_attempted) * move_score AS points_lost, 
      match_points.match_id 
    FROM 
      bjj_tournament.match_points 
      INNER JOIN bjj_tournament.points_scoring_system AS pss 
      ON match_points.move_name = pss.move_name 
    WHERE 
      defense_attempted > 0 
    GROUP BY 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      match_points.match_id 
    ORDER BY 
      match_points.match_id;

| move_name  | category_name | move_score | defense_attempts | points_lost | match_id |
| ---------- | ------------- | ---------- | ---------------- | ----------- | -------- |
| sweep      | transition    | 3          | 1                | 3           | M2       |
| sweep      | transition    | 3          | 2                | 6           | M3       |
| guard pull | takedown      | 2          | 1                | 2           | M4       |
| sweep      | transition    | 3          | 1                | 3           | M4       |

/* The previous 4 queries I wanted to display 2 things use a aggregation function and join. 
First, I needed to create another table in my schema which I created and named points_scoring_system and then joined on move_name.
INNER JOINe was used because there are matching values in both tables. */

---------------------------------------------------

**Top offensive scoring move per match**

    SELECT 
    	move_name,
        match_id,
        SUM(offense_succeeded) AS top_scoring_move_per_match
    FROM 
    	bjj_tournament.match_points
    GROUP BY
    	match_id,
      move_name
    HAVING SUM(offense_succeeded) > 2;

| move_name     | match_id | top_scoring_move_per_match |
| ------------- | -------- | -------------------------- |
| lateral throw | M5       | 5                          |
| guard         | M5       | 4                          |
| side control  | M2       | 3                          |

---
**Top offensive attempted move per match**

    SELECT 
    	move_name,
        match_id,
        SUM(offense_attempted) AS offensive_attempts_per_match
    FROM 
    	bjj_tournament.match_points
    GROUP BY
    	match_id,
      move_name
    HAVING SUM(offense_attempted) > 2;

| move_name  | match_id | offensive_attempts_per_match |
| ---------- | -------- | ---------------------------- |
| guard pass | M2       | 3                            |
| guard pass | M4       | 3                            |
| guard pass | M5       | 5                            |
| arm drag   | M1       | 3                            |

---------------------------------------------------

**Top successfully defended moves per match**

    SELECT 
    	move_name,
        match_id,
        SUM(defense_succeeded) AS top_defensive_moves_per_match
    FROM 
    	bjj_tournament.match_points
    GROUP BY
    	match_id,
      move_name
    HAVING SUM(defense_succeeded) > 2;

| move_name  | match_id | top_defensive_moves_per_match |
| ---------- | -------- | ----------------------------- |
| double leg | M5       | 3                             |
| single leg | M5       | 3                             |
| trip       | M1       | 5                             |
| arm drag   | M1       | 3                             |

/* I wanted to show skills using the having function which specifies a search condition for a group or an aggregate returned by the GROUP BY clause. */

---------------------------------------------------

**Summary Stats Offensive Successes**

    SELECT
      ROUND(MIN(offense_succeeded), 2) AS minimum_value,
      ROUND(MAX(offense_succeeded), 2) AS maximum_value,
      ROUND(AVG(offense_succeeded), 2) AS mean_value,
      ROUND(
          CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY offense_succeeded) AS NUMERIC),
        2
      ) AS median_value,
      ROUND(
        MODE() WITHIN GROUP (ORDER BY offense_succeeded),
        2
      ) AS mode_value,
      ROUND(STDDEV(offense_succeeded), 2) AS standard_deviation,
      ROUND(VARIANCE(offense_succeeded), 2) AS variance_value
      
      FROM bjj_tournament.match_points;

| minimum_value | maximum_value | mean_value | median_value | mode_value | standard_deviation | variance_value |
| ------------- | ------------- | ---------- | ------------ | ---------- | ------------------ | -------------- |
| 0.00          | 5.00          | 0.73       | 0.00         | 0.00       | 1.18               | 1.38           |

---------------------------------------------------

**Summary Stats Defensive Successes***

    SELECT
      ROUND(MIN(defense_succeeded), 2) AS minimum_value,
      ROUND(MAX(defense_succeeded), 2) AS maximum_value,
      ROUND(AVG(defense_succeeded), 2) AS mean_value,
      ROUND(
          CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY defense_succeeded) AS NUMERIC),
        2
      ) AS median_value,
      ROUND(
        MODE() WITHIN GROUP (ORDER BY defense_succeeded),
        2
      ) AS mode_value,
      ROUND(STDDEV(defense_succeeded), 2) AS standard_deviation,
      ROUND(VARIANCE(defense_succeeded), 2) AS variance_value
      
      FROM bjj_tournament.match_points;

| minimum_value | maximum_value | mean_value | median_value | mode_value | standard_deviation | variance_value |
| ------------- | ------------- | ---------- | ------------ | ---------- | ------------------ | -------------- |
| 0.00          | 5.00          | 0.73       | 0.00         | 0.00       | 1.14               | 1.29           |

/* The above 2 queries show summary statistics for both offensive & defensive successes. */

---------------------------------------------------

**CTE Example Query**
WITH deduped_moves AS (
  SELECT DISTINCT *
  FROM bjj_tournament.moves
 )
 SELECT COUNT(*)
 FROM deduped_moves;
   
| count |
| ----- |
| 21    |

**Subquery Example**
SELECT COUNT(*)
FROM (
  SELECT DISTINCT *
  FROM bjj_tournament.moves
  ) AS subquery
  ;
  
| count |
| ----- |
| 21    |
