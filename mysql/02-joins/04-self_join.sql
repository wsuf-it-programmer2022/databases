
create table first_database.employee (
  EmployeeID int primary key,
  Name varchar(50),
  ManagerID int
);

insert into first_database.employee
(EmployeeID, Name, ManagerID)
values
(1, 'John', null),
(2, 'Mike', 1),
(3, 'Sally', 1),
(4, 'Adam', 2),
(5, 'Jane', 2),
(6, 'Joe', 3),
(7, 'Mary', 3),
(8, 'Jill', 3);

select * from first_database.employee;

-- self join: join a table with itself
select e1.Name as Employee, e2.Name as Manager
from first_database.employee e1
join first_database.employee e2
on e1.ManagerID = e2.EmployeeID;

-- self join: join a table with itself
select e1.Name as Employee, ifnull(e2.Name, "Top Manager") as Manager
from first_database.employee e1
left join first_database.employee e2
on e1.ManagerID = e2.EmployeeID;
