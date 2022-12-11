CREATE TABLE COUNTRY
        (country_id number(4) PRIMARY KEY,
         country_nm varchar(15));
         
INSERT ALL

INTO Country VALUES(201,'India')
INTO Country VALUES(202,'Sri Lanka')
INTO Country VALUES(203,'Pakistan')

SELECT * FROM dual;

SELECT * FROM Country;

CREATE TABLE STATE
        (state_id number(4) PRIMARY KEY,
         state_nm varchar(15),
         country_id number(4) references country(country_id),
         political_party varchar(15));

SELECT * FROM state;

INSERT ALL

INTO state VALUES (1,'Karnataka',201,'BJP')
INTO state VALUES (2,'Maharashtra',201,'Congress')
INTO state VALUES (3,'Gujarat',201,'BJP')
INTO state VALUES (4,'Andhra',201,'YSR')
INTO state VALUES (5,'Kerala',201,'CPM')

SELECT * FROM dual;

CREATE TABLE city
        (city_id number(4) PRIMARY KEY,
         city_nm varchar(15),
         city_population number(10),
         state_id number(4) references state(state_id));

SELECT * FROM city;

INSERT ALL

INTO city VALUES (11,'Bangalore',12765000,1)
INTO city VALUES (22,'Mysore',1234992,1)
INTO city VALUES (33,'Pune',3891823,2)
INTO city VALUES (44,'Mumbai',20667656,2)
INTO city VALUES (55,'Surat',7489742,3)
INTO city VALUES (66,'Hubli',1136923,1)
INTO city VALUES (77,'Nagpur',1234992,2)

SELECT * FROM dual;

-- How many countries we have?

SELECT COUNT(country_id) AS No_of_countries
FROM country;

-- Find the state names which are ruled by CPM or BJP

SELECT state_nm 
FROM state
WHERE political_party = 'CPM' OR political_party = 'BJP' ;

-- Find the city_name which has more population than Pune

SELECT city_nm
FROM city
WHERE city_population > (SELECT city_population FROM city WHERE city_nm = 'Pune');

-- Find the city_names which are in Karnataka state

SELECT city_nm
FROM city
WHERE state_id = (SELECT state_id FROM state WHERE state_id = 1);

-- Find the city names which are in Maharashtra and the population greater than Surat city

SELECT city_nm
FROM city
WHERE state_id = (SELECT state_id FROM state WHERE state_id = 2) 
      AND
      city_population > (SELECT city_population FROM city WHERE city_nm = 'Surat');
    
-- Find the number of states which are ruled by Congress

SELECT COUNT(state_id) AS no_of_states
FROM state
WHERE political_party = 'Congress';

-- Find the state names which belongs to India and state name starts with G or M

SELECT state_nm
FROM state 
WHERE country_id = (SELECT country_id FROM country WHERE country_nm = 'India')
      AND
     (state_nm LIKE 'G%' OR state_nm LIKE 'M%');
     
-- Find the city names where the names starts with B or M or P and the populatio between 400000 and 8000000

SELECT city_nm
FROM city 
WHERE (city_nm LIKE 'B%' OR city_nm LIKE 'M%' OR city_nm LIKE 'P%')
      AND
      (city_population BETWEEN 400000 AND 8000000);
      
-- How many cities we have which have population more than Bangalore city

SELECT COUNT(city_id) AS no_of_cities
FROM city
WHERE city_population > (SELECT city_population FROM city WHERE city_nm = 'Bangalore');

-- Find the country names which does not have any states

SELECT country_nm
FROM country 
WHERE country_id NOT IN (SELECT country_id FROM state);

-- Find the states which does not have any cities

SELECT state_nm
FROM state 
WHERE state_id NOT IN (SELECT state_id FROM city);

-- Find the cities which are in India

SELECT city_nm
FROM city
WHERE state_id IN (SELECT state_id FROM state WHERE country_id IN 
                    (SELECT country_id FROM country WHERE country_nm = 'India'));
