

-- how much is the avarage salary of all employees?
select avg(employees.salaries.salary) as avg_salary
from employees.employees
join employees.salaries using(emp_no);

-- how much is the avarage salary of male and female employees?
select employees.gender, avg(employees.salaries.salary) as avg_salary
from employees.employees
join employees.salaries using(emp_no)
group by gender;

-- the group by clause always needs an aggregate function: like avg, sum, count, min, max
-- if you don't provide the aggregate function, it will just select the first result for each group
select employees.gender, employees.salaries.salary as avg_salary
from employees.employees
join employees.salaries using(emp_no)
group by gender;



-- it's not recommended to add more columns, as it will select the first result for each group
select emp_no, employees.gender, avg(employees.salaries.salary) as avg_salary
from employees.employees
join employees.salaries using(emp_no)
group by gender;
