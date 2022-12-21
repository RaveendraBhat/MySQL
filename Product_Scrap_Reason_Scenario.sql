CREATE TABLE Reason
        (reason_ID number(4) PRIMARY KEY,
         reason_description varchar(25)); 

INSERT ALL

INTO Reason VALUES (32,'Power Failure')
INTO Reason VALUES (37,'General Scrap')
INTO Reason VALUES (36,'Machine Problem')
INTO Reason VALUES (38,'Sample')
INTO Reason VALUES (50,'General Quality')
INTO Reason VALUES (84,'Too full')
INTO Reason VALUES (81,'Machine failure')
INTO Reason VALUES (97,'Leftover on drum')

SELECT * FROM dual;
    
SELECT * from reason;

CREATE TABLE products
        (Product_ID number(4) PRIMARY KEY,
         Product_Name varchar(30));

INSERT ALL

INTO products VALUES (9,'Cat5e Core')
INTO products VALUES (20,'Cat6')
INTO products VALUES (65,'G2 (BME std)')
INTO products VALUES (52,'Surface/Harness .71 CU')
INTO products VALUES (78,'Telephone')
INTO products VALUES (81,'Sample')
INTO products VALUES (652,'Sasol-Single Grey Busline')

SELECT * FROM dual;
    
SELECT * from products;

CREATE TABLE ProjectSite
        (site_id number(4) PRIMARY KEY,
         ProjectSite_Name varchar(30)); 
         
INSERT ALL

INTO ProjectSite VALUES (3,'Linmar Factory')
INTO ProjectSite VALUES (2,'Head Office')
INTO ProjectSite VALUES (123,'Silcom Manufacturing')
INTO ProjectSite VALUES (1191,'FORD Durban Office')

SELECT * FROM dual;
    
SELECT * from ProjectSite;

CREATE TABLE product_scrap
        (scrap_gen_id number(4) PRIMARY KEY,
         site_id number(4) REFERENCES ProjectSite(site_id),
         product_id number(4) REFERENCES products(Product_ID),
         reason_id number(4) REFERENCES Reason(reason_ID),
         Scrap_Length  number(6),
         Scrap_Weight number(6)) ;

INSERT ALL

INTO product_scrap VALUES (123,3,9,32,40,150)
INTO product_scrap VALUES (124,2,20,37,0,200)
INTO product_scrap VALUES (125,123,65,36,300,25)
INTO product_scrap VALUES (126,1191,9,36,450,550)
INTO product_scrap VALUES (127,3,52,38,250,600)
INTO product_scrap VALUES (128,1191,78,50,700,1500)
INTO product_scrap VALUES (129,2,81,84,0,2000)
INTO product_scrap VALUES (130,3,81,37,130,350)
INTO product_scrap VALUES (131,3,9,81,500,600)

SELECT * FROM dual;
    
SELECT * from product_scrap;

COMMIT

-- Write a query to give me the reason description and total length of scrap

SELECT reason_description, nvl(SUM(scrap_length),0) AS total_length_of_scrap
FROM reason FULL JOIN product_scrap ON reason.reason_id = product_scrap.reason_id
GROUP BY reason_description ;

-- what are the common reasons of scrap generation between Cat6 and Cat5e Core

SELECT reason_description
FROM reason INNER JOIN product_scrap ON reason.reason_id = product_scrap.reason_id
            INNER JOIN products ON products.product_id = product_scrap.product_id
WHERE product_name = 'Cat6' 

INTERSECT

SELECT reason_description
FROM reason INNER JOIN product_scrap ON reason.reason_id = product_scrap.reason_id
            INNER JOIN products ON products.product_id = product_scrap.product_id
WHERE product_name = 'Cat5e Core' ;

-- Find the products which are being associated with Limmar Factory

SELECT DISTINCT product_name 
FROM products INNER JOIN product_scrap ON products.product_id = product_scrap.product_id
              INNER JOIN ProjectSite ON ProjectSite.site_id =  product_scrap.site_id
WHERE projectsite_name = 'Linmar Factory' ;

-- Write a query to get the product which gives the most scrap length in each project site
                                    
SELECT product_name, projectsite_name
FROM products INNER JOIN product_scrap ON products.product_id = product_scrap.product_id
              INNER JOIN ProjectSite ON ProjectSite.site_id =  product_scrap.site_id
WHERE product_scrap.scrap_length IN (SELECT MAX(scrap_length) FROM product_scrap GROUP BY site_id)
ORDER BY projectsite_name

-- Find the highest reason of rejection (in terms of transaction count)

SELECT reason_description  --, COUNT(product_scrap.reason_id) AS no_of_rejection
FROM reason INNER JOIN product_scrap ON reason.reason_id = product_scrap.reason_id
GROUP BY reason_description  
HAVING COUNT(product_scrap.reason_id) = (SELECT MAX(COUNT(reason_id)) FROM product_scrap group by reason_id)

-- What is the total length of scrap for Cat6 and Telephone put together

SELECT SUM(scrap_length) AS total_Scrap_length
FROM products INNER JOIN product_scrap ON products.product_id = product_scrap.product_id
WHERE products.product_id IN (SELECT product_id FROM products WHERE product_name = 'Cat6' OR product_name = 'Telephone') ;

-- Find the product name where we don’t have any transaction associated with

SELECT product_name
FROM products FULL JOIN product_scrap ON products.product_id = product_scrap.product_id
WHERE products.product_id NOT IN (SELECT product_id FROM product_scrap) ;

-- Display the site name, product name, reason of scrap, length and weight from Head Office

SELECT projectsite_name, product_name, reason_description, scrap_length, scrap_weight
FROM products INNER JOIN product_scrap ON products.product_id = product_scrap.product_id
              INNER JOIN ProjectSite ON ProjectSite.site_id =  product_scrap.site_id
              INNER JOIN reason ON reason.reason_id = product_scrap.reason_id
WHERE ProjectSite_Name = 'Head Office' ;

-- Find the product name and site name for all the Power Failure reason associated with

SELECT product_name, projectsite_name
FROM products INNER JOIN product_scrap ON products.product_id = product_scrap.product_id
              INNER JOIN ProjectSite ON ProjectSite.site_id =  product_scrap.site_id
              INNER JOIN reason ON reason.reason_id = product_scrap.reason_id
WHERE reason_description = 'Power Failure' ;


SELECT * from reason;
SELECT * from products;
SELECT * from ProjectSite;
SELECT * from product_scrap;