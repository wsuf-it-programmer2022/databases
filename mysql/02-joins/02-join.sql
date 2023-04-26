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
