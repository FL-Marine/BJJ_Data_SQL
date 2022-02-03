Offensive & Defensive points per match
SELECT points_scored / 5 AS points_scored_per_match, points_given_up / 5 AS points_lost_per_match
FROM bjj_tournament.match_results
WHERE points_scored IS NOT NULL;
/* Scored an avg of 7 points per match
Gave up an avg of just 2 points per match */

| points_scored_per_match | points_lost_per_match |
| ----------------------- | --------------------- |
| 7                       | 2                     |


