

-- view is like a dynamic table and it's meant to be used to simplify queries

create or replace view employees.v_department_emp_latest_date as
select emp_no, max(from_date) as from_date, max(to_date) as to_date
from employees.dept_emp
group by emp_no
limit 10;

select * from employees.v_department_emp_latest_date;

-- display the view definition
show create view employees.v_department_emp_latest_date;


-- stored procedure is a set of SQL statements that can be executed together

use employees;
drop procedure if exists select_employees;

-- changing the delimiter to something else than ;
delimiter $$
create procedure select_employees()
begin
    select * from employees
    limit 10;
end$$
delimiter ;

use employees;
call select_employees();
-- or without the parenthesis
use employees;
call select_employees;


-- procedure with input and output parameters
use employees;
drop procedure if exists emp_avg_salary_out;

delimiter $$
use employees$$

create procedure emp_avg_salary_out(
    in p_emp_no int,
    -- decimal(10,2) means 10 digits with 2 decimals: for example 1234567.89
    out p_avg_salary decimal(10,2)
)
begin
    select avg(salaries.salary) into p_avg_salary
    from employees
    join salaries using(emp_no)
    where employees.emp_no = p_emp_no;
end$$
delimiter ;


use employees;
set @avg_salary = 0;
call emp_avg_salary_out(10001, @avg_salary);
-- local variable:
select @avg_salary;


-- global variable:
select @@global.max_connections;

set @@global.max_connections = 1;


-- show all global variables
show variables;


-- funtions are similar to procedures but they always return a value (we can not use insert, or update statements in functions)
-- a procedure can have multiple out parameters but a function can only have one return value

use employees;
drop function if exists f_emp_avg_salary;

delimiter $$
create function f_emp_avg_salary(p_emp_no int) returns decimal(10,2)
  begin

  declare v_avg_salary decimal(10,2);
  select avg(salaries.salary) into v_avg_salary
  from employees
  join salaries using(emp_no)
  where employees.emp_no = p_emp_no;

  return v_avg_salary;
end$$

delimiter ;

select employees.f_emp_avg_salary(10001);

-- local variables:
use employees;
set @v_emp_no = 10001;
select emp_no, first_name, last_name, f_emp_avg_salary(@v_emp_no) as avg_salary
from employees
where emp_no = @v_emp_no;

-- from mysql 5.5 we can not create global variables

-- to be able to work with global variables, we can for example create a stored procedure that will give us back
-- the variable value
drop procedure if exists employees.get_my_var;
delimiter $$
create procedure employees.get_my_var()
  begin
  select 'this is my variable';
end$$
delimiter ;

call employees.get_my_var();

