create database project
on primary
(
	name= 'DF1',
	filename='C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\DF1.mdf',
	size=10MB,
	filegrowth=20MB,
	Maxsize=unlimited
),
filegroup Secondary
(
	name= 'DF2',
	filename='C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\DF2.ndf',
	size=10MB,
	filegrowth=20MB,
	Maxsize=unlimited
),

(
	name= 'DF3',
	filename='C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\DF3.ndf',
	size=10MB,
	filegrowth=20MB,
	Maxsize=unlimited
)
Log on
(
	name= 'LF',
	filename='C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\LF.ldf',
	size=10MB,
	filegrowth=20MB,
	Maxsize=unlimited
)



--********************************************************

create table system
( 
  serial nvarchar(11) primary key not null 
  
)on Secondary

create table Question
(
id int primary key identity(1,1) not null,
ture_and_false bit not null,
text nvarchar(100) not null ,
code_Question int not null ,
serial_system nvarchar(11) not null,

constraint system_Question_fk foreign key(serial_system) references  [dbo].[system](serial)

)


create table correct_answer
(
id int primary key identity(1,1),
courses nvarchar(50),
course_id int,
course_name nvarchar(50),
max_degree int ,
min_degree int ,
serial_system nvarchar(11) not null,

constraint correct_answer_system_fk foreign key(serial_system) references  [dbo].[system](serial)

)

create table course
(
[name] nvarchar(50) not null,
id int primary key not null,
min_degree int ,
max_degress int ,

serial_system nvarchar(11) not null,

constraint course_system_fk foreign key(serial_system) references  [dbo].[system](serial)

)

create table training_manger
(
name nvarchar(20) not null,
id int primary key identity(1,1)
)

create table instractor_account
(
name nvarchar(20) not null,
age int ,
gender nvarchar(11),
id int primary key identity(1,1),
email nvarchar(50),
id_manger int

constraint instractor_account_training_manger_fk foreign key(id_manger) references  [dbo].[training_manger](id)

)


create table class
(
name nvarchar(20) primary key
) 

create table student_Account
(
name nvarchar(20),
gender nvarchar(20),
age int ,
serial_num nvarchar(11) primary key,
email nvarchar(50),
password nvarchar(20),
id_manger int,
class_name nvarchar(20) ,
code_branch int,

constraint student_Account_training_manger_fk foreign key(id_manger) references  [dbo].[training_manger](id),

constraint student_Account_class_fk foreign key(class_name) references  [dbo].[class](name),

constraint student_Account_branch_fk foreign key(code_branch) references  [dbo].[brance](code)


)

create table brance
(
code int primary key identity(1,1),
name nvarchar(20)
)


create table track
(
name nvarchar(20) ,
id int primary key identity(1,1),
class_name nvarchar(20)

constraint track_class_name_fk foreign key(class_name) references  [dbo].[class](name),

)

create table department
(
name nvarchar(50) not null,
id int primary key identity(1,1),
id_manger int,

constraint department_manger_fk foreign key(id_manger) references  [dbo].[training_manger](id),


)

create table intake
(
name nvarchar(50) not null,
[year] int primary key identity(1,1),
num int not null,
id_manger int,


constraint intake_manger_fk foreign key(id_manger) references  [dbo].[training_manger](id),


)


create table exam
(
total_degree int not null,
normal_exam nvarchar(50),
correction_exam nvarchar(50),
code_exam nvarchar(20) primary key ,
id_instractor int not null,
id_course int not null,

constraint exam_instractor_fk foreign key(id_instractor) references  [dbo].[instractor_account](id),
constraint exam_course_fk foreign key(id_course) references  [dbo].[course](id),


)




create table system_course
(
serial_system nvarchar(11) not null ,
[id_course] int not null , 

constraint student_course_PK primary key([serial_system],[id_course]),

constraint system_course_serial_system_fk foreign key (serial_system) references [dbo].[system](serial), 
constraint system_course_system_fk foreign key (id_course) references [dbo].[course](id)


)

create table course_branche
(

id_course int  not null,
code_brance int not null  ,

constraint course_branche_PK primary key([code_brance],[id_course]),

constraint course_branche_code_brance_fk foreign key (code_brance) references [dbo].[brance](code), 
constraint course_branche_id_course_fk foreign key (id_course) references [dbo].[course](id)


)

create table branche_intake
(
code_brance int   ,
[year_intake] int  , 

constraint branche_intake_PK primary key([code_brance],[year_intake]),

constraint branche_intake_code_brance_fk foreign key (code_brance) references [dbo].[brance](code), 
constraint branche_intake_year_intake_fk foreign key (year_intake) references [dbo].[intake]([year])


)


create table course_exam
(
code_exam nvarchar(20)  ,
id_course int  not null ,

constraint course_exam_PK primary key([id_course],[code_exam]),

constraint course_exam_code_exam_fk foreign key (code_exam) references [dbo].[exam](code_exam), 
constraint course_exam_id_course_fk foreign key (id_course) references [dbo].[course]([id])


)

create table system_exam
(
code_exam nvarchar(20)  ,
serial_system nvarchar(11)  not null  ,

constraint system_exam_PK primary key([serial_system],[code_exam]),

constraint system_exam_code_exam_fk foreign key (code_exam) references [dbo].[exam](code_exam), 
constraint system_exam_serial_system_fk foreign key (serial_system) references [dbo].[system]([serial])


)

create table Question_exam
(
code_exam nvarchar(20)  ,
id_question int  not null,

constraint Question_exam_PK primary key([id_question],[code_exam]),

constraint Question_exam_code_exam_fk foreign key (code_exam) references [dbo].[exam](code_exam), 
constraint Question_exam_id_question_fk foreign key (id_question) references [dbo].[Question]([id])


)


create table instractor_class
(
id_instractor int ,  
name_class nvarchar(20) ,

constraint instractor_class_PK primary key([id_instractor],[name_class]),

constraint instractor_class_id_instractor_fk foreign key (id_instractor) references [dbo].[instractor_account](id), 
constraint instractor_class_name_class_fk foreign key (name_class) references [dbo].[class]([name])


)


create table instractor_course
(
id_instractor int ,  
id_course int  not null ,

constraint instractor_course_PK primary key([id_instractor],[id_course]),

constraint instractor_course_id_instractor_fk foreign key (id_instractor) references [dbo].[instractor_account](id), 
constraint instractor_course_id_course_fk foreign key (id_course) references [dbo].[course]([id])


)

create table instractor_Question
(
id_instractor int ,  
id_question int  not null ,

constraint instractor_Question_PK primary key([id_instractor],[id_question]),

constraint instractor_Question_id_instractor_fk foreign key (id_instractor) references [dbo].[instractor_account](id), 
constraint instractor_Question_id_question_fk foreign key (id_question) references [dbo].[Question]([id])


)

create table course_class
(
name_class nvarchar(20)  ,  
id_coures int  not null ,



constraint course_class_instractor_PK primary key([name_class],[id_coures]),

 
constraint course_class_instractor_id_coures_fk foreign key (id_coures) references [dbo].[course]([id]),
constraint course_class_instractor_name_class_fk foreign key (name_class) references [dbo].[class]([name])

)

create table [student_answer]
(
Question_id int identity(1,1) ,
student_answer nvarchar(max),
serial_num_student nvarchar(11) primary key,

serial_system nvarchar(11) ,

--constraint student_answer_PK primary key(Question_id,serial_num_student),


constraint student_answer_student_account_fk foreign key (serial_num_student) references [dbo].[student_Account](serial_num),

constraint student_answer_system_fk foreign key (serial_system) references [dbo].[system](serial) 

)

create table result
(
question_id int not null primary key,

serial_student nvarchar(11),

serial_system nvarchar(11),

constraint result_serial_system_fk foreign key (serial_system) references [dbo].[system](serial), 
constraint result_question_id_student_answer_fk foreign key(serial_student) references  [dbo].[student_answer](serial_num_student)

)

 ALTER TABLE [Question_exam]
alter column [ture_and_false] nvarchar(50)

 ALTER TABLE [dbo].[course]
add [ description] nvarchar(100)

 ALTER TABLE [dbo].[student_Account]
add [ student_Cousre] int


 ALTER TABLE [dbo].[student_Account]
 add constraint student_corse foreign key([ student_Cousre]) references  [dbo].[course]([id])
---------------------------------------------------------------------------------
--INSERT INTO table_name(column1,column2…)
--VALUES (value1,value2,…),
--       (value1,value2,…),




insert into exam
values (100,'.Net','.Netcrr','501',1,11)


insert into instractor_account
values ('Ahmed',30,'M','enganyeng@gmail.com',1)


insert into brance(name)
values ('Minya'),('cairo')



insert into class(name)
values ('A1'),('A2'),('A3'),('B1'),('B2'),('B3'),('C1'),('C2')


insert into correct_answer(courses,course_id,course_name,max_degree,min_degree,serial_system)
values ('.Net,Angular,Mean',501,'.Net',10,50,516),
('.Net,Angular,Mean',501,'.Net',10,50,516),
('.Net,Angular,Mean',501,'.Net',10,50,516);



insert into course(id,name,max_degress,min_degree,serial_system)
values (011,'.Net',100,50,516),
(021,'Angular',100,50,516),
(111,'Mean',100,50,516);

insert into intake
values ('.net',1,2020)

insert into branche_intake([code_brance],year_intake)
values (1,2)




insert into course_branche(id_course,code_brance)
values (11,1);

insert into training_manger(name)
values ('Ahmed') ,('eslam')

insert into system_course(serial_system,id_course)
values (516,111)



insert into instractor_class(id_instractor,name_class)
values (1,'A2')



insert into system_exam(code_exam,serial_system)
values (501,516)

insert into track(name,class_name)
values ('.Net','A2'),('.Net','A1')





insert into [dbo].[Question]
values ('in oop can implement multuiple class ', 'what is the interface' ,1,516)


insert into .[Question_exam]
values(501,1)


insert into [dbo].[department]
values('software',1)

insert into [dbo].[instractor_course]
values(1,11)


insert into [dbo].[instractor_Question]
values(1,1)



insert into [dbo].[student_Account]
values('eslam','male',23,'123456','eslamhattem523@gmail.com','1234',3,'A1',1),
('Amr','male',23,'123456','eslamhattem523@gmail.com','1234',3,'A1',1),
('Abdo','male',23,'123456','eslamhattem523@gmail.com','1234',3,'A1',1),
('Ahmed','male',23,'123456','eslamhattem523@gmail.com','1234',3,'A1',1)

insert into [dbo].[student_answer]
values('ture','123456',516)



insert into [dbo].[result]
values(1,'123456',516)


---------------------------------------------------------------------
--this the studentname and classname and coursename

create view  v1
as
(

SELECT  dbo.instractor_account.name, dbo.instractor_class.name_class, dbo.course.name AS cousre_name
FROM   dbo.instractor_account INNER JOIN
dbo.instractor_class ON dbo.instractor_account.id = dbo.instractor_class.id_instractor INNER JOIN
dbo.instractor_course ON dbo.instractor_account.id = dbo.instractor_course.id_instractor INNER JOIN
dbo.instractor_Question ON dbo.instractor_account.id = dbo.instractor_Question.id_instractor INNER JOIN
dbo.course ON dbo.instractor_course.id_course = dbo.course.id
)

select * from v1

--------------------------------------------------------------------------------------
----------------view------------------------
--the course_name and instractor teach course

create view course_name_instractor_name
as
(
select c.[name] as course  ,i.[name] as instractor
from [dbo].[course] c join [dbo].[instractor_course]
on c.id=[dbo].[instractor_course].id_course join [dbo].[instractor_account] i
on i.id=[instractor_course].id_instractor
)

select * from course_name_instractor_name

-------------------------------------------------------------------------------------
--this code_exam and course_name and min_degree for this coures

create view exam_course_degree
as(

SELECT dbo.exam.code_exam, dbo.correct_answer.course_name, dbo.correct_answer.min_degree
FROM  dbo.system INNER JOIN
 dbo.correct_answer ON dbo.system.serial = dbo.correct_answer.serial_system INNER JOIN
dbo.system_exam ON dbo.system.serial = dbo.system_exam.serial_system INNER JOIN
 dbo.exam ON dbo.system_exam.code_exam = dbo.exam.code_exam
GROUP BY dbo.exam.code_exam, dbo.correct_answer.course_name, dbo.correct_answer.min_degree
)

select * from exam_course_degree
-----------------------------------------------------------------------------
--- this code_exam and cousre_name and min_degree and student_answer and student_name
create view exam_course_min_answer_name
as(
SELECT        dbo.exam.code_exam, dbo.correct_answer.course_name, dbo.correct_answer.min_degree, dbo.student_answer.student_answer, dbo.student_Account.name
FROM            dbo.system INNER JOIN
    dbo.correct_answer ON dbo.system.serial = dbo.correct_answer.serial_system INNER JOIN
       dbo.system_exam ON dbo.system.serial = dbo.system_exam.serial_system INNER JOIN
    dbo.exam ON dbo.system_exam.code_exam = dbo.exam.code_exam INNER JOIN
    dbo.student_answer ON dbo.system.serial = dbo.student_answer.serial_system INNER JOIN
  dbo.student_Account ON dbo.student_answer.serial_num_student = dbo.student_Account.serial_num
GROUP BY dbo.exam.code_exam, dbo.correct_answer.course_name, dbo.correct_answer.min_degree, dbo.student_answer.student_answer, dbo.student_Account.name
)

select *from exam_course_min_answer_name
--------------------------------------------------------------
--this the track_name and branch_name

create view track_branch
as
(
SELECT dbo.course.name as track_name, dbo.brance.name AS branch_name
FROM dbo.brance INNER JOIN
dbo.course_branche ON dbo.brance.code = dbo.course_branche.code_brance INNER JOIN
dbo.course ON dbo.course_branche.id_course = dbo.course.id
)

select * from track_branch
------------------------------------------------------------------------
-- this student_name and student_answer and question_id 

create view student_name_student_answer_question_id
as
(
SELECT  dbo.student_Account.name, dbo.student_answer.student_answer, dbo.result.question_id
FROM  dbo.result INNER JOIN
 dbo.student_answer ON dbo.result.serial_student = dbo.student_answer.serial_num_student INNER JOIN
 dbo.student_Account ON dbo.student_answer.serial_num_student = dbo.student_Account.serial_num
)

select * from student_name_student_answer_question_id
------------------------------------------------------------------------------------------------
-- this code_exam and question
alter view code_exam_question
as
(
SELECT dbo.exam.code_exam, dbo.Question.ture_and_false as question
FROM dbo.exam INNER JOIN
dbo.Question_exam ON dbo.exam.code_exam = dbo.Question_exam.code_exam INNER JOIN
dbo.Question ON dbo.Question_exam.id_question = dbo.Question.id
GROUP BY dbo.exam.code_exam, dbo.Question.ture_and_false
)

select * from code_exam_question
-------------------------------------------------------------------
---this the branch_name and manger_name and department_name and track_name and intake_year 
create view inforamtion_branch
as
(
SELECT dbo.brance.name, dbo.training_manger.name AS manger, dbo.department.name AS department, dbo.track.name AS track, dbo.intake.num as intake
FROM  dbo.branche_intake INNER JOIN
 dbo.brance ON dbo.branche_intake.code_brance = dbo.brance.code INNER JOIN
 dbo.intake ON dbo.branche_intake.year_intake = dbo.intake.[year] INNER JOIN
dbo.instractor_account INNER JOIN
dbo.track ON dbo.instractor_account.id = dbo.track.id INNER JOIN
dbo.training_manger ON dbo.instractor_account.id_manger = dbo.training_manger.id INNER JOIN
dbo.department ON dbo.training_manger.id = dbo.department.id_manger ON dbo.intake.id_manger = dbo.training_manger.id
GROUP BY dbo.brance.name, dbo.training_manger.name, dbo.department.name, dbo.track.name, dbo.intake.num
)

select * from inforamtion_branch

-------------------------------------------------------------
-- this the instractor_name and question choose by instractor and code exam
create view instractoe_question_codeexam
as
(

SELECT  dbo.instractor_account.name as instractror_name, dbo.Question.ture_and_false as [question true&false], dbo.exam.code_exam 
FROM  dbo.exam INNER JOIN
dbo.instractor_account ON dbo.exam.id_instractor = dbo.instractor_account.id INNER JOIN dbo.instractor_Question ON dbo.instractor_account.id = dbo.instractor_Question.id_instractor INNER JOIN
dbo.Question ON dbo.instractor_Question.id_question = dbo.Question.id INNER JOIN
dbo.Question_exam ON dbo.exam.code_exam = dbo.Question_exam.code_exam AND dbo.Question.id = dbo.Question_exam.id_question
)

select * from instractoe_question_codeexam
------------------------------------------------------------
---this the instractorname and coursename and studentname and classname
create view instarctor_course_student_class
as
(
SELECT  dbo.instractor_account.name as instarctor_name, dbo.course.name AS course_name, dbo.student_Account.name AS student_name, dbo.View_1.name AS class_name
FROM dbo.instractor_account INNER JOIN
dbo.instractor_course ON dbo.instractor_account.id = dbo.instractor_course.id_instractor INNER JOIN
dbo.course ON dbo.instractor_course.id_course = dbo.course.id CROSS JOIN
dbo.View_1 CROSS JOIN
dbo.student_Account
)

select * from instarctor_course_student_class
---------------------------------------------------------------
--this the departmentname and trackname and mangername

create view  department_track_manger
as
(
SELECT dbo.department.name as department, dbo.intake.name AS track, dbo.instractor_account.name AS manger
FROM dbo.instractor_account CROSS JOIN
 dbo.department CROSS JOIN
 dbo.intake

)

select * from department_track_manger

 -------------------------------------------------------------
---------index------------------

create index Ix_correct_answer_course_name_max_degree_min_degree on correct_answer(course_name,max_degree,min_degree)
create index Ix_course_name    on course(name)
create index Ix_training_manger_name on training_manger(name)
create index Ix_class_name_  on class(name)
create index Ix_instractor_class_name_class  on    instractor_class(name_class)
create index Ix_instractor_course_id_instractor_id_course  on instractor_course(id_instractor,id_course)
create index Ix_instractor_Question_id_instractor_id_question  on instractor_Question(id_instractor,id_question)
create index Ix_department_name on department(name)
create index Ix_department_id on department(id)
create index Ix_department_id_manger on department(id_manger)
create index Ix_brance_name on brance(name)
create index Ix_brance_code on brance(code)

----------------------------------------------------------------------------------------------

alter function check_succes(@id int)
returns nvarchar(50)
as

begin

DECLARE @y int
SET @y  = (SELECT [total_degree] FROM exam where [code_exam]=@id)
	if(@y < = 50)
	begin
		
		return  @y + convert(nvarchar(50),@y)
	end
	else
	return @y
return @y
end



select dbo.check_succes(503)


-------------------------------------------------------------------
----------inseated--------
create trigger tr_sys_course
on  system_course
instead of delete
as
begin
	print ' You cannot  delete from this table'
	
end
------------
create trigger tr_intake
on  intake
instead of delete
as
begin
	print ' You cannot  delete from this table'
	
end
-------------------

----thats the After trigger----------
create trigger tr_update_course
on instractor_course
after insert
as
begin
		
select * from inserted
select * from deleted

end

------------------------------------------------------------

create trigger tr_course_after_class
on instractor_class
after insert 
as 
 begin
insert into instractor_course(id_instractor,id_course)
values(1,111)
end

---------------------------------------------------------------

create proc proc_exam  @min int, @max int  
as
begin
select total_degree
from exam
where total_degree between @min and @max
order by total_degree
end


exec proc_exam 50, 100
-----------------------------
create function check_degree()
returns int
as
begin

DECLARE @y int
SET @y  = (SELECT [total_degree] FROM exam)
if((@y/2) >= 50)
RETURN 'Yousucced'
else
RETURN 'YouFailed'
return @y
end

---------------------------------------------------------
alter function Students_infromation(@format nvarchar(50)) 
returns @t table
		(
		 StdID int primary key,
		 StdName nvarchar(50)
		)
as
begin
	if (@format= (select [name] from [dbo].[student_Account] ) ) 
		insert into @t
		select  [serial_num], [name]  
		from [dbo].[student_Account]
	
	

return 

end

select StdID,StdName from Students_infromation('eslam')

--------------------------------------------------------------------
