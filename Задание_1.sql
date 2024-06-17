-- Создание БД
create database University_DB;

-- Создание таблицы Students
create table Students (
	student_id serial primary key,
	first_name varchar(250) not null,
	last_name varchar(250) not null,
	date_of_birth date not null, 
	email varchar(250) unique not null,
	phone_number varchar(250),
	address varchar(250),
	enrollment_date date not null,
	gpa float
);

-- Создание таблицы Courses
create table Courses (
	course_id serial primary key not null, 
	course_name varchar(250) not null,
	description text,
	credits int not null,
	department varchar(250) not null
);

-- Создание таблицы  Enrollments
create table  Enrollments (
	enrollment_id serial primary key not null,
	student_id int not null,
	course_id int not null,
	enrollment_date date not null,
	grade int
);