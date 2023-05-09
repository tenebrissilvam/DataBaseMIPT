--функция get_storage_status возвращает количество медикаментов на складе, количество провизии
--на складе, а также суммарное количество предметов на складе

create or replace function cd.get_storage_status()
returns table
	(
		meds_storage_cnt integer,
		provs_storage_cnt integer,
		total_storage_taken integer
	)
as
$$
begin 
	return query
		select sum(m.med_cnt) as meds_storage_cnt,
			sum(p.prov_cnt) as provs_storage_cnt,
			sum(m.med_cnt) + sum(p.prov_cnt) as total_storage_taken
		from cd.medicine m, cd.provisions p;
end;
$$ language plpgsql;



--процедура radiation_event принимает на вход число, равное количеству радиации, которое получат 
--все поселенцы после аварии и автоматически удаляет из таблицы погибших от высокого уровня радиации
--(т.е. всех, у кого после аварии значение поля radiation_level >= 100)

create or replace procedure cd.radiation_event(rad integer)
as 
$$
begin
	update cd.person p
		set p.radiation_level = case 
									when p.radiation_level + rad <= 100 then p.radiation_level = p.radiation_level + rad
									else p.radiation_level = 100
									
								end;
	delete 
	from cd.person p
	where p.radiation_level = 100;
end;
$$ language plpgsql;
	
	
