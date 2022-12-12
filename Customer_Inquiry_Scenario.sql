CREATE TABLE Customer
            (cust_id number(4) PRIMARY KEY,
             cust_name varchar(20),
             cust_city varchar(20),
             cust_state varchar(20),
             cust_dob date,
             gender varchar(10));
             
INSERT ALL

INTO Customer VALUES (100,'Tim','Chennai','TN','22-FEB-00','M')
INTO Customer VALUES (101,'Bill','Bangalore','KA','04-JAN-00','M')
INTO Customer VALUES (102,'Ravi','Chennai','TN',NULL,'M')
INTO Customer VALUES (103,'Pallavi','Bangalore','KA','10-APR-98','F')
INTO Customer VALUES (104,'Prithvi','Mumbai','MH','18-OCT-97','F')

SELECT * FROM dual;

SELECT * FROM Customer;

CREATE TABLE Inquiry
        (inquiry_id number(4) PRIMARY KEY,
         inquiry_date date,
         inquiry_type varchar(20),
         inquiry varchar(20),
         cust_id number(4) REFERENCES Customer(cust_id));
         
INSERT ALL

INTO Inquiry VALUES (1,'25-AUG-21','Internet','New Connection',NULL)
INTO Inquiry VALUES (2,'25-AUG-21','Voice','Upgrade',101)
INTO Inquiry VALUES (3,'14-AUG-21','Internet','Data Upgrade',102)
INTO Inquiry VALUES (4,'15-AUG-21','Internet','Line Down message',102)
INTO Inquiry VALUES (5,'20-AUG-21','Voice','New Connection',NULL)
INTO Inquiry VALUES (6,'21-AUG-21','Internet','Line Down message',103)
INTO Inquiry VALUES (7,'22-AUG-21','Voice','Data Upgrade',102)

SELECT * FROM dual;

SELECT * FROM Inquiry;

-- Display the customer name who are Male and who belongs to KA or MH

SELECT cust_name 
FROM Customer
WHERE gender = 'M' AND (cust_state LIKE 'KA' OR cust_state LIKE 'MH') ;

-- Display the customers who are from same city as customer Pallavi

SELECT cust_name 
FROM Customer
WHERE cust_city = (SELECT cust_city FROM Customer WHERE cust_name = 'Pallavi') ;

-- Dispay the number of customers who are in TN state

SELECT COUNT(cust_id)
FROM Customer
WHERE cust_state = 'TN' ;

-- Display the inquiry which belongs to Voice type and inquiry belongs to New Connection

SELECT inquiry_id, inquiry
FROM Inquiry
WHERE inquiry_type = 'Voice' AND inquiry = 'New Connection' ;

-- Display the inquiry which does not associate to any registered customer

SELECT inquiry_id, inquiry
FROM Inquiry
WHERE cust_id IS NULL ;

-- Display the customers who don’t have any inquiry

SELECT cust_name 
FROM Customer
WHERE cust_id NOT IN (SELECT cust_id FROM Inquiry WHERE cust_id IS NOT NULL ) ;

-- Display the customers whose name starts with P and belings to KA or MH and who are Female customers

SELECT cust_name 
FROM Customer
WHERE cust_name LIKE 'P%' AND (cust_state = 'KA' OR cust_state = 'MH') AND gender = 'F' ;

-- Display the inquiry date, inqury type and inquiry from customers in the year 2021

SELECT inquiry_date, inquiry_type, inquiry 
FROM Inquiry
WHERE to_char(inquiry_date,'yyyy') = 2021

-- Display the number of inquiries which came because of Voice inquiry type

SELECT COUNT(inquiry_id)
FROM Inquiry
WHERE inquiry_type = 'Voice'

-- Display the customer name, inquiry date, inquiry type for the customers who are from the state of KA

SELECT cust_name, inquiry_date, inquiry_type
FROM Customer c INNER JOIN Inquiry i ON c.cust_id = i.cust_id
WHERE c.cust_state = 'KA'

               