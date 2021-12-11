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
    "move_name" VARCHAR(50)
  );
    
INSERT INTO moves 
    ("move_id", "move_name")
VALUES
     ('1', 'guard_pull'),
     ('2', 'single_leg'),
     ('3', 'double_leg'),
     ('4', 'arm_drag'),
    ('5', 'trip'),
     ('6', 'lateral_throw'),
     ('7', 'guard'),
     ('8', 'half_guard'),
     ('9', 'side_control'),
     ('10', 'mount'),
     ('11', 'back'),
     ('12', 'sweep'),
     ('13', 'guard_pass'),
     ('14', 'arm_bar'),
     ('15', 'americana'),
     ('16', 'kimura'),
     ('17', 'rear_naked'),
     ('18', 'front_collar'),
     ('19', 'triangle'),
     ('20', 'arm_triangle'),
     ('21', 'guillotine'),
     ('22', 'other');
    
   	
   
 
