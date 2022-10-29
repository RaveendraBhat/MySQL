CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker(
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT(15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25) 
);

INSERT INTO Worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
   
SELECT * FROM Title
   
CREATE TABLE Bonus (
	WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
	ON DELETE CASCADE
);

INSERT INTO Bonus
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');

CREATE TABLE Title (
	WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
	ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
		(001, 'Manager', '2016-02-20 00:00:00'),
		(002, 'Executive', '2016-06-11 00:00:00'),
		(008, 'Executive', '2016-06-11 00:00:00'),
		(005, 'Manager', '2016-06-11 00:00:00'),
		(004, 'Asst. Manager', '2016-06-11 00:00:00'),
		(007, 'Executive', '2016-06-11 00:00:00'),
		(006, 'Lead', '2016-06-11 00:00:00'),
		(003, 'Lead', '2016-06-11 00:00:00');
   
select first_name AS WORKER_NAME from worker ;

select UPPER(first_name) from worker ;

select distinct department from worker ;

select department from worker group by department;

select substring(first_name,1,3) from worker;

select instr(first_name,'B') from worker where first_name = 'Amitabh'

select RTRIM(first_name) from worker;

select LTRIM(department) from worker;

select distinct department, length(department) from worker;

select replace(first_name,'a','A') from worker;

select concat(first_name,' ',last_name) AS Complete_Name from worker;

select * from worker order by first_name;

select * from worker order by first_name, department desc;

select * from worker where first_name in ('Vipul','Satish');

select * from worker where first_name not in ('Vipul','Satish');

select * from worker where department like 'Admin%';

select * from worker where first_name like '%a%';

select * from worker where first_name like '%a';

select * from worker where first_name like '_____h';

select * from worker where salary between 100000 AND 500000;

select * from worker where YEAR(joining_date)=2014 AND MONTH(joining_date) = 02;

select department, count(*) from worker where department = 'admin';

select concat(first_name,' ', last_name) AS Full_Name, Salary from worker 
where salary between 50000 AND 100000;

select department, count(worker_id) AS no_of_workers from worker group by department
order by no_of_workers desc;

select w.* from worker as w inner join title as t on w.worker_id = t.worker_ref_id
where t.WORKER_TITLE = 'Manager';

select worker_title, count(*) as count from title group by worker_title having count >1;

select * from worker where mod(worker_id,2) != 0 ;

select * from worker where mod(worker_id,2) <> 0 ;

select * from worker where mod(worker_id,2) = 0 ;

CREATE Table worker_clone like worker;
INSERT INTO worker_clone select * from worker;
select * from worker_clone;

select worker.* from worker inner join worker_clone using (worker_id);

select worker.* from worker left join worker_clone using (worker_id) 
where worker_clone.worker_id is null;

select curdate();
select now();

select * from worker order by salary desc limit 5;

select * from worker order by salary desc limit 4,1;

select w1.* from worker w1, worker w2 where w1.salary = w2.salary 
and w1.worker_id != w2.worker_id;

select max(salary) from worker
where salary not in (select max(salary) from worker);

select * from worker 
UNION ALL
select * from worker
order by worker_id;

select worker_id from worker where worker_id not in (select worker_ref_id from bonus);

select * from worker where worker_id <= (select count(worker_id)/2 from worker);

select department, count(department) as depCount from worker group by department 
having depCount < 4 ;

select department, count(department) as depCount from worker group by department;

select * from worker where worker_id = (select max(worker_id) from worker);

select * from worker where worker_id = (select min(worker_id) from worker);

(select * from worker order by worker_id desc limit 5) order by worker_id ;

select w.department, w.first_name, w.salary from
(select max(salary) as maxSal, department from worker group by department) temp
inner join worker w on temp.department = w.department and temp.maxSal = w.salary;

select distinct salary from worker order by salary desc limit 3;

select distinct salary from worker order by salary asc limit 3;

select department,sum(salary) as depSal from worker group by department order by depSal desc;

select first_name, salary from worker where salary = (select max(salary) from worker);












































































