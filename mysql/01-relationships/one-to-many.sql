
-- one to many relationship is very similar to one-to-one except that the
-- foreign key is not unique in the child table

create table hbo.persons(
  id int not null auto_increment,
  user_name varchar(45) not null,
  primary key (id)
);

create table hbo.orders(
  id int not null auto_increment,
  person_id int not null,
  order_name varchar(45) not null,
  primary key (id),
  foreign key (person_id) references hbo.persons(id)
);

-- one person can have multiple orders

insert into hbo.persons
(user_name)
  values
('Jim'),
('Bob');

select * from hbo.persons;

insert into hbo.orders
(person_id, order_name)
  values
(1, 'Jim Order 1'),
(1, 'Jim Order 2'),
(2, 'Bob Order 1');

select * from hbo.orders;
