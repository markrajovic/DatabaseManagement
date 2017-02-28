-- LAB 6 --
-- Query 1 --
select  distinct customers.name, customers.city
from customers
inner join products on products.city = customers.city
where products.city in (select city
                        from(
                             select city, count(*)
                             from products
                             group by city
                             order by count DESC
                             limit 1)s1
                        );
-- Query 2 --   
select name
from products
where priceUSD > (select avg (priceUSD) from products)
order by name DESC;

-- Query 3 --
select customers.name, orders.pid, totalUSD
from customers
inner join orders on orders.cid = customers.cid
order by totalUSD ASC;

-- Query 4 --
select customers.name, sum (coalesce (totalUSD,0)) as Total_Ordered
from customers 
left outer join orders on orders.cid = customers.cid
group by customers.name
order by customers.name;

-- Query 5 --
select customers.name, products.name, agents.name
from customers
inner join orders on customers.cid = orders.cid
inner join agents on orders.aid = agents.aid
inner join products on orders.pid = products.pid
where agents.city = 'Newark' 

-- Query 6 --
select ordNumber, month, orders.cid, orders.aid, orders.pid, orders.qty, totalUSD as "totalUSDfromOrders", 
       (orders.qty*products.priceUSD - (orders.qty*products.priceUSD* (customers.discount/100))) as "calculatedUSD"
from orders
inner join products on orders.pid = products.pid
inner join customers on orders.cid = customers.cid
where orders.totalUSD != (orders.qty*products.priceUSD - (orders.qty*products.priceUSD* (customers.discount/100)));

-- 7 --
select customers.city, agents.city
from customers
left outer join agents on customers.city = agents.city

select customers.city, agents.city
from customers
right outer join agents on customers.city = agents.city

-- The difference between left and right outer joins are which table is referenced first. The two queries above provide examples of this
-- the top query is a left outer join, it selects all the cities from the customers table and displays where there are matched from the 
-- cities in the agents table. The bottom is a right outer join, it selects all the cities from the agents table and displays the cities
-- from the customers table where there are matcher. Where there are no matches, null values are returned.





   