--Вывести имена и фамилии всех владельцов енотов и клички енотов, в порядке убывания боевой силы животного

select p.firstname ||' '|| p.surname as person, a.pet_name, a.fighting_strength
from cd.person p right join cd.animal a on p.pet_id = a.anim_id
where animal_type = 'raccoon'
order by fighting_strength DESC;

--Вывести названия медикаментов и количество человек, которое принимает каждый из них в порядке убывания количества употребляющих

select m.med_type, count(*) as count
from cd.person p join cd.medicine m on p.taking_medicine = m.med_id
group by med_id
order by count desc;

--Вывести обязанности людей, которые завершили задания в период с 10 по 15 января 1999 года

select p.responsibility
from cd.person p join cd.task_history th on p.person_id = th.executor
where th.task_ended >= '1999-01-10 00:00:00' and th.task_ended < '1999-01-16 00:00:00'
group by p.responsibility;

--Вывести имена и фамилии людей, указанных в таблице сна, и количество восстановленных единиц сил, а также среднее по обязанности. Отсортировать в порядке возрастрания

select p.firstname ||' '|| p.surname as person, date_part('hour', ss.sleep_ended - ss.sleep_started) * b.res_stamina  as restored,
avg(date_part('hour', ss.sleep_ended - ss.sleep_started) * b.res_stamina) over(partition by p.responsibility) as average
from cd.person p join sleep_schedule ss on p.person_id = ss.person_id join cd.bedroom b on ss.room_id = b.bedroom_id
order by average, restored;

--Для каждой из обязанностей вывести наиболее популярную для потребления провизию с количеством человек ее потребляющую

select sub.responsibility, sub.prov_type as top_food, sub.common_food as counter
from (
	select ps.responsibility, pr.prov_type, count(*) as common_food, row_number()
	over (partition by ps.responsibility order by count(*) desc) as row_num 
	from cd.person ps join cd.provisions pr on ps.consuming_prov = pr.prov_id
	group by ps.responsibility, pr.prov_type
) as sub
where sub.row_num = 1
order by responsibility;

--Для текущих заданий вывести для каждого имя и фамилию исполнителя и указать, сколько единиц сил ему не хватает для исполнения. В случае если сил хватает вывести 0
--Распределить на категории состояния здоровья на основе уровня радиации, где 'low risk' при уровне облучения 0-30, 'moderate risk' при 31-70 и 'high risk' при 71-100

select p.firstname ||' '|| p.surname as person, 
	case
		when p.stamina < a.stamina_req then a.stamina_req - p.stamina
		when p.stamina >= a.stamina_req then 0
	end stamina_restoration_req,
	case 
		when p.radiation_level <= 30 then 'low risk'
		when p.radiation_level > 30 and p.radiation_level <= 70 then 'moderate risk'
		when p.radiation_level > 70 then 'high risk'
	end risk
from cd.task t  
join cd.appliance a on t.appl_id  = a.appl_id 
join cd.actual_tasks at2 on at2.task_id = t.task_id
join cd.person p on p.person_id = at2.executor;




