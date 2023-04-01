# Физическая модель

---

Таблица `person`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `person_id`         | Идентификатор      | `INTEGER`      | `PRIMARY KEY` |
| `surname`           | Фамилия поселенца  | `VARCHAR(200)` | `NOT NULL`    |
| `firstname`         | Имя поселенца      | `VARCHAR(200)` | `NOT NULL`    |
| `responsibility`         | описание обязанности  | `VARCHAR(200)` | `NOT NULL`    |
| `radiation_level`   | уровень поглощенной радиации      | `NUMERIC` | `NOT NULL`    |
| `taking_medicine`       | принимаемый препарат    | `INTEGER`      | `FOREIGN KEY`    |
| `consuming_prov`     | потребляемый провиант     | `INTEGER`  | `FOREIGN KEY`    |
| `pet_id` | ручное животное   | `INTEGER`      | `FOREIGN KEY` |
| `stamina`      | уровень запаса сил | `NUMERIC`    | `NOT NULL`    |

Таблица `task`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `task_id`    | Идентификатор задания     | `INTEGER`      | `PRIMARY KEY` |
| `task_type`  | Тип задания  | `VARCHAR(200)` | `NOT NULL`    |
| `med_prod`   | По завершении производит медикамент      | `INTEGER` | `FOREIGN_KEY`    |
| `prov_prod`    | По завершении производит провиант  | `INTEGER` | `FOREIGN_KEY`    |
| `appl_id`   | Используемое при выполнении оборудование      | `INTEGER` | `FOREIGN KEY`    |
| `task_duration`   | Продолжительность выполнения    | `TIMESTAMP` | `NOT NULL`    |
| `animal_flg` | Флаг требуется ли для выполнения животное     | `INTEGER`  | `NOT NULL`   |

Таблица `animal`:

| Название             | Описание         | Тип данных     | Ограничение   |
|----------------------|------------------|----------------|---------------|
| `anim_id`   | Идентификатор     | `INTEGER`      | `PRIMARY KEY` |
| `pet_name`  | Имя животного | `VARCHAR(100)` | `NOT NULL`    |
| `animal_type`  | Вид животного  | `VARCHAR(100)`      | `NOT NULL`    |
| `fighting_strength`   | Боевая сила     | `NUMERIC`      | `NOT NULL`    |

---
Таблица `medicine`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `med_id`    | Идентификатор препарата             | `INTEGER`   | `PRIMARY KEY` |
| `med_type`     | Тип препарата           | `VARCHAR(100)`   | `NOT NULL` |
| `restores_rad`     | Восстаналивает единиц радиации             | `NUMERIC`   | `NOT NULL` |
| `med_cnt` | Количество препарата на складе                    | `INTEGER` | `NOT NULL`    |


Таблица `provisions`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `prov_id`    | Идентификатор провианта             | `INTEGER`   | `PRIMARY KEY` |
| `prov_type`     | Тип провианта           | `VARCHAR(100)`   | `NOT NULL` |
| `nutritional_val`     | Восстаналивает единиц запаса сил             | `NUMERIC`   | `NOT NULL` |
| `prov_cnt` | Количество провианта на складе                    | `INTEGER` | `NOT NULL`    |


Таблица `appliance`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `appl_id`    | Идентификатор оборудования   | `INTEGER`   | `PRIMARY KEY` |
| `appl_type`     | Тип оборудования           | `VARCHAR(100)`   | `NOT NULL` |
| `stamina_req`     | Требуемый запас сил для использования     | `NUMERIC`   | `NOT NULL` |


Таблица `bedroom`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `bedroom_id`    | Идентификатор комнаты отдыха             | `INTEGER`   | `PRIMARY KEY` |
| `res_stamina`     | Восстаналивает единиц запаса сил             | `NUMERIC`   | `NOT NULL` |
| `bed_cnt` | Количество коек в комнате                    | `INTEGER` | `NOT NULL`    |
---
Таблица `actual_tasks`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `executor`    |   id поселенца, исполняющего задание   | `INTEGER`   | `FOREIGN KEY` |
| `task_id`     | id исполняемого задания   | `INTEGER`   | `FOREIGN KEY` |

Таблица `task_history`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `executor`    |   id поселенца, исполняющего задание   | `INTEGER`   | `FOREIGN KEY` |
| `task_id`     | id исполняемого задания   | `INTEGER`   | `FOREIGN KEY` |
| `task_started`     | Время начала задания   | `TIMESTAMP`   | `NOT NULL` |
| `task_ended`     | Время завершения задания   | `TIMESTAMP`   | `NOT NULL` |

Таблица `sleep_schedule`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `person_id`    |   id отдыхающего поселенца   | `INTEGER`   | `FOREIGN KEY` |
| `room_id`     | id комнаты отдыха | `INTEGER`   | `FOREIGN KEY` |
| `sleep_started`     | Время начала сна   | `TIMESTAMP`   | `NOT NULL` |
| `sleep_ended`     | Время завершения сна   | `TIMESTAMP`   | `NOT NULL` |

---
Таблица `person`:
```postgresql
CREATE TABLE cd.person(
   person_id          INTEGER                  NOT NULL,
   surname            CHARACTER VARYING(200)   NOT NULL,
   firstname          CHARACTER VARYING(200)   NOT NULL,
   responsibility     CHARACTER VARYING(300)   NOT NULL,
   radiation_level    NUMERIC                  NOT NULL,
   taking_medicine    INTEGER                  NOT NULL,
   consuming_prov     INTEGER			       NOT NULL,
   pet_id             INTEGER                  NOT NULL,
   stamina            NUMERIC                  NOT NULL,

   CONSTRAINT person_pk PRIMARY KEY (person_id),

   CONSTRAINT fk_medicine FOREIGN KEY (taking_medicine)
       REFERENCES cd.medicine(med_id) ON DELETE SET NULL,
       
   CONSTRAINT fk_provisions FOREIGN KEY (consuming_prov)
       REFERENCES cd.provisions(prov_id) ON DELETE SET NULL,

   CONSTRAINT fk_animal FOREIGN KEY (pet_id)
       REFERENCES cd.animal(anim_id) ON DELETE SET NULL
);
```
Таблица `task`:
```postgresql
CREATE TABLE cd.task(
   task_id          INTEGER                  NOT NULL,
   task_type        CHARACTER VARYING(200)   NOT NULL,
   med_prod         INTEGER                  NOT NULL,
   prov_prod        INTEGER			         NOT NULL,
   appl_id          INTEGER			         NOT NULL,
   task_duration    TIMESTAMP                NOT NULL,
   animal_flg       INTEGER                  NOT NULL,

   CONSTRAINT task_pk PRIMARY KEY (task_id),

   CONSTRAINT fk_medicine FOREIGN KEY (med_prod)
       REFERENCES cd.medicine(med_id) ON DELETE SET NULL,
       
   CONSTRAINT fk_provisions FOREIGN KEY (prov_prod)
       REFERENCES cd.provisions(prov_id) ON DELETE SET NULL,

   CONSTRAINT fk_appliance FOREIGN KEY (appl_id)
       REFERENCES cd.animal(appl_id) ON DELETE SET NULL
);
```
Таблица `animal`:
```postgresql
CREATE TABLE cd.animal(
   anim_id     INTEGER   NOT NULL, 
   pet_name    CHARACTER VARYING(50)   NOT NULL, 
   animal_type    CHARACTER VARYING(50)   NOT NULL, 
   fighting_strength  NUMERIC NOT NULL
);
```
---

Таблица `medicine`:
```postgresql
CREATE TABLE cd.facilities(
   med_id               INTEGER                NOT NULL, 
   med_type             CHARACTER VARYING(100) NOT NULL, 
   restores_rad         NUMERIC                NOT NULL, 
   med_cnt              INTEGER                NOT NULL, 
   
   CONSTRAINT medicine_pk PRIMARY KEY (med_id)
);
```


Таблица `provisions`:
```postgresql
CREATE TABLE cd.facilities(
   prov_id              INTEGER                  NOT NULL, 
   prov_type            CHARACTER VARYING(100)   NOT NULL, 
   prov_cnt             INTEGER                  NOT NULL, 
   nutritional_val      NUMERIC                  NOT NULL, 
   
   CONSTRAINT provisions_pk PRIMARY KEY (prov_id)
);
```

Таблица `appliance`:
```postgresql
CREATE TABLE cd.appliance(
   appl_id              INTEGER                NOT NULL, 
   appl_type            CHARACTER VARYING(100) NOT NULL, 
   stamina_req          NUMERIC                NOT NULL,
   
   CONSTRAINT appliance_pk PRIMARY KEY (appl_id)
);
```


Таблица `bedroom`:
```postgresql
CREATE TABLE cd.bedroom(
   bedroom_id           INTEGER                NOT NULL, 
   bed_cnt              INTEGER                NOT NULL, 
   res_stamina          NUMERIC                NOT NULL, 
   
   CONSTRAINT bedroom_pk PRIMARY KEY (bedroom_pk)
);
```
---

Таблица `actual_tasks`:
```postgresql
CREATE TABLE cd.actual_tasks(
   executor               INTEGER                NOT NULL, 
   task_id                INTEGER                NOT NULL, 
  
   CONSTRAINT fk_person FOREIGN KEY (executor)
       REFERENCES cd.person(person_id) ON DELETE SET NULL,

   CONSTRAINT fk_task FOREIGN KEY (task_id)
       REFERENCES cd.bedroom(task_id) ON DELETE SET NULL
);
```


Таблица `task_history`:
```postgresql
CREATE TABLE cd.task_history(
   executor             INTEGER                NOT NULL, 
   task_id              INTEGER                NOT NULL, 
   task_started         TIMESTAMP              NOT NULL, 
   task_ended           TIMESTAMP              NOT NULL, 
  
   CONSTRAINT fk_person FOREIGN KEY (executor)
       REFERENCES cd.person(person_id) ON DELETE SET NULL,

   CONSTRAINT fk_task FOREIGN KEY (task_id)
       REFERENCES cd.bedroom(task_id) ON DELETE SET NULL
);
```

Таблица `sleep_schedule`:
```postgresql
CREATE TABLE cd.sleep_schedule(
   person_id             INTEGER           NOT NULL, 
   room_id               INTEGER           NOT NULL, 
   sleep_started         TIMESTAMP         NOT NULL, 
   sleep_ended           TIMESTAMP         NOT NULL, 
   
   CONSTRAINT fk_person FOREIGN KEY (person_id)
       REFERENCES cd.person(person_id) ON DELETE SET NULL,

   CONSTRAINT fk_bedroom FOREIGN KEY (room_id)
       REFERENCES cd.bedroom(bedroom_id) ON DELETE SET NULL
);
```
