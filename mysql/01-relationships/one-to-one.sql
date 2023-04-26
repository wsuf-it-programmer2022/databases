

-- relationships: one-to-one
-- true one to one relationships do not exist in the real world

-- this is: zero or one to one relationship

create table hbo.users(
  id int not null auto_increment,
  user_name varchar(45) not null,
  primary key (id)
);

create table hbo.accounts(
  id int not null auto_increment,
  user_id int not null unique,
  account_name varchar(45) not null,
  primary key (id),
  foreign key (user_id) references hbo.users(id)
);

insert into hbo.users
(user_name)
  values
('Jim'),
('Bob');

select * from hbo.users;


insert into hbo.accounts
(user_id, account_name)
  values
(2, 'Bob Account');

select * from hbo.accounts;

