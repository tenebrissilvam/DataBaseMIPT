--В этих трех сводных таблицах часто будет использоваться поле, связанное с
--идентификатором человека, который выполнял действие, поэтому создадим по этому полю
--индекс в каждой из таблиц

create index idx_executor_id
	on cd.actual_tasks
	using btree
	(executor);

create index idx_execitor_id
	on cd.task_history
	using btree
	(executor);

create index idx_person_id
	on cd.sleep_schedule
	using btree
	(person_id);

--Также часто будут обращаться к полю с идентификатором задания, так что 
--по нему в сводных таблицах также стоит создать индекс

create index idx_task_id
	on cd.actual_tasks
	using btree
	(task_id);

create index idx_task_idx 
	on cd.task_history
	using btree
	(task_id);

--Также часто может использоваться поле с ноером мпальни, поэтому по нему тоже
--стоит создать индекс

create index idx_room_id
	on cd.sleep_schedule
	using btree
	(room_id);
	
--Индекс по дате начала и индекс по дате завершения задания в таблице с историей заданий 

create index idx_starting_time_id
	on cd.task_history
	using btree
	(task_started);

create index idx_ending_time_id
	on cd.task_history 
	using btree
	(task_ended);

--Индекс по id животных

create index idx_anim_id 
	on cd.animal 
	using btree
	(anim_id);