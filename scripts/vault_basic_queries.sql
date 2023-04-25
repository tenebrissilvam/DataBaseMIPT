--CRUD - Sreate, Read, Update, Delete

select * from cd.animal a ;

--Create:

insert into cd.person (person_id, surname, firstname, responsibility, radiation_level, taking_medicine, consuming_prov, pet_id, stamina)
values (600, 'Wright', 'Edgar', 'Handyman', 80, 6, 87, 14, 36);

insert into cd.animal (anim_id, pet_name, animal_type, fighting_strength)
values (601, 'Hachiko', 'dog', 15);

insert into cd.medicine (med_id, med_type, restores_rad, med_cnt)
values (602, 'X-cell', 65, 20);

--Read:

select surname, firstname from cd.person p where responsibility = 'Mercenary';

select med_type from cd.medicine m where restores_rad > 100;

select prov_type from cd.provisions p where nutritional_val > 100 and nutritional_val < 180;

--Update:

update cd.medicine set med_cnt = 100 where med_id = 2;

update cd.animal set fighting_strength = 55 where animal_type = 'cat' and fighting_strength < 55;

--Delete:

delete from cd.person where radiation_level > 90;

delete from cd.bedroom where bedroom_id = 105;