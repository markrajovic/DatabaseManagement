-- Query 1 --
select ordNumber, totalUSD
from Orders;

-- Query 2 --
select name, city
from agents
where aid in ('a01');

-- Query 3 --
select pid, name, priceUSD
from products
where quantity>200100;

-- Query 4 --
select name, city
from customers
where city in ('Duluth');

-- Query 5--
select name
from agents
where city not in ('New York','Duluth');

-- Query 6 --
select pid, name, city, quantity, priceUSD
from products
where city not in ('Duluth','Dallas') and priceUSD >= 1;

-- Query 7 --
select ordNumber, month, cid, aid, pid, qty, totalUSD
from orders
where month in ('Feb','May');

-- Query 8 --
select ordNumber, month, cid, aid, pid, qty, totalUSD
from orders
where month in ('Feb') and totalUSD >= 600;

-- Query 9 --
select ordNumber
from orders
where cid in ('C005');
