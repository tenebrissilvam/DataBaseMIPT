# Проект "Постапокалиптический бункер"

---

Имеется база данных для постапокалиптического бункера для всех спасшихся. В ней имеется информация о поселенцах, савсенных животных,
медикаментах, провианте, распределению по комнатам для отдыха, заданиях и обородувании, используемом для заданий. Также в ней отслеживается
расписание отдыха, распределение текущих задач и история уже завершенных поселенцами.

`cd.person`  
У каждого участника есть идентификатор (не обязательно последовательный), основная информация об адресе, ссылка на
участника, который рекомендовал их (если есть), и отметка времени, когда они присоединились.

`cd.animal`  
В таблице перечислены все доступные для бронирования объекты, которыми располагает загородный клуб. Клуб хранит
информацию об идентификаторе/имени, стоимости бронирования как членов, так и гостей, первоначальную стоимость строительства объекта и предполагаемые ежемесячные расходы на содержание.

`cd.sleep_schedule`  
И таблица, отслеживающая бронирование объектов. В нем хранится идентификатор объекта, член, который сделал бронирование,
начало бронирования и количество получасовых «слотов», на которые было сделано бронирование.

`cd.medicine`  
У каждого участника есть идентификатор (не обязательно последовательный), основная информация об адресе, ссылка на
участника, который рекомендовал их (если есть), и отметка времени, когда они присоединились.

`cd.provisions`  
В таблице перечислены все доступные для бронирования объекты, которыми располагает загородный клуб. Клуб хранит
информацию об идентификаторе/имени, стоимости бронирования как членов, так и гостей, первоначальную стоимость строительства объекта и предполагаемые ежемесячные расходы на содержание.

`cd.actual_tasks`  
И таблица, отслеживающая бронирование о

`cd.tasks_history`  
У каждого участника есть идентификатор (не обязательно последовательный), основная информация об адресе, ссылка на
участника, который рекомендовал их (если есть), и отметка времени, когда они присоединились.

`cd.bedroom`  
В таблице перечислены все доступные для бронирования объекты, которыми располагает загородный клуб. Клуб хранит
информацию об идентификаторе/имени, стоимости бронирования как членов, так и гостей, первоначальную стоимость строительства объекта и предполагаемые ежемесячные расходы на содержание.

`cd.task`  
И таблица, отслеживающая бронирование объектов. В нем хранится идентификатор объекта, член, который сделал бронирование,
начало бронирования и количество получасовых «слотов», на которые было сделано бронировани

`cd.appliance`  
И таблица, отслеживающая бронирование объектов. В нем хранится идентификатор объекта, член, который сделал бронирование,
начало бронирования и количество получасовых «слотов», на которые было сделано бронирование.
---

БД имеет 2 НФ.
