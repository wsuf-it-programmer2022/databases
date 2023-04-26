

-- Who has applied to math courses?
select first_name, last_name from school.student_course
join school.student
on school.student_course.student_id = school.student.id
join school.course
on school.student_course.course_id = school.course.id
where school.course.course_name = 'Math';



create table school.course_category(
  id int not null auto_increment,
  category_name varchar(45) not null,
  primary key (id)
);

insert into school.course_category
(category_name)
  values
('Science'),
('History');



-- add another column to the course table category_id
alter table school.course
add column category_id int;

-- update the course table with the category_id
update school.course
set category_id = 1
where course_name = 'Math';

update school.course
set category_id = 1
where course_name = 'Science';


select * from school.course;


-- Who has applied to math courses?
select first_name, last_name from school.student_course
join school.student
on school.student_course.student_id = school.student.id
join school.course
on school.student_course.course_id = school.course.id
where school.course.course_name = 'Math';



create table school.course_category(
  id int not null auto_increment,
  category_name varchar(45) not null,
  primary key (id)
);

insert into school.course_category
(category_name)
  values
('Science'),
('History');




-- Who has applied to math courses?
select first_name, last_name from school.student_course
join school.student
on school.student_course.student_id = school.student.id
join school.course
on school.student_course.course_id = school.course.id
where school.course.course_name = 'Math';



create table school.course_category(
  id int not null auto_increment,
  category_name varchar(45) not null,
  primary key (id)
);

insert into school.course_category
(category_name)
  values
('Science'),
('History');

select * from school.course_category;
select * from school.course;

-- select the category name from the course table
select category_name, course_name from school.course
join school.course_category
on school.course.category_id = school.course_category.id;

-- Which category does not have any courses?
select category_name from school.course_category
left join school.course
on school.course.category_id = school.course_category.id
where school.course.category_id is null;
