-- Получите список всех студентов, зачисленных на определенный курс, отсортированный по фамилии
-- (я сделала поиск не по имени курса, а по id)
select s.first_name, s.last_name
	from students as s
	join enrollments as e on e.student_id = s.student_id
	where e.course_id = 1 
	order by last_name asc

-- Получите список курсов с указанием количества студентов, зачисленных на каждый курс
select c.course_name, count(e.student_id) as count_students
	from courses as c
	join enrollments as e on e.course_id = c.course_id
	group by c.course_name;

-- Получите список студентов, которые имеют средний балл (GPA) выше определенного значения
select s.first_name, s.last_name, s.gpa 
	from students as s
	where s.gpa > 3.5;

-- Получите полную информацию о зачислениях (включая имя студента и название курса), произошедших в течение последнего месяца.
-- (будет пусто, так как у меня таких записей нет)
select s.first_name, s.last_name, c.course_name, e.enrollment_date, e.grade
	from students as s
	join enrollments as e on e.student_id = s.student_id
	join courses as c on e.course_id = c.course_id
	where e.enrollment_date > now() - interval '30 day';

-- Получите список студентов, у которых нет номера телефона, отсортированный по дате зачисления
-- (тоже будет пусто, так как я удалила едиинственного студента, у которого отсутствовал номер)
select s.first_name, s.last_name, s.enrollment_date
	from students as s
	where s.phone_number = null
	order by enrollment_date asc;

-- Получите список курсов, которые проводятся в определенном департаменте, и отсортируйте их по количеству кредитов
select c.course_name, c.credits
	from courses as c
	where c.department = 'Компьютерные науки'
	order by c.credits asc;

-- Получите полную информацию о студентах, включая курсы, на которые они зачислены, и их оценки по этим курсам
select s.student_id, s.first_name, s.last_name, s.date_of_birth, s.email, s.phone_number, s.address, s.enrollment_date, s.gpa, c.course_name, e.grade
	from students as s
	join enrollments as e on e.student_id = s.student_id
	join courses as c on c.course_id = e.course_id;

-- это мне нужно было для проверки, чтобы глянуть, что будет, если один студент на нескольких курсах
insert into enrollments (student_id, course_id, enrollment_date, grade)
	values (5, 2, '2022-09-01', 4);

-- Получите список студентов, которые зачислены более чем на один курс
select s.first_name, s.last_name
	from students as s
	join enrollments as e on s.student_id = e. student_id
	group by s.student_id
	having count(e.student_id) > 1;	

-- Получите список студентов, которые зачислены на курсы из разных департаментов
-- сначала добавлю для студента еще один курс из другой области
insert into enrollments (student_id, course_id, enrollment_date, grade)
	values (3, 3, '2022-09-01', 4);

select s.first_name, s.last_name
	from students as s
	join enrollments as e on e.student_id = s.student_id
	join courses as c on c.course_id = e.course_id
	group by s.student_id
	having count(distinct c.department) > 1;

-- Получите список курсов, на которые не зачислен ни один студент
-- Сначала создам курс, на который никто не записан, чтобы на нем тестить
insert into courses (course_name, description, credits, department) 
	values ('Блаблабла', null, 5, 'Астрология');  

-- Здесь идет проверка на то, что id курса отсутствует в enrollments
select c.course_name
	from courses as c
	where c.course_id not in (select e.course_id from enrollments as e);

-- Получите список студентов, которые зачислены на все курсы из определенного департамента
select s.first_name, s.last_name
	from students as s
	join enrollments as e on e.student_id = s.student_id
	join courses as c on c.course_id = e.course_id
	where c.department = 'Компьютерные науки'
	group by s.student_id
	having count(distinct c.course_id) = (select count(*) from Courses where department = 'Компьютерные науки');

-- Найдите студентов, которые зачислены на курс с наибольшим количеством кредитов
select s.first_name, s.last_name, c.course_name, c.credits
	from students as s
	join enrollments as e on e.student_id = s.student_id
	join courses as c on c.course_id = e.course_id
	where c.credits = (select max(credits) from Courses);

-- Получите средний балл (GPA) для каждого студента, который зачислен на курсы, и отсортируйте студентов по этому среднему баллу.
-- создам студента, который нигде не будет записан, чтобы проверить корректность (в след. задании запишу ее на курс)
insert into Students(first_name, last_name, date_of_birth, email, phone_number, address, enrollment_date, gpa)
	values ('Татьяна', 'Татьянина', '2001-01-25', 'tanya@gmail.com', '8-912-925-68-85', 'ул. Моторостроителей, 148', '2022-09-01', 4.5);

select s.first_name, s.last_name, s.gpa
	from students as s
	where s.student_id in (select e.student_id from enrollments as e)
	order by s.gpa asc;

-- Получите список студентов, которые были зачислены на курсы в течение последнего года
-- Добавим студента .который был записан на курсы в течение последнего года
insert into Enrollments (student_id, course_id, enrollment_date, grade) 
	values (6, 1, '2023-12-01', 3);

select s.first_name, s.last_name, e.enrollment_date
	from students as s
	join enrollments as e on e.student_id = s.student_id
	where e.enrollment_date > now() - interval '365 day';

-- Получите список студентов и их количество курсов, на которые они зачислены, отсортированный по количеству курсов
select s.first_name, s.last_name, count(distinct e.course_id) as count_course
	from students as s
	join enrollments as e on e.student_id = s.student_id
	group by s.student_id
	order by count_course asc;
	