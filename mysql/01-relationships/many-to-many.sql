
create database school;

create table school.student(
  id int not null auto_increment,
  first_name varchar(45) not null,
  last_name varchar(45) not null,
  primary key (id)
);

create table school.course(
  id int not null auto_increment,
  course_name varchar(45) not null,
  primary key (id)
);

-- in a many-to-many relationship, we need a third table to store the
-- relationship between the two tables
-- this table is called a junction table, or a linking table, or join table
create table school.student_course(
  id int not null auto_increment,
  student_id int not null,
  course_id int not null,
  primary key (id),
  foreign key (student_id) references school.student(id),
  foreign key (course_id) references school.course(id)
);

insert into school.student
(first_name, last_name)
  values
('Jim', 'Carrey'),
('Bob', 'Saget');

select * from school.student;

insert into school.course
(course_name)
  values
('Math'),
('Science'),
('English');

select * from school.course;


insert into school.student_course
(student_id, course_id)
  values
(1, 1);


insert into school.student_course
(student_id, course_id)
  values
(1, 2);

insert into school.student_course
(student_id, course_id)
  values
(2, 1);

select * from school.student_course;

-- many-to-many relationship: one student can have many courses
-- one course can have many students
