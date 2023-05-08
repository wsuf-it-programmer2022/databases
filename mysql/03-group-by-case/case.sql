
-- case
select emp_no, first_name, last_name,
 case
   when gender = 'M' then 'Male'
   else 'Female'
 end as gender
from employees.employees
limit 20;

-- with a different syntax
select emp_no, first_name, last_name,
 case gender
   when 'M' then 'Male'
   else 'Female'
 end as gender_full
from employees.employees
limit 20;


select emp_no, first_name, last_name,
max(salaries.salary) - min(salaries.salary) as salary_difference,
case
  when max(salaries.salary) - min(salaries.salary) > 30000 then 'Salary was raised by more than $30 000'
  when max(salaries.salary) - min(salaries.salary) between 20000 and 30000
    then 'Salary was raised by more than $20 000 but less then $30 000'
  else 
    'Salary was raised by less than $20 000'
  end as salary_increase
from employees.salaries
join employees.employees using(emp_no)
group by emp_no
limit 20;


-- Query the employees where the employee number is more than 109990
-- get the employees first_name, last_name, and create a forth column called "is_manager"
-- indicating if the employee is a manager or not, Use the data provided by the dept_manager table

select emp_no, first_name, last_name,
 case 
    when employees.dept_manager.emp_no is not null then 'Manager'
    else 'employee'
 end as is_manager
from employees.employees
left join employees.dept_manager using(emp_no)
where emp_no > 109990;

-- Extract the employee number, first_name, last_name of the first 100 employees
-- and add a forth column called "current_employee" saying "is still employed"
-- if the employee is still working in the company, otherwise say "not employed anymore"
-- Use the data provided by the dept_emp table

select employees.employees.emp_no,
       employees.employees.first_name,
       employees.employees.last_name,
       case
         when max(employees.dept_emp.to_date) > sysdate() then 'is still employed'
         else 'not employed anymore'
       end as current_employee
from employees.employees
join employees.dept_emp using(emp_no)
group by emp_no
limit 100;
