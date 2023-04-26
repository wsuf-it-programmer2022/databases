drop database school;
create database school;

create table school.students (
  StudentId int not null auto_increment,
  StudentName varchar(50) not null,
  primary key (StudentId)
);

create table school.classes (
  ClassId int not null auto_increment,
  ClassName varchar(50) not null,
  primary key (ClassId)
);

create table school.student_class (
  ClassId int not null,
  StudentId int not null,
  foreign key (ClassId) references school.classes(ClassId),
  foreign key (StudentId) references school.students(StudentId)
);

insert into school.students
(StudentName)
  values
('John'),
('Matt'),
('James'),
('Chris');

insert into school.classes
(ClassName)
  values
('Math'),
('Art'),
('History');

insert into school.student_class
(ClassId, StudentId)
  values
(1,1),
(1,2),
(3,1),
(3,2),
(3,3);

select * from school.students;
select * from school.classes;
select * from school.student_class;

-- 1. Which Student is attended to any course? We need the Name of the student
select StudentName from school.student_class
inner join school.students

