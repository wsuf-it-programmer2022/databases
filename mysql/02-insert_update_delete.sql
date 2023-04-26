
create database if not exists hbo;

-- CRUD: Create, Read, Update, Delete

-- this is creating the table schema
create table if not exists hbo.actor (
    actor_id int not null auto_increment,
    first_name varchar(45) not null,
    last_name varchar(45) not null,
    last_update timestamp not null default current_timestamp on update current_timestamp,
    primary key (actor_id)
);


-- Create data
insert into hbo.actor
(first_name, last_name)
values ('Jim', 'Carrey');

-- Read data
select * from hbo.actor;

select * from hbo.actor
where actor_id = 1;

-- Update data
update hbo.actor
set first_name = 'James'
where actor_id = 1;

update hbo.actor
set first_name = 'James'
where like 'J%';

delete from hbo.actor
where actor_id = 1;

delete from hbo.actor
where actor_id in (2,3,4);
