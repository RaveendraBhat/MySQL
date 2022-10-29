select * from sales;

select * from people;

select s.SaleDate, s.SPID, s.Amount, p.Salesperson, p.SPID
from sales s
join people p on p.SPID = s.SPID;

select s.SaleDate, s.Amount, pr.Product
from sales s
left join products pr on pr.pid = s.pid;

select s.SaleDate, s.Amount, pr.Product, p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.pid = s.pid;

select s.SaleDate, s.Amount, pr.Product, p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.pid = s.pid
where s.Amount < 500 and p.Team = 'Delish';

select s.SaleDate, s.Amount, pr.Product, p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.pid = s.pid
where s.Amount < 500 and p.Team = '' ;

select p.Salesperson, s.SaleDate, s.Amount, pr.Product, p.Team, g.Geo
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.pid = s.pid
join geo g on g.GeoID = s.GeoID
where s.Amount < 500 
and p.Team = '' 
and g.Geo in ('New Zealand','India') 
order by SaleDate;

select GeoID, sum(Amount), avg(Amount), sum(Boxes)
from sales
group by GeoID;

select g.Geo, sum(Amount), avg(Amount), sum(Boxes)
from sales s
join geo g on g.geoID = s.geoID
group by g.geo ;

select pr.Category, p.Team, sum(Boxes), sum(Amount)
from sales s
join products pr on pr.pid = s.pid
join people p on p.spid = s.spid
where p.Team <> ''
group by pr.Category, p.Team
order by pr.Category, p.Team;

select * from products ;

select pr.Product, sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.pid = s.pid
group by pr.Product
order by 'Total Amount' desc
limit 10;




























