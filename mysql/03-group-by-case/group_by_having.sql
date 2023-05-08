

-- if the group by is used like this, it will just show the unique values for each first_name
select first_name
from sakila.actor
group by first_name;


-- we can rewrite this query using the 'distinct' keyword
select distinct first_name
from sakila.actor;


-- query the count of the first names in the actor table
select first_name, count(first_name) as count
from sakila.actor
group by first_name;

-- order the names alphabetically in descending order
select first_name, count(first_name) as count
from sakila.actor
group by first_name
order by first_name desc;

-- query the count of the first names in the actor table
-- but only print the ones where the count is more than 3

select first_name, count(first_name) as name_count
from sakila.actor
group by first_name
-- the where clause can not be used with aggregate functions
where name_count > 3;

select first_name, count(first_name) as name_count
from sakila.actor
where first_name like 'A%'
group by first_name;

-- having was introduced in SQL because the where clause can not be used with aggregate functions
-- where clause should always be used before the group by clause
select first_name, count(first_name) as name_count
from sakila.actor
where first_name like 'J%'
group by first_name
having name_count > 3;
