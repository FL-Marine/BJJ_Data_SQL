
-- ** Tournament Facts **

SELECT 
	*
FROM bjj_tournament.tournament_facts;

tournament_date|weight_class |weight_lbs|
---------------+-------------+----------+
     2021-11-06|cruiserweight|       182|

SELECT 
	*
FROM bjj_tournament.match_style;

match_style|
-----------+
gi         |
nogi       |

/*
---------------------------------------------------

**Offensive & Defensive points per match**

---------------------------------------------------
*/

SELECT 
  points_scored / 5 AS points_scored_per_match, 
  points_given_up / 5 AS points_lost_per_match 
FROM 
  bjj_tournament.match_results 
WHERE 
  points_scored IS NOT NULL;

-- Scored an avg of 7 points per match
-- Gave up an avg of just 2 points per match 

points_scored_per_match|points_lost_per_match|
-----------------------+---------------------+
                      7|                    2|

-- Nick Newby tech interview from NuView Analytics on 6/23/2022 asked if I could write this query a different way. We came up with CTE and came to same result

WITH match_points AS (
 	SELECT 
 		COUNT (DISTINCT match_id) AS total_day_matches, 
    	SUM(points_scored) AS points_scored_per_match, 
    	SUM(points_given_up) AS points_lost_per_match
 	FROM bjj_tournament.match_results 
)
SELECT
	points_scored_per_match / total_day_matches AS avg_scored_per_match, 
    points_lost_per_match / total_day_matches AS avg_lost_per_match
FROM match_points;
    
avg_scored_per_match|avg_lost_per_match|
--------------------+------------------+
                   7|                 2|
                   
/*
---------------------------------------------------

**Win/Loss result**

---------------------------------------------------
*/

WITH get_match_results AS (                   
	SELECT
		SUM(
	  		CASE 
	  			WHEN results = 'W' THEN 1
	  			ELSE 0
	  		END) AS total_wins,
	  	SUM(
	  		CASE 
	  			WHEN results = 'L' THEN 1
	  			ELSE 0
	  		END) AS total_losses
	FROM 
	  bjj_tournament.match_results
)
SELECT
	total_wins + total_losses AS total_matches,
	total_wins,
	total_losses,
	100 * total_wins / (total_wins + total_losses)::float AS winning_percentage,
	100 * total_losses / (total_wins + total_losses)::float AS losses_percentage
FROM
	get_match_results;
 
-- Total of 5 matches, lost 1.

total_matches|total_wins|total_losses|winning_percentage|losses_percentage|
-------------+----------+------------+------------------+-----------------+
            5|         4|           1|              80.0|             20.0|

/*
---------------------------------------------------

**Moves**

---------------------------------------------------
*/

SELECT * 
FROM bjj_tournament.moves;

move_id|move_name    |category_id|category_name |
-------+-------------+-----------+--------------+
1      |guard pull   |td         |takedown      |
2      |single leg   |td         |takedown      |
3      |double leg   |td         |takedown      |
4      |arm drag     |td         |takedown      |
5      |trip         |td         |takedown      |
6      |lateral throw|td         |takedown      |
7      |guard        |pos        |position      |
8      |half guard   |pos        |position      |
9      |side control |pos        |position      |
10     |mount        |pos        |position      |
11     |back         |pos        |position      |
12     |sweep        |trn        |transition    |
13     |guard pass   |trn        |transition    |
14     |arm bar      |sa         |submission arm|
15     |americana    |sa         |submission arm|
16     |kimura       |sa         |submission arm|
17     |rear naked   |c          |choke         |
18     |front collar |c          |choke         |
19     |triangle     |c          |choke         |
20     |arm_triangle |c          |choke         |
21     |guillotine   |c          |choke         |

/*
---------------------------------------------------

**Match_Points**

---------------------------------------------------
*/

WITH moves_breakdown AS (
	SELECT 
		match_id,
		move_name,
		offense_attempted,
		offense_succeeded,
		defense_attempted,
		defense_succeeded,
		(offense_attempted + offense_succeeded + defense_attempted + defense_succeeded) total_attempts_per_move
	FROM bjj_tournament.match_points
	ORDER BY match_id, move_name
),
get_total_match_moves as (
	SELECT
		*,
		sum(total_attempts_per_move) OVER (PARTITION BY match_id) total_match_moves
	FROM
		moves_breakdown
)
SELECT
	*,
	round(100 * total_attempts_per_move / total_match_moves::NUMERIC, 2) AS total_move_percentage
FROM
	get_total_match_moves
ORDER BY
	match_id ASC, total_move_percentage DESC;


match_id|move_name    |offense_attempted|offense_succeeded|defense_attempted|defense_succeeded|total_attempts_per_move|total_match_moves|total_move_percentage|
--------+-------------+-----------------+-----------------+-----------------+-----------------+-----------------------+-----------------+---------------------+
M1      |arm drag     |                3|                0|                0|                3|                      6|               14|                42.86|
M1      |trip         |                0|                0|                0|                5|                      5|               14|                35.71|
M1      |single leg   |                0|                0|                0|                1|                      1|               14|                 7.14|
M1      |guard        |                1|                0|                0|                0|                      1|               14|                 7.14|
M1      |lateral throw|                1|                0|                0|                0|                      1|               14|                 7.14|
M2      |guard pass   |                3|                2|                0|                0|                      5|               19|                26.32|
M2      |side control |                0|                3|                0|                0|                      3|               19|                15.79|
M2      |arm bar      |                1|                0|                0|                1|                      2|               19|                10.53|
M2      |mount        |                0|                2|                0|                0|                      2|               19|                10.53|
M2      |sweep        |                0|                0|                1|                1|                      2|               19|                10.53|
M2      |trip         |                0|                0|                0|                2|                      2|               19|                10.53|
M2      |lateral throw|                0|                1|                0|                0|                      1|               19|                 5.26|
M2      |triangle     |                0|                0|                0|                1|                      1|               19|                 5.26|
M2      |guard        |                0|                1|                0|                0|                      1|               19|                 5.26|
M3      |mount        |                0|                2|                0|                2|                      4|               20|                20.00|
M3      |sweep        |                0|                0|                2|                1|                      3|               20|                15.00|
M3      |guard        |                0|                1|                0|                2|                      3|               20|                15.00|
M3      |guard pass   |                1|                1|                0|                0|                      2|               20|                10.00|
M3      |triangle     |                2|                0|                0|                0|                      2|               20|                10.00|
M3      |half guard   |                0|                1|                0|                0|                      1|               20|                 5.00|
M3      |back         |                0|                1|                0|                0|                      1|               20|                 5.00|
M3      |double leg   |                0|                0|                0|                1|                      1|               20|                 5.00|
M3      |lateral throw|                0|                1|                0|                0|                      1|               20|                 5.00|
M3      |rear naked   |                1|                0|                0|                0|                      1|               20|                 5.00|
M3      |side control |                0|                0|                1|                0|                      1|               20|                 5.00|
M4      |half guard   |                0|                2|                1|                0|                      3|               17|                17.65|
M4      |guard pass   |                3|                0|                0|                0|                      3|               17|                17.65|
M4      |back         |                0|                0|                0|                2|                      2|               17|                11.76|
M4      |kimura       |                0|                0|                1|                1|                      2|               17|                11.76|
M4      |sweep        |                0|                0|                1|                1|                      2|               17|                11.76|
M4      |trip         |                1|                0|                0|                0|                      1|               17|                 5.88|
M4      |double leg   |                1|                0|                0|                0|                      1|               17|                 5.88|
M4      |guard        |                0|                0|                1|                0|                      1|               17|                 5.88|
M4      |guard pull   |                0|                0|                1|                0|                      1|               17|                 5.88|
M4      |arm bar      |                0|                0|                1|                0|                      1|               17|                 5.88|
M4      |single leg   |                0|                0|                0|                0|                      0|               17|                 0.00|
M5      |lateral throw|                0|                5|                0|                0|                      5|               29|                17.24|
M5      |guard pass   |                5|                0|                0|                0|                      5|               29|                17.24|
M5      |guard        |                0|                4|                0|                0|                      4|               29|                13.79|
M5      |sweep        |                0|                2|                0|                2|                      4|               29|                13.79|
M5      |double leg   |                0|                0|                0|                3|                      3|               29|                10.34|
M5      |single leg   |                0|                0|                0|                3|                      3|               29|                10.34|
M5      |half guard   |                0|                2|                0|                0|                      2|               29|                 6.90|
M5      |side control |                0|                2|                0|                0|                      2|               29|                 6.90|
M5      |triangle     |                0|                0|                0|                1|                      1|               29|                 3.45|

/*
---------------------------------------------------

**Points Scoring System**

---------------------------------------------------
*/

SELECT *
FROM bjj_tournament.points_scoring_system
ORDER BY move_score;

move_score|move_name    |category_name|
----------+-------------+-------------+
         2|guard pull   |takedown     |
         2|single leg   |takedown     |
         2|double leg   |takedown     |
         2|arm drag     |takedown     |
         2|trip         |takedown     |
         2|lateral throw|takedown     |
         3|sweep        |transition   |
         3|guard pass   |transition   |
         4|mount        |position     |
         4|back         |position     |

/*
---------------------------------------------------

**Offense Attempts**

---------------------------------------------------
*/

SELECT 
	move_name, 
	SUM(offense_attempted) AS offensive_attempts 
FROM 
	bjj_tournament.match_points 
WHERE 
	offense_attempted > 0 
GROUP BY 
	move_name
ORDER BY 
	offensive_attempts desc;

move_name    |offensive_attempts|
-------------+------------------+
guard pass   |                12|
arm drag     |                 3|
triangle     |                 2|
rear naked   |                 1|
trip         |                 1|
arm bar      |                 1|
double leg   |                 1|
lateral throw|                 1|
guard        |                 1|

/*
---------------------------------------------------

**Offense Success**

---------------------------------------------------
*/

SELECT 
	move_name, 
  	SUM(offense_succeeded) AS offensive_successes 
FROM 
  	bjj_tournament.match_points 
WHERE 
  	offense_succeeded > 0 
GROUP BY 
  	move_name
ORDER BY 
	offensive_successes desc;

move_name    |offensive_successes|
-------------+-------------------+
lateral throw|                  7|
guard        |                  6|
side control |                  5|
half guard   |                  5|
mount        |                  4|
guard pass   |                  3|
sweep        |                  2|
back         |                  1|

/*
---------------------------------------------------

**Offense points scored per move and match**

---------------------------------------------------
*/

DROP TABLE IF EXISTS offensive_points_per_match;
CREATE TEMP TABLE offensive_points_per_match AS (
	SELECT 
		match_points.match_id,
		match_points.move_name, 
	    pss.category_name, 
	    pss.move_score, 
	    SUM(offense_succeeded) AS offensive_successes, 
	    SUM(offense_succeeded) * move_score AS points_scored
	FROM 
	    bjj_tournament.match_points 
	INNER JOIN 
		bjj_tournament.points_scoring_system AS pss 
	ON 
		match_points.move_name = pss.move_name 
	WHERE 
	    offense_succeeded > 0 
	GROUP BY 
		match_points.move_name, 
	    pss.category_name, 
	    pss.move_score, 
	    match_points.match_id 
	ORDER BY 
		match_points.match_id
);

SELECT
	DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_scored desc) AS rnk,
	*
FROM
	offensive_points_per_match;

rnk|match_id|move_name    |category_name|move_score|offensive_successes|points_scored|
---+--------+-------------+-------------+----------+-------------------+-------------+
  1|M2      |mount        |position     |         4|                  2|            8|
  2|M2      |guard pass   |transition   |         3|                  2|            6|
  3|M2      |lateral throw|takedown     |         2|                  1|            2|
  1|M3      |mount        |position     |         4|                  2|            8|
  2|M3      |back         |position     |         4|                  1|            4|
  3|M3      |guard pass   |transition   |         3|                  1|            3|
  4|M3      |lateral throw|takedown     |         2|                  1|            2|
  1|M5      |lateral throw|takedown     |         2|                  5|           10|
  2|M5      |sweep        |transition   |         3|                  2|            6|

/*
---------------------------------------------------

**Best Offensive Scoring Move per Match**

---------------------------------------------------
*/

WITH get_offensive_ranking AS (
	SELECT
		*,
		DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_scored desc) AS rnk
	FROM
		offensive_points_per_match
)
SELECT
	match_id,
	move_name,
	category_name,
	move_score,
	offensive_successes,
	points_scored
FROM 
	get_offensive_ranking
WHERE
	rnk = 1;

match_id|move_name    |category_name|move_score|offensive_successes|points_scored|
--------+-------------+-------------+----------+-------------------+-------------+
M2      |mount        |position     |         4|                  2|            8|
M3      |mount        |position     |         4|                  2|            8|
M5      |lateral throw|takedown     |         2|                  5|           10|

/*
---------------------------------------------------

**Defense points prevented per move and match***

---------------------------------------------------
*/

DROP TABLE IF EXISTS defensive_points_per_match;
CREATE TEMP TABLE defensive_points_per_match AS (
	SELECT 
		match_points.match_id,
    	match_points.move_name, 
      	pss.category_name, 
      	pss.move_score, 
      	SUM(defense_succeeded) AS defense_successes, 
      	SUM(defense_succeeded) * move_score AS points_defended 
    FROM 
      	bjj_tournament.match_points 
    INNER JOIN 
    	bjj_tournament.points_scoring_system AS pss 
    ON match_points.move_name = pss.move_name 
    WHERE 
      defense_succeeded > 0 
    GROUP BY 
      match_points.move_name, 
      pss.category_name, 
      pss.move_score, 
      match_points.match_id 
    ORDER BY 
      match_points.match_id
);

SELECT
	DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_defended desc) AS rnk,
	*
FROM
	defensive_points_per_match;

rnk|match_id|move_name |category_name|move_score|defense_successes|points_defended|
---+--------+----------+-------------+----------+-----------------+---------------+
  1|M1      |trip      |takedown     |         2|                5|             10|
  2|M1      |arm drag  |takedown     |         2|                3|              6|
  3|M1      |single leg|takedown     |         2|                1|              2|
  1|M2      |trip      |takedown     |         2|                2|              4|
  2|M2      |sweep     |transition   |         3|                1|              3|
  1|M3      |mount     |position     |         4|                2|              8|
  2|M3      |sweep     |transition   |         3|                1|              3|
  3|M3      |double leg|takedown     |         2|                1|              2|
  1|M4      |back      |position     |         4|                2|              8|
  2|M4      |sweep     |transition   |         3|                1|              3|
  1|M5      |double leg|takedown     |         2|                3|              6|
  1|M5      |single leg|takedown     |         2|                3|              6|
  1|M5      |sweep     |transition   |         3|                2|              6|
  
/*
---------------------------------------------------

**Best Defensive Scoring Move per Match**

---------------------------------------------------
*/

WITH get_defensive_ranking AS (
	SELECT
		*,
		DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_defended desc) AS rnk
	FROM
		defensive_points_per_match
)
SELECT
	match_id,
	move_name,
	category_name,
	move_score,
	defense_successes,
	points_defended
FROM 
	get_defensive_ranking
WHERE
	rnk = 1;

match_id|move_name |category_name|move_score|defense_successes|points_defended|
--------+----------+-------------+----------+-----------------+---------------+
M1      |trip      |takedown     |         2|                5|             10|
M2      |trip      |takedown     |         2|                2|              4|
M3      |mount     |position     |         4|                2|              8|
M4      |back      |position     |         4|                2|              8|
M5      |double leg|takedown     |         2|                3|              6|
M5      |single leg|takedown     |         2|                3|              6|
M5      |sweep     |transition   |         3|                2|              6|

/*
---------------------------------------------------

**Offense points attempted per move and match***

---------------------------------------------------
*/

DROP TABLE IF EXISTS offensive_attempted_points_per_match;
CREATE TEMP TABLE offensive_attempted_points_per_match AS (
	SELECT 
		match_points.match_id,
    	match_points.move_name, 
      	pss.category_name, 
      	pss.move_score, 
      	SUM(offense_attempted) AS offensive_attempts, 
      	SUM(offense_attempted) * move_score AS points_attempt 
    FROM 
      	bjj_tournament.match_points 
    INNER JOIN 
    	bjj_tournament.points_scoring_system AS pss 
    ON 
    	match_points.move_name = pss.move_name 
    WHERE 
      	offense_attempted > 0 
    GROUP BY 
      	match_points.move_name, 
      	pss.category_name, 
      	pss.move_score, 
      	match_points.match_id 
    ORDER BY 
      	match_points.match_id
);

SELECT
	DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_attempt desc) AS rnk,
	*
FROM
	offensive_attempted_points_per_match;

rnk|match_id|move_name    |category_name|move_score|offensive_attempts|points_attempt|
---+--------+-------------+-------------+----------+------------------+--------------+
  1|M1      |arm drag     |takedown     |         2|                 3|             6|
  2|M1      |lateral throw|takedown     |         2|                 1|             2|
  1|M2      |guard pass   |transition   |         3|                 3|             9|
  1|M3      |guard pass   |transition   |         3|                 1|             3|
  1|M4      |guard pass   |transition   |         3|                 3|             9|
  2|M4      |double leg   |takedown     |         2|                 1|             2|
  2|M4      |trip         |takedown     |         2|                 1|             2|
  1|M5      |guard pass   |transition   |         3|                 5|            15|
  
/*
---------------------------------------------------

**Best Offensive Scoring Attempt per Match**

---------------------------------------------------
*/

WITH get_offensive_attempt_ranking AS (
	SELECT
		*,
		DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_attempt desc) AS rnk
	FROM
		offensive_attempted_points_per_match
)
SELECT
	match_id,
	move_name,
	category_name,
	move_score,
	offensive_attempts,
	points_attempt
FROM 
	get_offensive_attempt_ranking
WHERE
	rnk = 1;

match_id|move_name |category_name|move_score|offensive_attempts|points_attempt|
--------+----------+-------------+----------+------------------+--------------+
M1      |arm drag  |takedown     |         2|                 3|             6|
M2      |guard pass|transition   |         3|                 3|             9|
M3      |guard pass|transition   |         3|                 1|             3|
M4      |guard pass|transition   |         3|                 3|             9|
M5      |guard pass|transition   |         3|                 5|            15|

/*
---------------------------------------------------

**Defensive points lost per move and match**

---------------------------------------------------
*/

DROP TABLE IF EXISTS defensive_points_lost_per_match;
CREATE TEMP TABLE defensive_points_lost_per_match AS (
    SELECT 
    	match_points.match_id,
      	match_points.move_name, 
      	pss.category_name, 
      	pss.move_score, 
      	SUM(defense_attempted) AS defense_attempts, 
      	SUM(defense_attempted) * move_score AS points_lost 
    FROM 
      	bjj_tournament.match_points 
    INNER JOIN 
    	bjj_tournament.points_scoring_system AS pss 
    ON 
    	match_points.move_name = pss.move_name 
    WHERE 
      	defense_attempted > 0 
    GROUP BY 
      	match_points.move_name, 
      	pss.category_name, 
      	pss.move_score, 
      	match_points.match_id 
    ORDER BY 
      	match_points.match_id
);

SELECT
	DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_lost desc) AS rnk,
	*
FROM
	defensive_points_lost_per_match;

rnk|match_id|move_name |category_name|move_score|defense_attempts|points_lost|
---+--------+----------+-------------+----------+----------------+-----------+
  1|M2      |sweep     |transition   |         3|               1|          3|
  1|M3      |sweep     |transition   |         3|               2|          6|
  1|M4      |sweep     |transition   |         3|               1|          3|
  2|M4      |guard pull|takedown     |         2|               1|          2|
  
/*
---------------------------------------------------

**Worst Defensive Points Lost per Match**

---------------------------------------------------
*/

WITH get_defensive_point_loss_ranking AS (
	SELECT
		*,
		DENSE_RANK() OVER (PARTITION BY match_id ORDER BY points_lost desc) AS rnk
	FROM
		defensive_points_lost_per_match
)
SELECT
	match_id,
	move_name,
	category_name,
	move_score,
	defense_attempts,
	points_lost
FROM 
	get_defensive_point_loss_ranking
WHERE
	rnk = 1;

match_id|move_name|category_name|move_score|defense_attempts|points_lost|
--------+---------+-------------+----------+----------------+-----------+
M2      |sweep    |transition   |         3|               1|          3|
M3      |sweep    |transition   |         3|               2|          6|
M4      |sweep    |transition   |         3|               1|          3|

/* 
	The previous 4 queries I wanted to display 2 things, use an aggregation function and a join. 
	First, I needed to create another table in my schema which I created and named points_scoring_system and then joined on move_name.
	INNER JOIN was used because there are matching values in both tables. 

*/

/*
---------------------------------------------------

**Top offensive scoring move per match**

---------------------------------------------------
*/

/*
 * This query returns 2 values for one match when it should only be the top value.
 * 
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

move_name    |match_id|top_scoring_move_per_match|
-------------+--------+--------------------------+
lateral throw|M5      |                         5|
guard        |M5      |                         4|
side control |M2      |                         3|

*/

DROP TABLE IF EXISTS get_top_rankings;
CREATE TEMP TABLE get_top_rankings AS (
	SELECT 
		move_name,
	    match_id,
	    SUM(offense_succeeded) AS top_scoring_move_per_match,
	    SUM(offense_attempted) AS top_offensive_attempt_per_match,
	    SUM(defense_succeeded) AS top_defensive_moves_per_match,
	    DENSE_RANK() OVER (PARTITION BY match_id ORDER BY SUM(offense_succeeded) DESC) AS rank_offense_points,
	    DENSE_RANK() OVER (PARTITION BY match_id ORDER BY SUM(offense_attempted) DESC) AS rank_offense_attemptd_points,
	    DENSE_RANK() OVER (PARTITION BY match_id ORDER BY SUM(defense_succeeded) DESC) AS rank_defense_moves
	FROM 
	    bjj_tournament.match_points
	GROUP BY
	    match_id,
	    move_name
);


SELECT
	move_name,
	match_id, 
	top_scoring_move_per_match
FROM
	get_top_rankings
WHERE
	rank_offense_points = 1
AND 
	top_scoring_move_per_match <> 0
ORDER BY 
	top_scoring_move_per_match DESC;

move_name    |match_id|top_scoring_move_per_match|
-------------+--------+--------------------------+
lateral throw|M5      |                         5|
side control |M2      |                         3|
mount        |M3      |                         2|
half guard   |M4      |                         2|

/*
---------------------------------------------------

**Top offensive attempted move per match**

---------------------------------------------------
*/

SELECT
	move_name,
	match_id, 
	top_offensive_attempt_per_match
FROM
	get_top_rankings
WHERE
	rank_offense_attemptd_points = 1
AND 
	top_offensive_attempt_per_match <> 0
ORDER BY 
	top_offensive_attempt_per_match DESC;


move_name |match_id|top_offensive_attempt_per_match|
----------+--------+-------------------------------+
guard pass|M5      |                              5|
arm drag  |M1      |                              3|
guard pass|M2      |                              3|
guard pass|M4      |                              3|
triangle  |M3      |                              2|

/*
---------------------------------------------------

**Top successfully defended moves per match**

---------------------------------------------------
*/

SELECT
	move_name,
	match_id, 
	top_defensive_moves_per_match
FROM
	get_top_rankings
WHERE
	rank_defense_moves = 1
AND 
	top_defensive_moves_per_match <> 0
ORDER BY 
	top_defensive_moves_per_match DESC, match_id;

move_name |match_id|top_defensive_moves_per_match|
----------+--------+-----------------------------+
trip      |M1      |                            5|
double leg|M5      |                            3|
single leg|M5      |                            3|
trip      |M2      |                            2|
guard     |M3      |                            2|
mount     |M3      |                            2|
back      |M4      |                            2|

/*
---------------------------------------------------

**Summary Stats Offensive Successes**

---------------------------------------------------
*/

SELECT 
	offense_succeeded
FROM bjj_tournament.match_points;
	

SELECT
	ROUND(MIN(offense_succeeded), 2) AS minimum_value,
    ROUND(MAX(offense_succeeded), 2) AS maximum_value,
    ROUND(AVG(offense_succeeded), 2) AS mean_value,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY offense_succeeded)::NUMERIC, 2) AS median_value,
    ROUND(MODE() WITHIN GROUP (ORDER BY offense_succeeded), 2) AS mode_value,
    ROUND(STDDEV(offense_succeeded), 2) AS standard_deviation,
    ROUND(VARIANCE(offense_succeeded), 2) AS variance_value
FROM bjj_tournament.match_points
WHERE offense_succeeded <> 0;

minimum_value|maximum_value|mean_value|median_value|mode_value|standard_deviation|variance_value|
-------------+-------------+----------+------------+----------+------------------+--------------+
         1.00|         5.00|      1.94|        2.00|      1.00|              1.14|          1.31|

/*
---------------------------------------------------

**Summary Stats Defensive Successes***

---------------------------------------------------
*/

SELECT
	ROUND(MIN(defense_succeeded), 2) AS minimum_value,
    ROUND(MAX(defense_succeeded), 2) AS maximum_value,
    ROUND(AVG(defense_succeeded), 2) AS mean_value,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY defense_succeeded)::numeric, 2) AS median_value,
    ROUND(MODE() WITHIN GROUP (ORDER BY defense_succeeded), 2) AS mode_value,
    ROUND(STDDEV(defense_succeeded), 2) AS standard_deviation,
    ROUND(VARIANCE(defense_succeeded), 2) AS variance_value
FROM bjj_tournament.match_points
WHERE defense_succeeded <> 0;

minimum_value|maximum_value|mean_value|median_value|mode_value|standard_deviation|variance_value|
-------------+-------------+----------+------------+----------+------------------+--------------+
         1.00|         5.00|      1.83|        1.50|      1.00|              1.10|          1.21|

/* The above 2 queries show summary statistics for both offensive & defensive successes. */

/*
---------------------------------------------------

**CTE Example Query**

---------------------------------------------------
*/

WITH deduped_moves AS (
	SELECT 
		DISTINCT *
  	FROM 
  		bjj_tournament.moves
 )
 SELECT 
 	COUNT(*)
 FROM deduped_moves;
   
count|
-----+
   21|
   
/*
---------------------------------------------------

**Subquery Example**

---------------------------------------------------
*/

SELECT 
	COUNT(*)
FROM 
(
	SELECT 
		DISTINCT *
  	FROM 
  		bjj_tournament.moves
 ) AS subquery;
  
count|
-----+
   21|
