-- UNIVERSITY INSIGHTS : A DATA- DRIVEN ANALYSIS 

create database university;
use university;

create table classroom (
building	 varchar(15),
room_number	 varchar(7) primary key,
 capacity	 numeric(4,0)
);

create table department(
dept_name		varchar(20),
building		varchar(15),
budget           numeric(12,2) check (budget > 0),
primary key (dept_name)
);

create table course (
course_id		varchar(8),
title			varchar(50),
dept_name		varchar(20),
credits		numeric(2,0) check (credits > 0),
primary key (course_id),
foreign key (dept_name) references department (dept_name)
on delete set null
);

create table instructor (
ID			varchar(5),
name			varchar(20) not null,
dept_name		varchar(20),
salary		numeric(8,2) check (salary > 29000),
primary key (ID),
foreign key (dept_name) references department (dept_name)
on delete set null
);

create table time_slot (
id               int primary key,
time_slot_id     	varchar(4),
day		      varchar(1),
start_hr	      numeric(2) check (start_hr >= 0 and start_hr < 24),
start_min		numeric(2) check (start_min >= 0 and start_min < 60),
end_hr		numeric(2) check (end_hr >= 0 and end_hr < 24),
end_min		numeric(2) check (end_min >= 0 and end_min < 60)
);

create table section (
course_id		varchar(8), 
sec_id		varchar(8),
semester		varchar(6) check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
year			numeric(4,0) check (year > 1701 and year < 2100), building		varchar(15),
room_number		varchar(7),
time_slot_id	varchar(4),
id                 int,
primary key (course_id, sec_id, semester, year),
foreign key (course_id) references course (course_id)on delete cascade,
foreign key (room_number) references classroom (room_number)
on delete set null,
foreign key (id) references time_slot (id)
on delete set null
);
    
create table teaches (
ID			varchar(5),
course_id		varchar(8),
sec_id		varchar(8),
semester		varchar(6),
year			numeric(4,0),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
on delete cascade,
foreign key (ID) references instructor (ID)
on delete cascade
);

create table student (
ID			varchar(5),
name			varchar(20) not null,
dept_name		varchar(20),
tot_cred		numeric(3,0) check (tot_cred >= 0),
primary key (ID),
foreign key (dept_name) references department (dept_name)
on delete set null
);

create table takes (
ID			varchar(5),
course_id		varchar(8),
sec_id		varchar(8),
semester		varchar(6),
year			numeric(4,0),
grade		      varchar(2),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
on delete cascade,
foreign key (ID) references student (ID)
on delete cascade
);

create table advisor (
s_ID			varchar(5),
i_ID			varchar(5),
primary key (s_ID),
foreign key (i_ID) references instructor (ID)
on delete set null,
foreign key (s_ID) references student (ID)
on delete cascade
);

create table prereq (
course_id		varchar(8),
prereq_id		varchar(8),
primary key (course_id, prereq_id),
foreign key (course_id) references course (course_id)
on delete cascade,
foreign key (prereq_id) references course (course_id)
);

insert into classroom values ('Packard', '101', '500');
insert into classroom values ('Painter', '514', '10');
insert into classroom values ('Taylor', '3128', '70');
insert into classroom values ('Watson', '100', '30');
insert into classroom values ('Watson', '120', '50');
insert into classroom values ('Taylor', '112', '30');
insert into classroom values ('Painter', '234', '50');
insert into classroom values ('Packard', '303', '56');


insert into department values ('Biology', 'Watson', '90000');
insert into department values ('Comp. Sci.', 'Taylor', '100000');
insert into department values ('Elec. Eng.', 'Taylor', '85000');
insert into department values ('Finance', 'Painter', '120000');
insert into department values ('History', 'Painter', '50000');
insert into department values ('Music', 'Packard', '80000');
insert into department values ('Physics', 'Watson', '70000');

insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', '4');
insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');
insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into course values ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
insert into course values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
insert into course values ('FIN-201', 'Investment Banking', 'Finance', '3');
insert into course values ('HIS-351', 'World History', 'History', '3');
insert into course values ('MU-199', 'Music Video Production', 'Music', '3');
insert into course values ('PHY-101', 'Physical Principles', 'Physics', '4');


insert into instructor values ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
insert into instructor values ('12121', 'Wu', 'Finance', '90000');
insert into instructor values ('15151', 'Mozart', 'Music', '40000');
insert into instructor values ('22222', 'Einstein', 'Physics', '95000');
insert into instructor values ('32343', 'El Said', 'History', '60000');
insert into instructor values ('33456', 'Gold', 'Physics', '87000');
insert into instructor values ('45565', 'Katz', 'Comp. Sci.', '75000');
insert into instructor values ('58583', 'Califieri', 'History', '62000');
insert into instructor values ('76543', 'Singh', 'Finance', '80000');
insert into instructor values ('76766', 'Crick', 'Biology', '72000');
insert into instructor values ('83821', 'Brandt', 'Comp. Sci.', '92000');
insert into instructor values ('98345', 'Kim', 'Elec. Eng.', '80000');


insert into time_slot values (1,'A', 'M', '8', '0', '8', '50');
insert into time_slot values (2,'A', 'W', '8', '0', '8', '50');
insert into time_slot values (3,'A', 'F', '8', '0', '8', '50');
insert into time_slot values (4,'B', 'M', '9', '0', '9', '50');
insert into time_slot values (5,'B', 'W', '9', '0', '9', '50');
insert into time_slot values (6,'B', 'F', '9', '0', '9', '50');
insert into time_slot values (7,'C', 'M', '11', '0', '11', '50');
insert into time_slot values (8,'C', 'W', '11', '0', '11', '50');
insert into time_slot values (9,'C', 'F', '11', '0', '11', '50');
insert into time_slot values (10,'D', 'M', '13', '0', '13', '50');
insert into time_slot values (11,'D', 'W', '13', '0', '13', '50');
insert into time_slot values (12,'D', 'F', '13', '0', '13', '50');
insert into time_slot values (13,'E', 'T', '10', '30', '11', '45 ');
insert into time_slot values (14,'E', 'R', '10', '30', '11', '45 ');
insert into time_slot values (15,'F', 'T', '14', '30', '15', '45 ');
insert into time_slot values (16,'F', 'R', '14', '30', '15', '45 ');
insert into time_slot values (17,'G', 'M', '16', '0', '16', '50');
insert into time_slot values (18,'G', 'W', '16', '0', '16', '50');
insert into time_slot values (19,'G', 'F', '16', '0', '16', '50');
insert into time_slot values (20,'H', 'W', '10', '0', '12', '30');

insert into section values ('BIO-101', '1', 'Summer', '2017', 'Painter', '514', 'B',1);
insert into section values ('BIO-301', '1', 'Summer', '2018', 'Painter', '514', 'A',2);
insert into section values ('CS-101', '1', 'Fall', '2017', 'Packard', '101', 'H',3);
insert into section values ('CS-101', '1', 'Spring', '2018', 'Packard', '101', 'F',4);
insert into section values ('CS-190', '1', 'Spring', '2017', 'Taylor', '3128', 'E',5);
insert into section values ('CS-190', '2', 'Spring', '2017', 'Taylor', '3128', 'A',6);
insert into section values ('CS-315', '1', 'Spring', '2018', 'Watson', '120', 'D',7);
insert into section values ('CS-319', '1', 'Spring', '2018', 'Watson', '100', 'B',8);
insert into section values ('CS-319', '2', 'Spring', '2018', 'Taylor', '3128', 'C',9);
insert into section values ('CS-347', '1', 'Fall', '2017', 'Taylor', '3128', 'A',10);
insert into section values ('EE-181', '1', 'Spring', '2017', 'Taylor', '3128', 'C',11);
insert into section values ('FIN-201', '1', 'Spring', '2018', 'Packard', '101', 'B',12);
insert into section values ('HIS-351', '1', 'Spring', '2018', 'Painter', '514', 'C',13);
insert into section values ('MU-199', '1', 'Spring', '2018', 'Packard', '101', 'D',14);
insert into section values ('PHY-101', '1', 'Fall', '2017', 'Watson', '100', 'A',15);


insert into teaches values ('10101', 'CS-101', '1', 'Fall', '2017');
insert into teaches values ('10101', 'CS-315', '1', 'Spring', '2018');
insert into teaches values ('10101', 'CS-347', '1', 'Fall', '2017');
insert into teaches values ('12121', 'FIN-201', '1', 'Spring', '2018');
insert into teaches values ('15151', 'MU-199', '1', 'Spring', '2018');
insert into teaches values ('22222', 'PHY-101', '1', 'Fall', '2017');
insert into teaches values ('32343', 'HIS-351', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-101', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-319', '1', 'Spring', '2018');
insert into teaches values ('76766', 'BIO-101', '1', 'Summer', '2017');
insert into teaches values ('76766', 'BIO-301', '1', 'Summer', '2018');
insert into teaches values ('83821', 'CS-190', '1', 'Spring', '2017');
insert into teaches values ('83821', 'CS-190', '2', 'Spring', '2017');
insert into teaches values ('83821', 'CS-319', '2', 'Spring', '2018');
insert into teaches values ('98345', 'EE-181', '1', 'Spring', '2017');

insert into student values ('00128', 'Zhang', 'Comp. Sci.', '102');
insert into student values ('12345', 'Shankar', 'Comp. Sci.', '32');
insert into student values ('19991', 'Brandt', 'History', '80');
insert into student values ('23121', 'Chavez', 'Finance', '110');
insert into student values ('44553', 'Peltier', 'Physics', '56');
insert into student values ('45678', 'Levy', 'Physics', '46');
insert into student values ('54321', 'Williams', 'Comp. Sci.', '54');
insert into student values ('55739', 'Sanchez', 'Music', '38');
insert into student values ('70557', 'Snow', 'Physics', '0');
insert into student values ('76543', 'Brown', 'Comp. Sci.', '58');
insert into student values ('76653', 'Aoi', 'Elec. Eng.', '60');
insert into student values ('98765', 'Bourikas', 'Elec. Eng.', '98');
insert into student values ('98988', 'Tanaka', 'Biology', '120');


insert into takes values ('00128', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('00128', 'CS-347', '1', 'Fall', '2017', 'A-');
insert into takes values ('12345', 'CS-101', '1', 'Fall', '2017', 'C');
insert into takes values ('12345', 'CS-190', '2', 'Spring', '2017', 'A');
insert into takes values ('12345', 'CS-315', '1', 'Spring', '2018', 'A');
insert into takes values ('12345', 'CS-347', '1', 'Fall', '2017', 'A');
insert into takes values ('19991', 'HIS-351', '1', 'Spring', '2018', 'B');
insert into takes values ('23121', 'FIN-201', '1', 'Spring', '2018', 'C+');
insert into takes values ('44553', 'PHY-101', '1', 'Fall', '2017', 'B-');
insert into takes values ('45678', 'CS-101', '1', 'Fall', '2017', 'F');
insert into takes values ('45678', 'CS-101', '1', 'Spring', '2018', 'B+');
insert into takes values ('45678', 'CS-319', '1', 'Spring', '2018', 'B');
insert into takes values ('54321', 'CS-101', '1', 'Fall', '2017', 'A-');
insert into takes values ('54321', 'CS-190', '2', 'Spring', '2017', 'B+');
insert into takes values ('55739', 'MU-199', '1', 'Spring', '2018', 'A-');
insert into takes values ('76543', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('76543', 'CS-319', '2', 'Spring', '2018', 'A');
insert into takes values ('76653', 'EE-181', '1', 'Spring', '2017', 'C');
insert into takes values ('98765', 'CS-101', '1', 'Fall', '2017', 'C-');
insert into takes values ('98765', 'CS-315', '1', 'Spring', '2018', 'B');
insert into takes values ('98988', 'BIO-101', '1', 'Summer', '2017', 'A');
insert into takes values ('98988', 'BIO-301', '1', 'Summer', '2018', null);

insert into advisor values ('00128', '45565');
insert into advisor values ('12345', '10101');
insert into advisor values ('23121', '76543');
insert into advisor values ('44553', '22222');
insert into advisor values ('45678', '22222');
insert into advisor values ('76543', '45565');
insert into advisor values ('76653', '98345');
insert into advisor values ('98765', '98345');
insert into advisor values ('98988', '76766');

insert into prereq values ('BIO-301', 'BIO-101');
insert into prereq values ('BIO-399', 'BIO-101');
insert into prereq values ('CS-190', 'CS-101');
insert into prereq values ('CS-315', 'CS-101');
insert into prereq values ('CS-319', 'CS-101');
insert into prereq values ('CS-347', 'CS-101');
insert into prereq values ('EE-181', 'PHY-101');

-- SAMPLE QUESTIONS--
-----------------------

#1. Display average salary given by each department.

select dept_name, round(avg(salary),2) 'average salary' from instructor group by dept_name;


#2. Display the name of students and their corresponding course IDs.

select student.name, course.course_id from student, course where student.dept_name = course.dept_name;
OR,
select student.name, course.course_id from student inner join course on student.dept_name = course.dept_name;


#3. Display number of courses taken by each student. 

select student.name, count(takes.course_id) ' number of courses' from student inner join 
takes on student.id = takes.id group by student.name order by student.name;


#4. Get the prerequisites courses for courses in the Spring semester.

select takes.semester, prereq.course_id, prereq.prereq_id from takes, prereq where takes.course_id = prereq.course_id 
and semester = 'spring';


#5. Display the instructor name who teaches student with highest 5 credits.

select instructor.name as 'Instructor\s name'  from instructor inner join student
on instructor.dept_name = student.dept_name 
order by student.tot_cred desc limit 5;


#6. Which semester and department offers maximum number of courses.

select semester, dept_name, max(coun) 'max' from (select section.semester, course.dept_name, 
count(course.course_id) 'coun' from section join course on course.course_id = section.course_id 
group by semester, dept_name) as b  group by semester, dept_name order by max desc limit 1;

or,

select section.semester, course.dept_name, count(course.course_id) 'coun' from section join course 
on course.course_id = section.course_id group by semester, dept_name order by count(course.course_id) desc limit 1;


#7. Display course and department whose time starts at 8.

select section.course_id, course.dept_name from section join course on course.course_id = section.course_id join 
time_slot on section.time_slot_id = time_slot.time_slot_id where time_slot.start_hr = 8 
group by section.course_id, course.dept_name;


#8. Display the salary of instructors from Watson building.

select instructor.name, instructor.salary, department.dept_name from instructor join department 
on instructor.dept_name = department.dept_name where department.building = 'watson';

or,

select name, salary, dept_name from instructor where dept_name in 
(select dept_name from department where building = 'watson');


#9. Show the title of courses available on Monday.

select course.title from course, time_slot, section 
where section.time_slot_id = time_slot.time_slot_id and course.course_id = section.course_id and time_slot.day = 'm';

or,

select course.title from course join section on course.course_id = section.course_id join time_slot on 
time_slot.time_slot_id  = section.time_slot_id
where section.time_slot_id = time_slot.time_slot_id and course.course_id = section.course_id and time_slot.day = 'm';


#10. Find the number of courses that start at 8 and end at 8.

select count(section.course_id) as ' number of courses' from section, time_slot 
where section.time_slot_id = time_slot.time_slot_id and time_slot.start_hr = 8 and time_slot.end_hr = 8;


#11. Find instructors having salary more than 90000

select name from instructor where salary > 90000;


#12. Find student records taking courses before 2018.

select * from takes where year < 2018;


#13. Find student records taking courses in the fall semester and coming under first section.

select * from takes where semester = 'fall' and sec_id = 1;


#14. Find student records taking courses in the summer semester, coming under first section in the year 2017.

select * from takes where semester = 'summer' and sec_id = 1 and year = 2017;


#15. Find student records taking courses in the fall semester and having A grade.

select * from takes where semester = 'fall' and grade = 'a';


#16. Find student records taking courses in the summer semester and having A grade.

select * from takes where semester = 'summer' and grade = 'a';


#17  Display section details with B time slot, room number 514 and in the Painter building.

select * from section where time_slot_id = 'b' and room_number = 514 and building = 'painter';


#18  Find all course titles which have a string "Intro.".

select title from course where title like 'intro%';


#19  Find the titles of courses in the Computer Science department that have 3 credits.

select title from course where  course.dept_name ='comp. sci.' and course.credits = 3;


#20. Find IDs and titles of all the courses which were taught by an instructor named Einstein. Make sure there are no duplicates in the result.

select course.course_id, course.title from course, instructor where course.dept_name = instructor.dept_name 
and instructor.name = 'einstein';


#21  Find all course IDs which start with CS

select course_id from course where course_id like 'cs%';


#22. For each department, find the maximum salary of instructors in that department

select dept_name, max(salary) as ' maximum salary' from instructor group by dept_name;


#23.  Find the enrollment (number of students) of each section that was offered in Fall 2017.

select sec_id,  count(id) 'number of students', semester, year from takes where semester = 'fall' and year ='2017'group by sec_id, semester, year;


#24. Increase(update) the salary of each instructor by 10% if their current salary is between 0 and 90000.

update instructor set salary = salary*1.1 where salary between 0 and 90000;


#25. Find the names of instructors from Biology department having salary more than 50000.

select name, salary from instructor where dept_name = 'biology' and salary > 5000;


#26. Find the IDs and titles of all courses taken by a student named Shankar.

select student.name, course.course_id, course.title from student, course 
where student.dept_name = course.dept_name and student.name = 'shankar';


#27. For each department, find the total credit hours of courses in that department.

select dept_name, sum(credits) as 'total credits' from course group by dept_name;


#28. Find the number of courses having A grade in each building.

select count(takes.course_id), takes.grade, section.building from takes, section 
where takes.course_id = section.course_id and takes.grade = 'a'
group by section.building;


#29. Display number of students in each department having total credits divisible by course credits.

select student.dept_name, count(student.id) as 'number of student' from student, course 
where course.dept_name = student.dept_name and student.tot_cred % course.credits = 0 group by student.dept_name;


#30. Display number of courses available in each building.

select building, count(course_id) from DEPARTMENT, COURSE 
where department.dept_name = course.dept_name group by building order by count(course_id);


#31. Find number of instructors in each department having 'a' and 'e' in their name.

select count(instructor.id) as 'number of instructors', instructor.dept_name from instructor 
where name like '%a%e%'group by dept_name;


#32. Display number of courses being taught in classroom having capacity more than 20.

select classroom.room_number, classroom.capacity, count(section.course_id) 'number of courses'
from section, classroom where section.room_number = classroom.room_number and classroom.capacity >20 
group by classroom.room_number, classroom.capacity order by room_number;


#33. Update the budget of each department by Rs. 1000

update department set budget = budget+1000;


#34. Find number of students in each room.

select room_number, count(takes.id) 'number of students' from section, takes 
where section.course_id = takes.course_id group by room_number;


#35. Give the prerequisite course for each student.

select student.name, prereq.prereq_id from student, prereq, takes where takes.id = student.id 
and prereq.course_id = takes.course_id;


#36. Display number of students attending classes on Wednesday.

select count(takes.id), time_slot.day from takes, time_slot, section where takes.course_id = section.course_id
and section.time_slot_id = time_slot.time_slot_id and time_slot.day ='w' group by time_slot.day;


#37. Display number of students and instructors in each department

select student.dept_name, count(student.id) 'number of students and instructors' from student 
group by student.dept_name 
union all
select instructor.dept_name, count(instructor.id) 'number of students and instructors' from instructor 
group by instructor.dept_name;


#38. Display number of students in each semester and their sum of credits.

select takes.semester, count(takes.id), sum(student.tot_cred) from takes, student 
where takes.id = student.id group by takes.semester;


#39. Give number of instructors in each building.

select count(instructor.id) 'number ofinstructor', section.building from instructor, section, teaches
where instructor.id = teaches.id and section.course_id =teaches.course_id group by section.building;


#40. Display advisor IDs for instructors in Painter building.

select advisor.s_id, instructor.name, section.building from advisor, instructor, section, teaches
where advisor.i_id = instructor.id and instructor.id = teaches.id and teaches.course_id = section.course_id 
and section.building = 'painter';


#41. Find total credits earned by students coming at 9am

select student.name, start_hr, tot_cred from student, takes, section, time_slot
where student.id = takes.id and takes.course_id = section.course_id and section.time_slot_id = time_slot.time_slot_id 
and start_hr = '9';


#42. Display student names ordered by room number

select student.name, section.room_number from student, section, takes where student.id = takes.id 
and takes.course_id = section.course_id order by room_number;


#43. Find the number of capacity left after occupying all the students.

select classroom.room_number, classroom.capacity - count(takes.id) as 'remaining capacity' from classroom, takes, section 
where classroom.room_number = section.room_number and takes.course_id = section.course_id group by room_number;


#44. Find the duration for which each student has to attend each lecture.

select student.name, takes.course_id, time_slot.end_hr - time_slot.start_hr 'duration', 
time_slot.end_min - time_slot.start_min 'duration in minutes' from student, takes, section, time_slot 
where student.id = takes.id and takes.course_id = section.course_id 
and section.time_slot_id = time_slot.time_slot_id group by student.name, 
takes.course_id, time_slot.end_hr, time_slot.start_hr, time_slot.end_min, 
time_slot.start_min order by student.name;


#45. Create a timetable for the university.

select time_slot.day, section.building, section.room_number, section.course_id from time_slot, section
where section .time_slot_id = time_slot.time_slot_id 
group by time_slot.day, section.building, section.room_number, section.course_id;


#46. Find the average salary that's distributed to teachers for each course and sort them in descending order

with teacher_course_data as (
select id, title from teaches join course on teaches.course_id = course.course_id)
select title as course_name, avg(salary) avg_salary from teacher_course_data  join instructor 
on teacher_course_data.id = instructor.id 
group by teacher_course_data.title order by avg(salary) desc;


#47. Find the average duration of classes for each course id

with time_slot_duration as
(select time_slot_id, (end_min -start_min) duration from time_slot)
select section.course_id, avg(duration) duration from section join time_slot_duration
on section.time_slot_id = time_slot_duration.time_slot_id
group by course_id;


#48 Get the name of the instructor with highest salary from each department.

select name, dept_name, max(salary) 'highest salary' from instructor group by name, dept_name;


#49. Perform division between student credits and department total credits

with dept_creds as (
select dept_name, sum(credits) as dept_total_creds  from course group by dept_name)
select student.name, student.tot_cred/dept_creds.dept_total_creds from student join dept_creds
on student.dept_name=dept_creds.dept_name;

































