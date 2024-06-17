-- Удаление
delete from students
	where student_id = 4;

select * from students;

-- Сначала создам курс, на который никто не записан, чтобы на нем тестить
insert into courses (course_name, description, credits, department) 
	values ('Блаблабла', null, 5, 'Астрология');  

select * from courses;

-- Здесь идет проверка на то, что id курса отсутствует в enrollments
delete from courses
	where course_id not in (select e.course_id from enrollments as e);

-- В таблице enrollments недопустимо, чтобы student_id = null, 
-- так что проверка на наличие null в student_id для вычисления курса,
-- на котором никого нет бессмысленна 
