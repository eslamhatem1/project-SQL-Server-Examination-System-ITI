USE [master]
GO
/****** Object:  Database [project]    Script Date: 1/29/2022 10:48:12 AM ******/
CREATE DATABASE [project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DF1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\DF1.mdf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20480KB ), 
 FILEGROUP [Secondary] 
( NAME = N'DF2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\DF2.ndf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20480KB ),
( NAME = N'DF3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\DF3.ndf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20480KB )
 LOG ON 
( NAME = N'LF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ESLAM\MSSQL\DATA\LF.ldf' , SIZE = 10240KB , MAXSIZE = 2048GB , FILEGROWTH = 20480KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [project] SET ARITHABORT OFF 
GO
ALTER DATABASE [project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [project] SET  ENABLE_BROKER 
GO
ALTER DATABASE [project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [project] SET RECOVERY FULL 
GO
ALTER DATABASE [project] SET  MULTI_USER 
GO
ALTER DATABASE [project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'project', N'ON'
GO
ALTER DATABASE [project] SET QUERY_STORE = OFF
GO
USE [project]
GO
/****** Object:  User [mang-train]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE USER [mang-train] FOR LOGIN [mang-train] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [admin]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[check_degree]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[check_degree]()
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
GO
/****** Object:  UserDefinedFunction [dbo].[check_succes]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[check_succes](@id int)
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
GO
/****** Object:  UserDefinedFunction [dbo].[Students_infromation]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Students_infromation](@format nvarchar(50)) 
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
GO
/****** Object:  Table [dbo].[instractor_class]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instractor_class](
	[id_instractor] [int] NOT NULL,
	[name_class] [nvarchar](20) NOT NULL,
 CONSTRAINT [instractor_class_PK] PRIMARY KEY CLUSTERED 
(
	[id_instractor] ASC,
	[name_class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[instractor_course]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instractor_course](
	[id_instractor] [int] NOT NULL,
	[id_course] [int] NOT NULL,
 CONSTRAINT [instractor_course_PK] PRIMARY KEY CLUSTERED 
(
	[id_instractor] ASC,
	[id_course] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[instractor_Question]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instractor_Question](
	[id_instractor] [int] NOT NULL,
	[id_question] [int] NOT NULL,
 CONSTRAINT [instractor_Question_PK] PRIMARY KEY CLUSTERED 
(
	[id_instractor] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course](
	[name] [nvarchar](50) NOT NULL,
	[id] [int] NOT NULL,
	[min_degree] [int] NULL,
	[max_degress] [int] NULL,
	[serial_system] [nvarchar](11) NOT NULL,
	[ description] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[instractor_account]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instractor_account](
	[name] [nvarchar](20) NOT NULL,
	[age] [int] NULL,
	[gender] [nvarchar](11) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](50) NULL,
	[id_manger] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v1]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v1]
as
(

SELECT  dbo.instractor_account.name, dbo.instractor_class.name_class, dbo.course.name AS cousre_name
FROM   dbo.instractor_account INNER JOIN
dbo.instractor_class ON dbo.instractor_account.id = dbo.instractor_class.id_instractor INNER JOIN
dbo.instractor_course ON dbo.instractor_account.id = dbo.instractor_course.id_instractor INNER JOIN
dbo.instractor_Question ON dbo.instractor_account.id = dbo.instractor_Question.id_instractor INNER JOIN
dbo.course ON dbo.instractor_course.id_course = dbo.course.id
)
GO
/****** Object:  View [dbo].[course_name_instractor_name]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[course_name_instractor_name]
as
(
select c.[name] as course  ,i.[name] as instractor
from [dbo].[course] c join [dbo].[instractor_course]
on c.id=[dbo].[instractor_course].id_course join [dbo].[instractor_account] i
on i.id=[instractor_course].id_instractor
)
GO
/****** Object:  Table [dbo].[system]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[system](
	[serial] [nvarchar](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[serial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Secondary]
) ON [Secondary]
GO
/****** Object:  Table [dbo].[system_exam]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[system_exam](
	[code_exam] [nvarchar](20) NOT NULL,
	[serial_system] [nvarchar](11) NOT NULL,
 CONSTRAINT [system_exam_PK] PRIMARY KEY CLUSTERED 
(
	[serial_system] ASC,
	[code_exam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[correct_answer]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[correct_answer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[courses] [nvarchar](50) NULL,
	[course_id] [int] NULL,
	[course_name] [nvarchar](50) NULL,
	[max_degree] [int] NULL,
	[min_degree] [int] NULL,
	[serial_system] [nvarchar](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exam]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exam](
	[total_degree] [int] NOT NULL,
	[normal_exam] [nvarchar](50) NULL,
	[correction_exam] [nvarchar](50) NULL,
	[code_exam] [nvarchar](20) NOT NULL,
	[id_instractor] [int] NOT NULL,
	[id_course] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[code_exam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[exam_course_degree]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[exam_course_degree]
as(

SELECT dbo.exam.code_exam, dbo.correct_answer.course_name, dbo.correct_answer.min_degree
FROM  dbo.system INNER JOIN
 dbo.correct_answer ON dbo.system.serial = dbo.correct_answer.serial_system INNER JOIN
dbo.system_exam ON dbo.system.serial = dbo.system_exam.serial_system INNER JOIN
 dbo.exam ON dbo.system_exam.code_exam = dbo.exam.code_exam
GROUP BY dbo.exam.code_exam, dbo.correct_answer.course_name, dbo.correct_answer.min_degree
)
GO
/****** Object:  Table [dbo].[student_answer]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_answer](
	[Question_id] [int] IDENTITY(1,1) NOT NULL,
	[student_answer] [nvarchar](max) NULL,
	[serial_num_student] [nvarchar](11) NOT NULL,
	[serial_system] [nvarchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[serial_num_student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_Account]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_Account](
	[name] [nvarchar](20) NULL,
	[gender] [nvarchar](20) NULL,
	[age] [int] NULL,
	[serial_num] [nvarchar](11) NOT NULL,
	[email] [nvarchar](50) NULL,
	[password] [nvarchar](20) NULL,
	[id_manger] [int] NULL,
	[class_name] [nvarchar](20) NULL,
	[code_branch] [int] NULL,
	[ student_Cousre] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[serial_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[exam_course_min_answer_name]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[exam_course_min_answer_name]
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
GO
/****** Object:  Table [dbo].[course_branche]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_branche](
	[id_course] [int] NOT NULL,
	[code_brance] [int] NOT NULL,
 CONSTRAINT [course_branche_PK] PRIMARY KEY CLUSTERED 
(
	[code_brance] ASC,
	[id_course] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[brance]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brance](
	[code] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[track_branch]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[track_branch]
as
(
SELECT dbo.course.name as track_name, dbo.brance.name AS branch_name
FROM dbo.brance INNER JOIN
dbo.course_branche ON dbo.brance.code = dbo.course_branche.code_brance INNER JOIN
dbo.course ON dbo.course_branche.id_course = dbo.course.id
)
GO
/****** Object:  Table [dbo].[result]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[result](
	[question_id] [int] NOT NULL,
	[serial_student] [nvarchar](11) NULL,
	[serial_system] [nvarchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[student_name_student_answer_question_id]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[student_name_student_answer_question_id]
as
(
SELECT  dbo.student_Account.name, dbo.student_answer.student_answer, dbo.result.question_id
FROM  dbo.result INNER JOIN
 dbo.student_answer ON dbo.result.serial_student = dbo.student_answer.serial_num_student INNER JOIN
 dbo.student_Account ON dbo.student_answer.serial_num_student = dbo.student_Account.serial_num
)
GO
/****** Object:  Table [dbo].[Question_exam]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_exam](
	[code_exam] [nvarchar](20) NOT NULL,
	[id_question] [int] NOT NULL,
 CONSTRAINT [Question_exam_PK] PRIMARY KEY CLUSTERED 
(
	[id_question] ASC,
	[code_exam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ture_and_false] [nvarchar](50) NULL,
	[text] [nvarchar](100) NOT NULL,
	[code_Question] [int] NOT NULL,
	[serial_system] [nvarchar](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[cide_exam_question]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[cide_exam_question]
as
(
SELECT dbo.exam.code_exam, dbo.Question.ture_and_false
FROM dbo.exam INNER JOIN
dbo.Question_exam ON dbo.exam.code_exam = dbo.Question_exam.code_exam INNER JOIN
dbo.Question ON dbo.Question_exam.id_question = dbo.Question.id
GROUP BY dbo.exam.code_exam, dbo.Question.ture_and_false
)
GO
/****** Object:  View [dbo].[code_exam_question]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[code_exam_question]
as
(
SELECT dbo.exam.code_exam, dbo.Question.ture_and_false as question
FROM dbo.exam INNER JOIN
dbo.Question_exam ON dbo.exam.code_exam = dbo.Question_exam.code_exam INNER JOIN
dbo.Question ON dbo.Question_exam.id_question = dbo.Question.id
GROUP BY dbo.exam.code_exam, dbo.Question.ture_and_false
)
GO
/****** Object:  Table [dbo].[branche_intake]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[branche_intake](
	[code_brance] [int] NOT NULL,
	[year_intake] [int] NOT NULL,
 CONSTRAINT [branche_intake_PK] PRIMARY KEY CLUSTERED 
(
	[code_brance] ASC,
	[year_intake] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[training_manger]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[training_manger](
	[name] [nvarchar](20) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[track]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[track](
	[name] [nvarchar](20) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[class_name] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[name] [nvarchar](50) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_manger] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[intake]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[intake](
	[name] [nvarchar](50) NOT NULL,
	[year] [int] IDENTITY(1,1) NOT NULL,
	[id_manger] [int] NULL,
	[num] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[inforamtion_branch]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[inforamtion_branch]
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
GO
/****** Object:  Table [dbo].[class]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[class](
	[name] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_1]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        dbo.instractor_account.name AS Expr1, dbo.course.name AS Expr2, dbo.class.name
FROM            dbo.instractor_account INNER JOIN
                         dbo.instractor_course ON dbo.instractor_account.id = dbo.instractor_course.id_instractor INNER JOIN
                         dbo.course ON dbo.instractor_course.id_course = dbo.course.id INNER JOIN
                         dbo.instractor_class ON dbo.instractor_account.id = dbo.instractor_class.id_instractor INNER JOIN
                         dbo.class ON dbo.instractor_class.name_class = dbo.class.name
GROUP BY dbo.instractor_account.name, dbo.course.name, dbo.class.name
GO
/****** Object:  View [dbo].[instractoe_question_codeexam]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[instractoe_question_codeexam]
as
(

SELECT  dbo.instractor_account.name as instractror_name, dbo.Question.ture_and_false as [question true&false], dbo.exam.code_exam 
FROM  dbo.exam INNER JOIN
dbo.instractor_account ON dbo.exam.id_instractor = dbo.instractor_account.id INNER JOIN dbo.instractor_Question ON dbo.instractor_account.id = dbo.instractor_Question.id_instractor INNER JOIN
dbo.Question ON dbo.instractor_Question.id_question = dbo.Question.id INNER JOIN
dbo.Question_exam ON dbo.exam.code_exam = dbo.Question_exam.code_exam AND dbo.Question.id = dbo.Question_exam.id_question
)
GO
/****** Object:  View [dbo].[instarctor_course_student_class]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[instarctor_course_student_class]
as
(
SELECT  dbo.instractor_account.name as instarctor_name, dbo.course.name AS course_name, dbo.student_Account.name AS student_name, dbo.View_1.name AS class_name
FROM dbo.instractor_account INNER JOIN
dbo.instractor_course ON dbo.instractor_account.id = dbo.instractor_course.id_instractor INNER JOIN
dbo.course ON dbo.instractor_course.id_course = dbo.course.id CROSS JOIN
dbo.View_1 CROSS JOIN
dbo.student_Account
)
GO
/****** Object:  View [dbo].[department_track_manger]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[department_track_manger]
as
(
SELECT dbo.department.name as department, dbo.intake.name AS track, dbo.instractor_account.name AS manger
FROM dbo.instractor_account CROSS JOIN
 dbo.department CROSS JOIN
 dbo.intake

)
GO
/****** Object:  Table [dbo].[course_class]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_class](
	[name_class] [nvarchar](20) NOT NULL,
	[id_coures] [int] NOT NULL,
 CONSTRAINT [course_class_instractor_PK] PRIMARY KEY CLUSTERED 
(
	[name_class] ASC,
	[id_coures] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_exam]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_exam](
	[code_exam] [nvarchar](20) NOT NULL,
	[id_course] [int] NOT NULL,
 CONSTRAINT [course_exam_PK] PRIMARY KEY CLUSTERED 
(
	[id_course] ASC,
	[code_exam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[system_course]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[system_course](
	[serial_system] [nvarchar](11) NOT NULL,
	[id_course] [int] NOT NULL,
 CONSTRAINT [student_course_PK] PRIMARY KEY CLUSTERED 
(
	[serial_system] ASC,
	[id_course] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[brance] ON 

INSERT [dbo].[brance] ([code], [name]) VALUES (2, N'cairo')
INSERT [dbo].[brance] ([code], [name]) VALUES (1, N'Minya')
SET IDENTITY_INSERT [dbo].[brance] OFF
GO
INSERT [dbo].[branche_intake] ([code_brance], [year_intake]) VALUES (1, 2)
GO
INSERT [dbo].[class] ([name]) VALUES (N'A1')
INSERT [dbo].[class] ([name]) VALUES (N'A2')
INSERT [dbo].[class] ([name]) VALUES (N'A3')
INSERT [dbo].[class] ([name]) VALUES (N'B1')
INSERT [dbo].[class] ([name]) VALUES (N'B2')
INSERT [dbo].[class] ([name]) VALUES (N'B3')
INSERT [dbo].[class] ([name]) VALUES (N'C1')
INSERT [dbo].[class] ([name]) VALUES (N'C2')
GO
SET IDENTITY_INSERT [dbo].[correct_answer] ON 

INSERT [dbo].[correct_answer] ([id], [courses], [course_id], [course_name], [max_degree], [min_degree], [serial_system]) VALUES (1, N'.Net,Angular,Mean', 501, N'.Net', 10, 50, N'516')
INSERT [dbo].[correct_answer] ([id], [courses], [course_id], [course_name], [max_degree], [min_degree], [serial_system]) VALUES (2, N'.Net,Angular,Mean', 501, N'.Net', 10, 50, N'516')
INSERT [dbo].[correct_answer] ([id], [courses], [course_id], [course_name], [max_degree], [min_degree], [serial_system]) VALUES (3, N'.Net,Angular,Mean', 501, N'.Net', 10, 50, N'516')
SET IDENTITY_INSERT [dbo].[correct_answer] OFF
GO
INSERT [dbo].[course] ([name], [id], [min_degree], [max_degress], [serial_system], [ description]) VALUES (N'.Net', 11, 50, 100, N'516', N'full stack using .net')
INSERT [dbo].[course] ([name], [id], [min_degree], [max_degress], [serial_system], [ description]) VALUES (N'Angular', 21, 50, 100, N'516', N'framwork frontend')
INSERT [dbo].[course] ([name], [id], [min_degree], [max_degress], [serial_system], [ description]) VALUES (N'mearn', 111, 50, 100, N'516', N'full stack using mearn')
GO
INSERT [dbo].[course_branche] ([id_course], [code_brance]) VALUES (11, 1)
GO
SET IDENTITY_INSERT [dbo].[department] ON 

INSERT [dbo].[department] ([name], [id], [id_manger]) VALUES (N'software', 1, 1)
SET IDENTITY_INSERT [dbo].[department] OFF
GO
INSERT [dbo].[exam] ([total_degree], [normal_exam], [correction_exam], [code_exam], [id_instractor], [id_course]) VALUES (100, N'.Net', N'.Netcrr', N'501', 1, 11)
INSERT [dbo].[exam] ([total_degree], [normal_exam], [correction_exam], [code_exam], [id_instractor], [id_course]) VALUES (200, N'software', N'.net', N'502', 1, 11)
INSERT [dbo].[exam] ([total_degree], [normal_exam], [correction_exam], [code_exam], [id_instractor], [id_course]) VALUES (50, N'ccna', N'ccna', N'503', 2, 11)
GO
SET IDENTITY_INSERT [dbo].[instractor_account] ON 

INSERT [dbo].[instractor_account] ([name], [age], [gender], [id], [email], [id_manger]) VALUES (N'Ahmed', 30, N'M', 1, N'enganyeng@gmail.com', 1)
INSERT [dbo].[instractor_account] ([name], [age], [gender], [id], [email], [id_manger]) VALUES (N'eslam', 23, N'm', 2, N'e', 1)
SET IDENTITY_INSERT [dbo].[instractor_account] OFF
GO
INSERT [dbo].[instractor_class] ([id_instractor], [name_class]) VALUES (1, N'A2')
GO
INSERT [dbo].[instractor_course] ([id_instractor], [id_course]) VALUES (1, 11)
GO
INSERT [dbo].[instractor_Question] ([id_instractor], [id_question]) VALUES (1, 1)
GO
SET IDENTITY_INSERT [dbo].[intake] ON 

INSERT [dbo].[intake] ([name], [year], [id_manger], [num]) VALUES (N'.net', 2, 1, 2020)
SET IDENTITY_INSERT [dbo].[intake] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([id], [ture_and_false], [text], [code_Question], [serial_system]) VALUES (1, N'in oop can implement multuiple class ', N'what is the interface', 1, N'516')
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
INSERT [dbo].[Question_exam] ([code_exam], [id_question]) VALUES (N'501', 1)
GO
INSERT [dbo].[result] ([question_id], [serial_student], [serial_system]) VALUES (1, N'123456', N'516')
GO
INSERT [dbo].[student_Account] ([name], [gender], [age], [serial_num], [email], [password], [id_manger], [class_name], [code_branch], [ student_Cousre]) VALUES (N'eslam', N'male', 23, N'123456', N'eslamhattem523@gmail.com', N'1234', 3, N'A1', 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[student_answer] ON 

INSERT [dbo].[student_answer] ([Question_id], [student_answer], [serial_num_student], [serial_system]) VALUES (1, N'ture', N'123456', N'516')
SET IDENTITY_INSERT [dbo].[student_answer] OFF
GO
INSERT [dbo].[system] ([serial]) VALUES (N'516')
GO
INSERT [dbo].[system_course] ([serial_system], [id_course]) VALUES (N'516', 11)
INSERT [dbo].[system_course] ([serial_system], [id_course]) VALUES (N'516', 111)
GO
INSERT [dbo].[system_exam] ([code_exam], [serial_system]) VALUES (N'501', N'516')
GO
SET IDENTITY_INSERT [dbo].[track] ON 

INSERT [dbo].[track] ([name], [id], [class_name]) VALUES (N'.Net', 1, N'A2')
INSERT [dbo].[track] ([name], [id], [class_name]) VALUES (N'.Net', 2, N'A1')
INSERT [dbo].[track] ([name], [id], [class_name]) VALUES (N'.Net', 3, N'A2')
INSERT [dbo].[track] ([name], [id], [class_name]) VALUES (N'.Net', 4, N'A1')
SET IDENTITY_INSERT [dbo].[track] OFF
GO
SET IDENTITY_INSERT [dbo].[training_manger] ON 

INSERT [dbo].[training_manger] ([name], [id]) VALUES (N'Ahmed', 1)
INSERT [dbo].[training_manger] ([name], [id]) VALUES (N'Ahmed', 2)
INSERT [dbo].[training_manger] ([name], [id]) VALUES (N'Ahmed', 4)
INSERT [dbo].[training_manger] ([name], [id]) VALUES (N'eslam', 3)
INSERT [dbo].[training_manger] ([name], [id]) VALUES (N'eslam', 5)
SET IDENTITY_INSERT [dbo].[training_manger] OFF
GO
/****** Object:  Index [Ix_brance_code]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_brance_code] ON [dbo].[brance]
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_brance_name]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_brance_name] ON [dbo].[brance]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_class_name_]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_class_name_] ON [dbo].[class]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_correct_answer_course_name_max_degree_min_degree]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_correct_answer_course_name_max_degree_min_degree] ON [dbo].[correct_answer]
(
	[course_name] ASC,
	[max_degree] ASC,
	[min_degree] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_course_name]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_course_name] ON [dbo].[course]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Ix_department_id]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_department_id] ON [dbo].[department]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Ix_department_id_manger]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_department_id_manger] ON [dbo].[department]
(
	[id_manger] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_department_name]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_department_name] ON [dbo].[department]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_instractor_class_name_class]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_instractor_class_name_class] ON [dbo].[instractor_class]
(
	[name_class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Ix_instractor_course_id_instractor_id_course]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_instractor_course_id_instractor_id_course] ON [dbo].[instractor_course]
(
	[id_instractor] ASC,
	[id_course] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Ix_instractor_Question_id_instractor_id_question]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_instractor_Question_id_instractor_id_question] ON [dbo].[instractor_Question]
(
	[id_instractor] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ix_training_manger_name]    Script Date: 1/29/2022 10:48:13 AM ******/
CREATE NONCLUSTERED INDEX [Ix_training_manger_name] ON [dbo].[training_manger]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[branche_intake]  WITH CHECK ADD  CONSTRAINT [branche_intake_code_brance_fk] FOREIGN KEY([code_brance])
REFERENCES [dbo].[brance] ([code])
GO
ALTER TABLE [dbo].[branche_intake] CHECK CONSTRAINT [branche_intake_code_brance_fk]
GO
ALTER TABLE [dbo].[branche_intake]  WITH CHECK ADD  CONSTRAINT [branche_intake_year_intake_fk] FOREIGN KEY([year_intake])
REFERENCES [dbo].[intake] ([year])
GO
ALTER TABLE [dbo].[branche_intake] CHECK CONSTRAINT [branche_intake_year_intake_fk]
GO
ALTER TABLE [dbo].[correct_answer]  WITH CHECK ADD  CONSTRAINT [correct_answer_system_fk] FOREIGN KEY([serial_system])
REFERENCES [dbo].[system] ([serial])
GO
ALTER TABLE [dbo].[correct_answer] CHECK CONSTRAINT [correct_answer_system_fk]
GO
ALTER TABLE [dbo].[course]  WITH CHECK ADD  CONSTRAINT [course_system_fk] FOREIGN KEY([serial_system])
REFERENCES [dbo].[system] ([serial])
GO
ALTER TABLE [dbo].[course] CHECK CONSTRAINT [course_system_fk]
GO
ALTER TABLE [dbo].[course_branche]  WITH CHECK ADD  CONSTRAINT [course_branche_code_brance_fk] FOREIGN KEY([code_brance])
REFERENCES [dbo].[brance] ([code])
GO
ALTER TABLE [dbo].[course_branche] CHECK CONSTRAINT [course_branche_code_brance_fk]
GO
ALTER TABLE [dbo].[course_branche]  WITH CHECK ADD  CONSTRAINT [course_branche_id_course_fk] FOREIGN KEY([id_course])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[course_branche] CHECK CONSTRAINT [course_branche_id_course_fk]
GO
ALTER TABLE [dbo].[course_class]  WITH CHECK ADD  CONSTRAINT [course_class_instractor_id_coures_fk] FOREIGN KEY([id_coures])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[course_class] CHECK CONSTRAINT [course_class_instractor_id_coures_fk]
GO
ALTER TABLE [dbo].[course_class]  WITH CHECK ADD  CONSTRAINT [course_class_instractor_name_class_fk] FOREIGN KEY([name_class])
REFERENCES [dbo].[class] ([name])
GO
ALTER TABLE [dbo].[course_class] CHECK CONSTRAINT [course_class_instractor_name_class_fk]
GO
ALTER TABLE [dbo].[course_exam]  WITH CHECK ADD  CONSTRAINT [course_exam_code_exam_fk] FOREIGN KEY([code_exam])
REFERENCES [dbo].[exam] ([code_exam])
GO
ALTER TABLE [dbo].[course_exam] CHECK CONSTRAINT [course_exam_code_exam_fk]
GO
ALTER TABLE [dbo].[course_exam]  WITH CHECK ADD  CONSTRAINT [course_exam_id_course_fk] FOREIGN KEY([id_course])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[course_exam] CHECK CONSTRAINT [course_exam_id_course_fk]
GO
ALTER TABLE [dbo].[department]  WITH CHECK ADD  CONSTRAINT [department_manger_fk] FOREIGN KEY([id_manger])
REFERENCES [dbo].[training_manger] ([id])
GO
ALTER TABLE [dbo].[department] CHECK CONSTRAINT [department_manger_fk]
GO
ALTER TABLE [dbo].[exam]  WITH CHECK ADD  CONSTRAINT [exam_course_fk] FOREIGN KEY([id_course])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[exam] CHECK CONSTRAINT [exam_course_fk]
GO
ALTER TABLE [dbo].[exam]  WITH CHECK ADD  CONSTRAINT [exam_instractor_fk] FOREIGN KEY([id_instractor])
REFERENCES [dbo].[instractor_account] ([id])
GO
ALTER TABLE [dbo].[exam] CHECK CONSTRAINT [exam_instractor_fk]
GO
ALTER TABLE [dbo].[instractor_account]  WITH CHECK ADD  CONSTRAINT [instractor_account_training_manger_fk] FOREIGN KEY([id_manger])
REFERENCES [dbo].[training_manger] ([id])
GO
ALTER TABLE [dbo].[instractor_account] CHECK CONSTRAINT [instractor_account_training_manger_fk]
GO
ALTER TABLE [dbo].[instractor_class]  WITH CHECK ADD  CONSTRAINT [instractor_class_id_instractor_fk] FOREIGN KEY([id_instractor])
REFERENCES [dbo].[instractor_account] ([id])
GO
ALTER TABLE [dbo].[instractor_class] CHECK CONSTRAINT [instractor_class_id_instractor_fk]
GO
ALTER TABLE [dbo].[instractor_class]  WITH CHECK ADD  CONSTRAINT [instractor_class_name_class_fk] FOREIGN KEY([name_class])
REFERENCES [dbo].[class] ([name])
GO
ALTER TABLE [dbo].[instractor_class] CHECK CONSTRAINT [instractor_class_name_class_fk]
GO
ALTER TABLE [dbo].[instractor_course]  WITH CHECK ADD  CONSTRAINT [instractor_course_id_course_fk] FOREIGN KEY([id_course])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[instractor_course] CHECK CONSTRAINT [instractor_course_id_course_fk]
GO
ALTER TABLE [dbo].[instractor_course]  WITH CHECK ADD  CONSTRAINT [instractor_course_id_instractor_fk] FOREIGN KEY([id_instractor])
REFERENCES [dbo].[instractor_account] ([id])
GO
ALTER TABLE [dbo].[instractor_course] CHECK CONSTRAINT [instractor_course_id_instractor_fk]
GO
ALTER TABLE [dbo].[instractor_Question]  WITH CHECK ADD  CONSTRAINT [instractor_Question_id_instractor_fk] FOREIGN KEY([id_instractor])
REFERENCES [dbo].[instractor_account] ([id])
GO
ALTER TABLE [dbo].[instractor_Question] CHECK CONSTRAINT [instractor_Question_id_instractor_fk]
GO
ALTER TABLE [dbo].[instractor_Question]  WITH CHECK ADD  CONSTRAINT [instractor_Question_id_question_fk] FOREIGN KEY([id_question])
REFERENCES [dbo].[Question] ([id])
GO
ALTER TABLE [dbo].[instractor_Question] CHECK CONSTRAINT [instractor_Question_id_question_fk]
GO
ALTER TABLE [dbo].[intake]  WITH CHECK ADD  CONSTRAINT [intake_manger_fk] FOREIGN KEY([id_manger])
REFERENCES [dbo].[training_manger] ([id])
GO
ALTER TABLE [dbo].[intake] CHECK CONSTRAINT [intake_manger_fk]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [system_Question_fk] FOREIGN KEY([serial_system])
REFERENCES [dbo].[system] ([serial])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [system_Question_fk]
GO
ALTER TABLE [dbo].[Question_exam]  WITH CHECK ADD  CONSTRAINT [Question_exam_code_exam_fk] FOREIGN KEY([code_exam])
REFERENCES [dbo].[exam] ([code_exam])
GO
ALTER TABLE [dbo].[Question_exam] CHECK CONSTRAINT [Question_exam_code_exam_fk]
GO
ALTER TABLE [dbo].[Question_exam]  WITH CHECK ADD  CONSTRAINT [Question_exam_id_question_fk] FOREIGN KEY([id_question])
REFERENCES [dbo].[Question] ([id])
GO
ALTER TABLE [dbo].[Question_exam] CHECK CONSTRAINT [Question_exam_id_question_fk]
GO
ALTER TABLE [dbo].[result]  WITH CHECK ADD  CONSTRAINT [result_question_id_student_answer_fk] FOREIGN KEY([serial_student])
REFERENCES [dbo].[student_answer] ([serial_num_student])
GO
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [result_question_id_student_answer_fk]
GO
ALTER TABLE [dbo].[result]  WITH CHECK ADD  CONSTRAINT [result_serial_system_fk] FOREIGN KEY([serial_system])
REFERENCES [dbo].[system] ([serial])
GO
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [result_serial_system_fk]
GO
ALTER TABLE [dbo].[student_Account]  WITH CHECK ADD  CONSTRAINT [student_Account_branch_fk] FOREIGN KEY([code_branch])
REFERENCES [dbo].[brance] ([code])
GO
ALTER TABLE [dbo].[student_Account] CHECK CONSTRAINT [student_Account_branch_fk]
GO
ALTER TABLE [dbo].[student_Account]  WITH CHECK ADD  CONSTRAINT [student_Account_class_fk] FOREIGN KEY([class_name])
REFERENCES [dbo].[class] ([name])
GO
ALTER TABLE [dbo].[student_Account] CHECK CONSTRAINT [student_Account_class_fk]
GO
ALTER TABLE [dbo].[student_Account]  WITH CHECK ADD  CONSTRAINT [student_Account_training_manger_fk] FOREIGN KEY([id_manger])
REFERENCES [dbo].[training_manger] ([id])
GO
ALTER TABLE [dbo].[student_Account] CHECK CONSTRAINT [student_Account_training_manger_fk]
GO
ALTER TABLE [dbo].[student_Account]  WITH CHECK ADD  CONSTRAINT [student_corse] FOREIGN KEY([ student_Cousre])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[student_Account] CHECK CONSTRAINT [student_corse]
GO
ALTER TABLE [dbo].[student_answer]  WITH CHECK ADD  CONSTRAINT [student_answer_student_account_fk] FOREIGN KEY([serial_num_student])
REFERENCES [dbo].[student_Account] ([serial_num])
GO
ALTER TABLE [dbo].[student_answer] CHECK CONSTRAINT [student_answer_student_account_fk]
GO
ALTER TABLE [dbo].[student_answer]  WITH CHECK ADD  CONSTRAINT [student_answer_system_fk] FOREIGN KEY([serial_system])
REFERENCES [dbo].[system] ([serial])
GO
ALTER TABLE [dbo].[student_answer] CHECK CONSTRAINT [student_answer_system_fk]
GO
ALTER TABLE [dbo].[system_course]  WITH CHECK ADD  CONSTRAINT [system_course_serial_system_fk] FOREIGN KEY([serial_system])
REFERENCES [dbo].[system] ([serial])
GO
ALTER TABLE [dbo].[system_course] CHECK CONSTRAINT [system_course_serial_system_fk]
GO
ALTER TABLE [dbo].[system_course]  WITH CHECK ADD  CONSTRAINT [system_course_system_fk] FOREIGN KEY([id_course])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[system_course] CHECK CONSTRAINT [system_course_system_fk]
GO
ALTER TABLE [dbo].[system_exam]  WITH CHECK ADD  CONSTRAINT [system_exam_code_exam_fk] FOREIGN KEY([code_exam])
REFERENCES [dbo].[exam] ([code_exam])
GO
ALTER TABLE [dbo].[system_exam] CHECK CONSTRAINT [system_exam_code_exam_fk]
GO
ALTER TABLE [dbo].[system_exam]  WITH CHECK ADD  CONSTRAINT [system_exam_serial_system_fk] FOREIGN KEY([serial_system])
REFERENCES [dbo].[system] ([serial])
GO
ALTER TABLE [dbo].[system_exam] CHECK CONSTRAINT [system_exam_serial_system_fk]
GO
ALTER TABLE [dbo].[track]  WITH CHECK ADD  CONSTRAINT [track_class_name_fk] FOREIGN KEY([class_name])
REFERENCES [dbo].[class] ([name])
GO
ALTER TABLE [dbo].[track] CHECK CONSTRAINT [track_class_name_fk]
GO
/****** Object:  StoredProcedure [dbo].[proc_exam]    Script Date: 1/29/2022 10:48:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_exam]  @min int, @max int  
as
	begin
		select total_degree
		from exam
		where total_degree between @min and @max
		order by total_degree
	end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[72] 4[5] 2[6] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "instractor_account"
            Begin Extent = 
               Top = 2
               Left = 373
               Bottom = 132
               Right = 543
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "instractor_course"
            Begin Extent = 
               Top = 215
               Left = 624
               Bottom = 311
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "course"
            Begin Extent = 
               Top = 158
               Left = 357
               Bottom = 294
               Right = 527
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "instractor_class"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "class"
            Begin Extent = 
               Top = 156
               Left = 60
               Bottom = 233
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
USE [master]
GO
ALTER DATABASE [project] SET  READ_WRITE 
GO
