--Сокрытие уровня облучения и принимаемого медикамента при просмотре информации о человеке 
--в представлении люди будут отсортированы по фамилии и имени в алфавитном порядке


create or replace view cd.person_info_view as
select p.surname,
	firstname,
	responsibility,
	consuming_prov,
	pet_id,
	stamina,
	'***' ||''|| radiation_level %  10 as rad_masked,
	substring(m.med_type from 1 for 1) ||''|| '***' as medicine_masked
from cd.person p join cd.medicine m on p.taking_medicine = m.med_id 
order by surname, firstname;

select * from cd.person_info_view;

--Сокрытие количества предметов на складе для медикаментов и провизии. В представлении 
--медикаменты будут отсортированы по количеству излечения радиации, а провизия по количеству восстановления сил

create view cd.medicine_info_view as
select med_type,
	restores_rad
from cd.medicine m 
order by restores_rad desc;

select * from cd.medicine_info_view;

create view cd.provisions_info_view as
select prov_type,
	nutritional_val
from cd.provisions p  
order by nutritional_val desc;

select * from cd.provisions_info_view;


--Сводная таблица с количеством заданий, выполненным каждым человеком и суммарным числом часов работы

create view cd.tasks_per_person as
select sub.firstname ||' '|| sub.surname as person, 
sub.completed_tasks as completed, sub.working_hours
from (
	select p.person_id, p.firstname, p.surname, 
	count(*) as completed_tasks, 
	sum(t.task_duration) as working_hours, 
	row_number()
	over (partition by p.person_id order by count(*) desc) as row_num
	from cd.person p join cd.task_history th on th.executor = p.person_id
	join cd.task t on t.task_id = th.task_id 
	group by p.person_id
) as sub
order by completed desc, working_hours desc;

select * from cd.tasks_per_person;

--Сводная таблица со среднем уровнем облучения и запаса сил по каждой обязанности

create view cd.mean_stats_by_responsibility as
select
p.responsibility, 
avg(p.radiation_level) as mean_radiation,
avg(p.stamina) as mean_stamina
from cd.person p 
group by p.responsibility
order by mean_radiation, mean_stamina desc;

select * from cd.mean_stats_by_responsibility;

--Сводная таблица с количестовом выполненных заданий на каждом оборудовании и суммарное количество 
--часов его работы

create view cd.tasks_per_appliance as
select sub.appl_type, sub.completed_tasks as completed,
sub.working_hours
from (
	select a.appl_id,
	a.appl_type,
	count(*) as completed_tasks, 
	sum(t.task_duration) as working_hours,
	row_number()
	over (partition by a.appl_id order by count(*) desc) as row_num
	from cd.task_history th join cd.task t on t.task_id = th.task_id
	join cd.appliance a on t.appl_id = a.appl_id
	group by a.appl_id
) as sub
order by completed desc, working_hours desc;

select * from cd.tasks_per_appliance;
