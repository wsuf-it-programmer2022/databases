show databases;

create database my_first_database;

create table my_first_database.users (
    id int(11) not null auto_increment primary key,
    firstname varchar(255) not null,
    lastname varchar(255),
    email varchar(255) not null 
);

-- alter the users table, and set the email column to be unique
alter table my_first_database.users
modify email varchar(255) not null unique;

show tables from my_first_database;

describe my_first_database.users;

insert into my_first_database.users
(firstname, email)
values
('John', 'john@john.com');S

-- this will fail because the email column cannot be null
insert into my_first_database.users
(name )
values
('John');

select * from my_first_database.users;


insert into my_first_database.users
(firstname, email)
values
('Jane', 'Jane@jane.com'),
('Jack', 'jack@jack.com'),
('Jill', 'jill@jill.com');  


-- empty the users table
truncate table my_first_database.users;


-- delete the users table
drop table my_first_database.users;

select firstname,email from my_first_database.users;

select firstname,email from my_first_database.users
where firstname = 'John';

-- everything that starts with J
select * from my_first_database.users
where firstname like 'J%';

-- order by name
select * from my_first_database.users
where firstname like 'J%'
order by firstname asc;

-- not cause an error but will return no results
select firstname from my_first_database.users
where 1 = 2;


select firstname as `The Name of the User`
from my_first_database.users;

create table if not exists my_first_database.movies (
    id int unsigned auto_increment primary key,
    duration int,
    title varchar(255)
);

insert into my_first_database.movies
(title, duration)
values
('The Matrix', 120),
('The Matrix Reloaded', 120),
('The Matrix Revolutions', 120),
('The Matrix 4', 120);

select * from my_first_database.movies;

select title, duration/60 as `Duration in Hours`
from my_first_database.movies;

-- casting means to convert the data type to another data type
select title, cast(duration/60 as int) as `Duration in Hours`
from my_first_database.movies;

-- unsigned means that the number cannot be negative
-- this will give us more space to store numbers
create table my_first_database.payment (
    id int unsigned auto_increment primary key,
    amount int,
    payment_date datetime
);

insert into my_first_database.payment
(amount, payment_date)
values
(100, '2019-01-01'),
(200, curdate()),
(300, now()),
(400, '2020-01-04 12:43:01');

select * from my_first_database.payment;

-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html
insert into my_first_database.payment
(amount, payment_date)
values
(100, str_to_date('January/01/2019', '%M/%d/%Y'));

-- universal timestamp
select unix_timestamp(payment_date) as `Payment Date` from my_first_database.payment;

select * from my_first_database.payment
where payment_date > '2019-01-01';

select * from my_first_database.payment
where payment_date between '2015-01-01' and now();

select * from my_first_database.payment
where payment_date between '2015-01-01' and '2019-01-01';

select payment_date,
  weekday(payment_date) as `Day of the Week`,
  quarter(payment_date) as `Quarter`,
  week(payment_date) as `Week`,
  monthname(payment_date) as `Month`
  from my_first_database.payment;


insert into my_first_database.users
(firstname, lastname, email)
values
('John', 'Doe', 'jon@hsd.com');

select concat(firstname, ' ', lastname) as `the person's name`
from my_first_database.users
where firstname = 'John' and lastname = 'Doe';

select concat(left(firstname, 1), left(lastname, 1)) as `the person's monogram`
from my_first_database.users
where firstname = 'John' and lastname = 'Doe';

-- distinct means that it will only return unique values
select distinct firstname,lastname from my_first_database.users;

-- we are counting the number of unique firstnames
select distinct count(firstname) from my_first_database.users;


-- select everery user where the firstname starts with J
select * from my_first_database.users
where firstname like 'J%';

-- the underscore means that we can have any character in that position (but only one)
-- the percent sign means that we can have any number of characters
select * from my_first_database.users
where firstname like 'J_h%';


-- limit the number of results
select * from my_first_database.users
limit 2;

-- skip the first two results and return the next one
select * from my_first_database.users
limit 2, 1;

-- skip the first two results and return the next four
select * from my_first_database.users
limit 2, 4;
