-- Lab 5
-- Query 1 --
select city
from agents
inner join orders on orders.aid = agents.aid
where cid = 'c006';
-- Query 2 --
select distinct pid
from orders inner join customers on orders.cid = customers.cid
where city = 'Kyoto'
order by pid DESC;
-- Query 3 --
select name
from customers
where cid not in (select cid
                  from orders);
-- Query 4 --
select name 
from customers
full outer join orders on customers.cid = orders.cid
where orders.ordnumber is null;
-- Query 5 --
select distinct customers.name, agents.name
from customers
full outer join orders on customers.cid = orders.cid
full outer join agents on agents.aid = orders.aid
where agents.city = customers.city;
-- Query 6 --
select customers.name, agents.name, agents.city
from customers
inner join agents on customers.city = agents.city;
-- Query 7 --
select name, city
from customers
where city in (select city
               from (select city, count (*)
                     from products
                     group by city
                     order by count (*) ASC, city
                     limit 1
                    )sub2
               )
group by customers.name, customers.city;
                     


