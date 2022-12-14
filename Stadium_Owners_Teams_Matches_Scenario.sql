CREATE TABLE stadium 
        (sta_id number(4) PRIMARY KEY,
         sta_code varchar(15),
         sta_name varchar(20),
         sta_capacity number(10),
         sta_type varchar(15),
         sta_city varchar(15),
         sta_opened_date date,
         sta_status varchar(4));
         
INSERT ALL

INTO stadium VALUES (1000,'KA-BLR-001','Chinnaswamy Stadium',15000,'OUTDOOR','Bangalore','10-Feb-69','A')
INTO stadium VALUES (1001,'KA-BLR-002','Kanteerava Stadium',35000,'OUTDOOR','Bangalore','15-Aug-74','A')
INTO stadium VALUES (1002,'KA-MYS-001','Mysore Stadium',15000,'OUTDOOR','Mysore','18-Nov-88','A')
INTO stadium VALUES (1003,'TS-HYD-001','NTR Stadium',6000,'INDOOR','Hyderabad','15-Aug-85','A')

SELECT * FROM dual;

SELECT * FROM stadium;

COMMIT

CREATE TABLE team
            (team_id number(4) PRIMARY KEY,
             team_nm varchar(15),
             game varchar(15),
             operational_from date,
             manager varchar(15)) ;
             
INSERT ALL

INTO team VALUES (50,'TITANS','Cricket','14-Mar-19','Shankar')
INTO team VALUES (51,'FLYERS','FootBall','13-Nov-20','Pranav')
INTO team VALUES (52,'BULLS','Cricket','18-Mar-18','Kumar')
INTO team VALUES (53,'STARS','FootBall','15-Aug-17','Subhash')
INTO team VALUES (54,'GIANTS','Cricket','12-Jan-17','Raman')

SELECT * FROM dual;

SELECT * FROM team;

COMMIT

CREATE TABLE team_owners
            (own_id number(4) PRIMARY KEY,
             own_name varchar(15),
             team_id number(4) REFERENCES team(team_id),
             percentage number(4));
             
INSERT ALL

INTO team_owners VALUES (1,'SURAJ',50,100)
INTO team_owners VALUES (2,'RAGHAVAN',51,75)
INTO team_owners VALUES (3,'Birla',51,25)
INTO team_owners VALUES (4,'TATA Group',52,100)
INTO team_owners VALUES (5,'Uma',53,30)
INTO team_owners VALUES (6,'Vijay',53,60)
INTO team_owners VALUES (7,'RAMA',54,100)
INTO team_owners VALUES (8,'KAMAL',53,10)

SELECT * FROM dual;

SELECT * FROM team_owners;

COMMIT

CREATE TABLE match
        (Match_id number(4) PRIMARY KEY,
         Match_date date,
         Game varchar(15),
         Public_tickets number(10),
         Sponsor_tickets number(10),
         Public_ticket_price number(10),
         sponsor_ticket_price number(10),
         sta_id number(4) REFERENCES stadium(sta_id),
         home_team_id number(4) REFERENCES team(team_id),
         visiting_team_id number(4) REFERENCES team(team_id)) ;
         
INSERT ALL

INTO match VALUES (10,'10-Jun-22','Cricket',10000,4000,450,300,1000,50,52)
INTO match VALUES (11,'12-Jun-22','FootBall',25000,10000,300,150,1001,51,53)
INTO match VALUES (12,'15-Jul-22','FootBall',12500,2500,425,270,1000,53,51)
INTO match VALUES (13,'19-Jul-22','Cricket',10000,5000,600,250,1000,52,54)
INTO match VALUES (14,'20-Aug-22','Cricket',30000,5000,250,100,1001,54,50)

SELECT * FROM dual;

SELECT * FROM match;

-- Display the team_name, owner_name for all the teams

SELECT team_nm, own_name
FROM team t INNER JOIN team_owners t_o ON t.team_id = t_o.team_id ;

-- Display the teams which are operational from the year 2020 and belongs to game of cricket

SELECT team_nm
FROM team
WHERE to_char(operational_from,'yyyy') = 2020 AND game = 'Cricket' ;

-- Display the team and the number of owners

SELECT team_nm, COUNT(own_id)
FROM team t INNER JOIN team_owners t_o ON t.team_id = t_o.team_id
group by team_nm ;

-- Display the oldest team in football game

SELECT team_nm
FROM team
WHERE operational_from = (SELECT MIN(operational_from) FROM team WHERE game = 'FootBall') ;

-- Display the team which has more than 2 owners associated

SELECT team_nm
FROM team t INNER JOIN team_owners t_o ON t.team_id = t_o.team_id
group by team_nm
HAVING COUNT(own_id) > 2 ;

-- What is the relationship between Teams and Match table

-- M:M (M:2)

-- Display match_id, match_date, sta_name, sta_capacity

SELECT match_id, match_date, sta_name, sta_capacity
FROM match m INNER JOIN stadium s ON m.sta_id = s.sta_id

-- Display the matches which are being played in Bangalore

SELECT match_id
FROM match m INNER JOIN stadium s ON m.sta_id = s.sta_id
WHERE sta_city = 'Bangalore'

-- How many matches are happeing in Bangalore in the current month

SELECT COUNT(match_id) AS no_of_matches
FROM match m INNER JOIN stadium s ON m.sta_id = s.sta_id
WHERE sta_city = 'Bangalore' AND to_char(match_date,'mon-yy') = to_char(sysdate,'mon-yy')

-- Display the teams which are owned by TATA Group

SELECT team_nm
FROM team t INNER JOIN team_owners t_o ON t.team_id = t_o.team_id
WHERE own_name = 'TATA Group'


SELECT * FROM match;
SELECT * FROM team_owners;
SELECT * FROM team;
SELECT * FROM stadium;
