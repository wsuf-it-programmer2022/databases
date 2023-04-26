

set foreign_key_checks = 0;
drop table if exists hbo.accounts;
drop table if exists hbo.users;
-- relationships: one-to-one
-- true one to one relationships do not exist in the real world

-- disable foreign key checks
set foreign_key_checks = 0;

create table hbo.users(
  id int not null auto_increment,
  user_name varchar(45) not null,
  account_id int not null,
  primary key (id),
  foreign key (account_id) references hbo.accounts(id)
);

create table hbo.accounts(
  id int not null auto_increment,
  user_id int not null,
  account_name varchar(45) not null,
  primary key (id),
  foreign key (user_id) references hbo.users(id)
);

set foreign_key_checks = 0;
insert into hbo.users
(user_name, account_id)
  values
('Jim', 2),
('Bob', 1);

select * from hbo.users;


set foreign_key_checks = 0;
insert into hbo.accounts
(user_id, account_name)
  values
(1, 'Jim Account'),
(2, 'Bob Account');

select * from hbo.accounts;
