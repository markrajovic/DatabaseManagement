-- Query 1 --
select city
from agents
where aid in (select aid 
              from orders
              where cid = 'c006'
              );
  
-- Query 2 --
select distinct pid
from orders
where cid in (select cid
                  from customers
                  where city in ('Kyoto')
                  )
order by pid DESC;
 
-- Query 3 --
select cid, name
from customers
where cid not in (select cid
                  from orders
                  where aid = ('a01')
                 );

-- Query 4 --
select cid
from orders
where pid = 'p07' 
and cid in (select distinct cid
            from orders
            where pid = 'p01'
           );

-- Query 5 --
select distinct pid
from products
where pid not in  (select cid
                   from orders
                   where aid = ('a08')
                  )
order by pid DESC;

-- Query 6 --
select name, discount, city
from customers
where cid in (select cid
              from orders
              where aid in (select aid
                            from agents
                            where city in ('Tokyo', 'New York')
                            )
              );

-- Query 7 --
select *
from customers
where discount in (select discount
                   from customers
                   where city in ('Duluth', 'London')
                   );
                   
-- 8
-- 		A check constraint is an integrety constrain that only allows certain values for a column
-- this means that the rows have the correct type of value. For example if it is a column that 
-- requires a boolean value, a string cannot be entered. Another example an be the default values that are assigned
-- to a tuple. Therefore if a string must be entered, there can be a check constraint on the exact string, like month, year or day.
-- Check constraints help organize the database with information that belongs in respective columns. Used properly, 
-- they maintain the integrety of the information in the databade. However not all check constraints should be considered good,
-- some check constraints actually cause problems and should be considered bad. An example of a bad check constraint
-- would be limiting the month of february to 28 days. This is problematic because during leap year, February actually
-- changes to become 29 days. This is an example of a bad check constraint because it is limiting something that has the potential to change.
-- whereas a good check constraint only ensures the integrety of the values in a databse.
                   
                   
                  
    
    
    