
-- indexes are for speeding up queries
select * from employees.employees
where hire_date > '1998-01-01';

-- create an index on the hire_date column
create index hire_date_index on employees.employees(hire_date);

-- now the should will be faster
select * from employees.employees
where hire_date > '1998-01-01';

-- in case you don't have too much data in the table, the query will maybe be slower!

-- you can also create indexes for multiple columns:
create index i_composite on employees.employees(first_name, last_name);

-- display the indexes of a table
show index from employees.employees;

-- drop an index
drop index i_composite on employees.employees;
drop index hire_date_index on employees.employees;

-- too many indexes can also slow down the queries!
