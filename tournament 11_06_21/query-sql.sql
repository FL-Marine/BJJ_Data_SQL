
**P**

    SELECT points_scored / 5 AS points_scored_per_match, points_given_up / 5 AS points_lost_per_match
    FROM bjj_tournament.match_results
    WHERE points_scored IS NOT NULL;

| points_scored_per_match | points_lost_per_match |
| ----------------------- | --------------------- |
| 7                       | 2                     |

---
**Query #2**

    Select *
    from bjj_tournament.moves
    INNER JOIN bjj_tournament.match_results 
    ON moves.move_id = match_results.move_id;

| move_id | move_name     | category_id | category_name  | points_scored | points_given_up | results | match_id | move_id |
| ------- | ------------- | ----------- | -------------- | ------------- | --------------- | ------- | -------- | ------- |
| 1       | guard pull    | td          | takedown       | 36            | 11              | W       | M1       | 1       |
| 2       | single leg    | td          | takedown       |               |                 | W       | M2       | 2       |
| 3       | double leg    | td          | takedown       |               |                 | W       | M3       | 3       |
| 4       | arm drag      | td          | takedown       |               |                 | W       | M4       | 4       |
| 5       | trip          | td          | takedown       |               |                 | L       | M5       | 5       |
| 6       | lateral throw | td          | takedown       |               |                 |         |          | 6       |
| 7       | guard         | pos         | position       |               |                 |         |          | 7       |
| 8       | half guard    | pos         | position       |               |                 |         |          | 8       |
| 9       | side control  | pos         | position       |               |                 |         |          | 9       |
| 10      | mount         | pos         | position       |               |                 |         |          | 10      |
| 11      | back          | pos         | position       |               |                 |         |          | 11      |
| 12      | sweep         | trn         | transition     |               |                 |         |          | 12      |
| 13      | guard pass    | trn         | transition     |               |                 |         |          | 13      |
| 14      | arm bar       | sa          | submission arm |               |                 |         |          | 14      |
| 15      | americana     | sa          | submission arm |               |                 |         |          | 15      |
| 16      | kimura        | sa          | submission arm |               |                 |         |          | 16      |
| 17      | rear naked    | c           | choke          |               |                 |         |          | 17      |
| 18      | front collar  | c           | choke          |               |                 |         |          | 18      |
| 19      | triangle      | c           | choke          |               |                 |         |          | 19      |
| 20      | arm_triangle  | c           | choke          |               |                 |         |          | 20      |
| 21      | guillotine    | c           | choke          |               |                 |         |          | 21      |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/vNohyZX5FcCPyEVqKrL72j/56)
