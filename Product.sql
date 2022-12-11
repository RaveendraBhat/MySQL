SELECT * FROM PRODUCT

INSERT INTO PRODUCT VALUES (100,'Marker','Stationary',25,22,'15-JAN-08');

INSERT INTO PRODUCT VALUES (101,'Mouse','Computer',450,350,'16-APR-09');

INSERT INTO PRODUCT VALUES (102,'White Board','Stationary',450,375,'20-AUG-10');

INSERT INTO PRODUCT VALUES (103,'SONY Vaio','Computer',35000,42000,'21-SEP-10');

COMMIT

-- Write the select statement which gives all the products which costs more than Rs 250

SELECT p_name
FROM product
WHERE price > 250;

-- Write the select statement which gives product name, cost, price and profit. (profit formula is price – cost)

SELECT p_name,cost,price, price-cost AS profit
FROM product

-- Find the products which give more profit than product Mouse

SELECT p_name
FROM product
WHERE price-cost > (SELECT price-cost FROM product WHERE p_name = 'Mouse')

-- Display the products which give the profit greater than 100 Rs

SELECT p_name
FROM product
WHERE price-cost > 100

-- Display the products which are not from Stationary and Computer family

SELECT p_name
FROM product
WHERE p_family != 'Stationary' AND p_family != 'Computer'

-- Display the products which give more profit than the p_id 102

SELECT p_name
FROM product
WHERE price-cost > (SELECT price-cost FROM product WHERE p_id = 102)

-- Display products which are launched in the year of 2010

SELECT p_name
FROM product 
WHERE EXTRACT(YEAR FROM launch_date) = 2010

-- Display the products which name starts with either ‘S’ or ‘W’ and which belongs to Stationary and cost more than 300 Rs

SELECT p_name 
FROM product
WHERE (p_name LIKE 'S%' OR p_name LIKE 'W%')
    AND p_family = 'Stationary'
    AND price > 300
    
-- Display the products which are launching next month

-- select sysdate from dual
-- select add_months(sysdate, 1) FROM dual

SELECT p_name
FROM product
WHERE EXTRACT(MONTH FROM launch_date) = EXTRACT(MONTH FROM (select add_months(sysdate, 1) FROM dual))

-- Display product name which has the maximum price in the entire product table

SELECT p_name
FROM product
WHERE price = (SELECT MAX(price) FROM product)

-- List the product name, cost, price, profit and percentage of profit we get in each product

SELECT p_name, cost, price, price-cost AS profit, round((price-cost)*100/cost,2) AS profit_percentage
FROM product

-- Display how many products we have in Computer family which has the price range between 2000 and 50000

SELECT COUNT(p_id)
FROM product
WHERE p_family = 'Computer' AND (price BETWEEN 2000 AND 50000)
