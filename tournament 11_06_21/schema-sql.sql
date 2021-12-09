CREATE SCHEMA bjj_tournament;
SET search_path = bjj_tournament;

CREATE TABLE identifiers (
  "match_id" VARCHAR(1),
  "move_id" VARCHAR(1),
  "tournament_date" DATE,
  "weight_class" VARCHAR(50),
  "match_style" VARCHAR(2)
 );
 
 INSERT INTO identifiers
 	("match_id", "move_id",  "tournament_date", "weight_class",  "match_style")
 VALUES
 ('1', 'A', '2021-11-06', 'cruiserweight', 'gi') 
 
 
**Schema (PostgreSQL v13)**

    CREATE SCHEMA bjj_tournament;
    SET search_path = bjj_tournament;
    
    CREATE TABLE identifiers (
      "match_id" VARCHAR(1),
      "move_id" VARCHAR(1),
      "tournament_date" DATE,
      "weight_class" VARCHAR(50),
      "match_style" VARCHAR(2)
     );
     
     INSERT INTO identifiers
     	("match_id", "move_id",  "tournament_date", "weight_class",  "match_style")
     VALUES
     ('1', 'A', '2021-11-06', 'cruiserweight', 'gi') 

---

**Query #1**

    Select match_id
     from bjj_tournament.identifiers;

| match_id |
| -------- |
| 1        |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/vNohyZX5FcCPyEVqKrL72j/6)
