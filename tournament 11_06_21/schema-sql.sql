CREATE SCHEMA bjj_tournament;
SET search_path = bjj_tournament;

 CREATE TABLE tournament_facts (
   "tournament_date" DATE,
   "weight_class" VARCHAR(50),
   "weight_lbs" INTEGER
 );
 
INSERT INTO tournament_facts
   ("tournament_date",  "weight_class",
    "weight_lbs")
VALUES
 ('2021-11-06', 'cruiserweight', '182');
 
CREATE TABLE match_style (
   "match_style" VARCHAR(10)
 );
 
INSERT INTO  match_style
 	("match_style")
VALUES
   	('gi'),
    	('nogi');
    
CREATE TABLE moves (
  	"move_id" INTEGER,
   	"move_name" VARCHAR(50),
  	"category_id" INTEGER,
  	"category_name" VARCHAR(50)
  );
    
INSERT INTO moves 
    ("move_id", "move_name",  "category_id", "category_name")
VALUES
	('1', 'guard pull', '1', 'takedown'),
	('2', 'single leg', '2', 'position'),
    	('3', 'double leg', '3', 'transition'),
    	('4', 'arm drag', '4', 'submission arm'),
	('5', 'trip', '5', 'choke'),
    	('6', 'lateral throw', null, ''),
     	('7', 'guard', null, ''),
     	('8', 'half guard', null, ''),
     	('9', 'side control', null, ''),
     	('10', 'mount', null, ''),
     	('11', 'back', null, ''),
     	('12', 'sweep', null, ''),
     	('13', 'guard pass', null, ''),
     	('14', 'arm bar', null, ''),
     	('15', 'americana', null, ''),
    	('16', 'kimura', null, ''),
     	('17', 'rear naked', null, ''),
     	('18', 'front collar', null, ''),
     	('19', 'triangle', null, ''),
     	('20', 'arm_triangle', null, ''),
     	('21', 'guillotine', null, ''),
     	('22', 'other', null, '');
     


CREATE TABLE match_results (
  "points_scored" INTEGER,
  "points_given_up" INTEGER,
  "results" VARCHAR(2),
  "match_id" INTEGER
 );
 
 INSERT INTO match_results
 ("points_scored", "points_given_up", "results", "match_id")
 VALUES
 	('36', '11', 'W', '1'),
 	(null, null, 'W', '2'),
 	(null, null, 'W', '3'),
 	(null, null, 'W', '4'),
 	(null, null, 'L', '5');
 
