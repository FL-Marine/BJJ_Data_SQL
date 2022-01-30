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
    "move_id" VARCHAR(2),
    "move_name" VARCHAR(50),
    "category_id" VARCHAR(3),
    "category_name" VARCHAR(50)
  );
    
INSERT INTO moves 
    ("move_id", "move_name",  "category_id", "category_name")
VALUES
     ('1', 'guard pull', 'td', 'takedown'),
     ('2', 'single leg', 'td', 'takedown'),
     ('3', 'double leg', 'td', 'takedown'),
     ('4', 'arm drag', 'td', 'takedown'),
     ('5', 'trip', 'td', 'takedown'),
     ('6', 'lateral throw', 'td', 'takedown'),
     ('7', 'guard','pos', 'position'),
     ('8', 'half guard','pos', 'position'),
     ('9', 'side control','pos', 'position'),
     ('10', 'mount', 'pos', 'position'),
     ('11', 'back', 'pos', 'position'),
     ('12', 'sweep', 'trn', 'transition'),
     ('13', 'guard pass', 'trn', 'transition'),
     ('14', 'arm bar', 'sa', 'submission arm'),
     ('15', 'americana','sa', 'submission arm'),
     ('16', 'kimura', 'sa', 'submission arm'),
     ('17', 'rear naked', 'c', 'choke'),
     ('18', 'front collar', 'c', 'choke'),
     ('19', 'triangle', 'c', 'choke'),
     ('20', 'arm_triangle', 'c', 'choke'),
     ('21', 'guillotine', 'c', 'choke');
   
CREATE TABLE match_results (
  "points_scored" INTEGER,
  "points_given_up" INTEGER,
  "results" VARCHAR(2),
  "match_id" VARCHAR(2),
  "move_id" VARCHAR(2)
 );
 
 INSERT INTO match_results
 ("points_scored", "points_given_up", "results", "match_id", "move_id")
 VALUES
 	('36', '11', 'W', 'M1', '1'),
    	(null, null, 'W', 'M2', '2'),
    	(null, null, 'W', 'M3', '3'),
   	(null, null, 'W', 'M4', '4'),
   	(null, null, 'L', 'M5', '5'),
    	(null, null, '', null, '6'),
    	(null, null, '', null, '7'),
 	(null, null, '', null, '8'),
	(null, null, '', null, '9'),
        (null, null, '', null, '10'),
        (null, null, '', null, '11'),
        (null, null, '', null, '12'),
        (null, null, '', null, '13'),
        (null, null, '', null, '14'),
        (null, null, '', null, '15'),
        (null, null, '', null, '16'),
        (null, null, '', null, '17'),
        (null, null, '', null, '18'),
        (null, null, '', null, '19'),
        (null, null, '', null, '20'),
        (null, null, '', null, '21');
    
    CREATE TABLE match_points (
    "move_name" VARCHAR(50),
    "move_id" VARCHAR(2),
    "offense_attempted" INTEGER,
    "offense_succeeded" INTEGER,
    "defense_attempted" INTEGER,
    "defense_succeeded" INTEGER,
    "match_id"  VARCHAR(2)
    );
 
 INSERT INTO match_points
 ("move_name", "move_id", "offense_attempted", "offense_succeeded", "defense_attempted", "defense_succeeded", "match_id")
 VALUES
  ('arm drag','4', '3', '0', '0', '3', 'M1'),
  ('trip', '5', '0', '0', '0', '5', 'M1'),
  ('lateral throw', '6', '1', '0', '0', '0', 'M1'),
  ('guard', '7', '1','0', '0', '0', 'M1'),
  ('single leg', '2', '0', '0', '0', '1', 'M1'),
  ('trip', '5', '0', '0', '0', '2', 'M2'),
  ('lateral throw', '6', '0', '1', '0', '0', 'M2'),
  ('guard', '7', '0','1', '0', '0', 'M2'),
  ('side control', '9', '0', '3', '0', '0', 'M2'),
  ('mount', '10', '0', '2', '0','0','M2'),
  ('sweep',	'12', '0',	'0', '1', '1', 'M2'),
  ('guard pass', '13', '3', '2', '0', '0', 'M2'),
  ('arm bar', '14',	'1', '0', '0', '1', 'M2'),
  ('triangle', '19', '0', '0', '0', '1', 'M2'),
  ('double leg', '3', '0', '0', '0', '1', 'M3'),
  ('lateral throw',	'6', '0', '1', '0', '0', 'M3'),
  ('guard',	'7', '0', '1', '0',	'2', 'M3'),
  ('half guard', '8', '0', '1',	'0', '0', 'M3'),
  ('side control', '9',	'0', '0', '1', '0', 'M3'),
  ('mount',	'10', '0', '2','0','2','M3'),
  ('back', '11', '0', '1', '0', '0', 'M3'),
  ('sweep',	'12', '0', '0', '2', '1', 'M3'),
  ('guard pass', '13', '1', '1', '0', '0', 'M3'),
  ('rear naked', '17', '1', '0', '0','0', 'M3'),
  ('triangle', '19', '2', '0', '0', '0', 'M3'),
  ('guard pull', '1', '0', '0', '1', '0', 'M4'),
  ('single leg', '2', '0', '0', '0', '0', 'M4'),
  ('double leg', '3', '1', '0',	'0', '0', 'M4'),
  ('trip', '5',	'1', '0', '0', '0',	'M4'),
  ('guard', '7', '0', '0', '1',	'0', 'M4'),
  ('half guard', '8', '0', '2',	'1', '0', 'M4'),
  ('back', '11', '0', '0', '0',	'2', 'M4'),
  ('sweep', '12', '0', '0', '1', '1', 'M4'),
  ('guard pass', '13', '3', '0', '0', '0', 'M4'),
  ('arm bar', '14', '0', '0', '1', '0', 'M4'),
  ('kimura', '16', '0',	'0', '1', '1', 'M4'),
  ('single leg', '2', '0', '0',	'0', '3', 'M5'),
  ('double leg', '3', '0', '0', '0', '3', 'M5'),
  ('lateral throw', '6', '0', '5', '0',	'0', 'M5'),
  ('guard', '7', '0', '4', '0', '0', 'M5'),
  ('half guard', '8', '0', '2',	'0', '0', 'M5'),
  ('side control',  '9', '0', '2', '0', '0', 'M5'),  
  ('sweep', '12', '0', '2', '0', '2', 'M5'),
  ('guard pass', '13', '5', '0', '0', '0', 'M5'),
  ('triangle', '19', '0', '0', '0', '1', 'M5');
  
