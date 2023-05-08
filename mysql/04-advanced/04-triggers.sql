-- mysql trigger is a stored program that is executed automatically to respond to a specific event e.g insert, update or delete


use employees;
delimiter $$

create trigger before_insert_salaries
before insert on salaries
for each row
  begin
    -- new is a reference to the new row that is about to be inserted
    if new.salary < 0 then
      set new.salary = 0;
    end if;
  end$$

delimiter ;

-- show the trigger:
show triggers from employees;

select * from employees.salaries
where emp_no = 10001;

insert into employees.salaries values ('10001', -2134234, '2111-01-01', '2111-01-01');

-- this would still work, it would change all the salaries to -2134234;
update employees.salaries set salary = -2134234 where emp_no = 10001;

-- let's create a trigger which will run for every update on salaries table

delimiter $$
create trigger employees.trig_update_salaries
before update on employees.salaries
for each row
begin
  if new.salary < 0 then
    -- old is a reference to the old row that is about to be updated
    set new.salary = old.salary;
  end if;
end$$

delimiter ;

update employees.salaries set salary = -2134234 where emp_no = 10001 and from_date = '2002-06-22';

select * from employees.salaries
where emp_no = 10001;


select sysdate();
select date_format(sysdate(), '%y-%m-%d');

-- the following trigger will automatically increase the salary of a person by $ 20 000 
-- who was just promoted to a manager position, and it will also set the from_date to the current date

drop trigger if exists employees.trig_update_salaries;
delimiter $$
create trigger employees.trig_update_salaries
after insert on employees.dept_manager
for each row
begin
  declare v_current_salary int;

  select max(salary) into v_current_salary from employees.salaries where emp_no = new.emp_no;
  if v_current_salary is not null then
    insert into employees.salaries
    values (new.emp_no, v_current_salary + 20000, new.from_date, new.to_date);

    update employees.salaries
    set to_date = sysdate()
    where emp_no = new.emp_no and to_date = new.to_date;
  end if;

end$$
delimiter ;


insert into employees.dept_manager values (111534, 'd008', '2001-01-01', '9999-01-01');

select * from employees.salaries
where emp_no = 111534;
select * from employees.dept_manager
where emp_no = 111534;


  
