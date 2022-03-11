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
SELECT points_scored / 5 AS points_scored_per_match, points_given_up / 5 AS points_lost_per_match
FROM bjj_tournament.match_results
WHERE points_scored IS NOT NULL;
-- Scored an avg of 7 points per match
-- Gave up an avg of just 2 points per match 

| points_scored_per_match | points_lost_per_match |
| ----------------------- | --------------------- |
| 7                       | 2                     |

---------------------------------------------------
**Win/Loss result**
SELECT results
FROM bjj_tournament.match_results;
-- Total of 5 matches, lost 1.

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
**Query #1**

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

**Offense Attempts**
SELECT move_name, SUM(offense_attempted) AS offensive_attempts
FROM bjj_tournament.match_points
WHERE offense_attempted > 0
GROUP BY move_name;

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
SELECT move_name, SUM(offense_succeeded) AS offensive_successes
FROM bjj_tournament.match_points
WHERE offense_succeeded > 0
GROUP BY move_name;

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















