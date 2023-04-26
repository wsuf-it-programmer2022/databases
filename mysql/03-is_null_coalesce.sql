

create table if not exists hbo.workers (
    id int not null auto_increment,
    name varchar(45) not null,
    manager varchar(45),
    primary key (id)
); 

-- add top manager column to the workers table
alter table hbo.workers
add column top_manager varchar(45);


show tables from hbo;

insert into hbo.workers
(name, manager)
  values
('Jim', 'Bob'),
('Bob', null),
('Sally', 'Jim'),
('Sue', null),
('Sue', 'Sally');

select * from hbo.workers;

select name, ifnull(manager, 'No Manager') as manager
from hbo.workers;

-- add top manager to jim and bob
update hbo.workers
set top_manager = 'Jack'
where name in ('Jim', 'Bob');


-- coalesce example
select name, coalesce(manager, top_manager, 'No Manager') as manager from hbo.workers;
-- coalesce works even with one argument
select name, coalesce('No Manager') as manager from hbo.workers;
