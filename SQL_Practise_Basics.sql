show tables;

desc sales;
desc products;
desc people;
desc geo;

select * from sales;

select SaleDate, Amount, Customers from sales;

select SaleDate, Amount, Boxes, Amount / Boxes 'Amount per box' from sales;

select * from sales
where Amount > 10000;

select * from sales
where Amount > 10000
order by Amount desc;

select * from sales
where GeoID = 'G1'
order by PID, Amount desc;

select * from sales
where Amount > 10000 and SaleDate >= '2022-01-01';

select SaleDate, Amount from sales
where Amount > 10000 and year(SaleDate) = 2022
order by Amount desc;

select * from sales
where Boxes > 0 and Boxes <= 50;

select * from sales
where Boxes between 0 and 50;

select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of Week'
from sales
where weekday(SaleDate) = 4;

select * from people;

select * from people
where team = 'delish' or team = 'jucies';

select * from people
where team in ('delish','jucies');

select * from people
where Salesperson like 'B%' ;

select * from people
where Salesperson like '%B%' ;

select SaleDate, Amount,
		case  when Amount < 1000 then 'Under 1k'
			  when Amount < 5000 then 'Under 5k'
              when Amount < 10000 then 'Under 10k'
			else '10k or more'
		end as 'Amount category'
from sales;








