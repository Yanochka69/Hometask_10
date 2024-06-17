-- Обновление записей
update students
	set address = 'ул. Республики, 89', phone_number = '8-933-933-65-78'
	where student_id = 5;

update courses 
	set description = 'Супер-занудный курс для всех'
	where course_id = 3;

update enrollments
	set grade = 3
	where enrollment_id = 4;

select * from courses;
select * from students;
select * from enrollments;