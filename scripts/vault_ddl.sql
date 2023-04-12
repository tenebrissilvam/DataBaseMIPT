create schema if not exists cd;

CREATE TABLE cd.person(
   person_id          INTEGER                  NOT null,
   surname            CHARACTER VARYING(200)   NOT NULL,
   firstname          CHARACTER VARYING(200)   NOT NULL,
   responsibility     CHARACTER VARYING(300)   NOT NULL,
   radiation_level    NUMERIC                  NOT NULL CHECK (radiation_level >= 0 and radiation_level <= 100),
   taking_medicine    INTEGER                  NOT NULL,
   consuming_prov     INTEGER			       NOT NULL,
   pet_id             INTEGER                  NOT NULL,
   stamina            NUMERIC                  NOT NULL CHECK (stamina >= 0 and stamina <= 100),
   CONSTRAINT person_pk PRIMARY KEY (person_id),
   CONSTRAINT fk_medicine FOREIGN KEY (taking_medicine)
       REFERENCES cd.medicine(med_id) ON DELETE SET NULL,
   CONSTRAINT fk_provisions FOREIGN KEY (consuming_prov)
       REFERENCES cd.provisions(prov_id) ON DELETE SET NULL,
   CONSTRAINT fk_animal FOREIGN KEY (pet_id)
       REFERENCES cd.animal(anim_id) ON DELETE SET NULL
);

CREATE TABLE cd.task(
   task_id          INTEGER                  NOT NULL,
   task_type        CHARACTER VARYING(200)   NOT NULL,
   med_prod         INTEGER                  NOT NULL CHECK (med_prod >= 0),
   prov_prod        INTEGER			         NOT NULL CHECK (prov_prod >= 0),
   appl_id          INTEGER			         NOT NULL,
   task_duration    TIMESTAMP                NOT NULL,
   animal_flg       INTEGER                  NOT NULL,
   CONSTRAINT task_pk PRIMARY KEY (task_id),
   CONSTRAINT fk_medicine FOREIGN KEY (med_prod)
       REFERENCES cd.medicine(med_id) ON DELETE SET NULL,
   CONSTRAINT fk_provisions FOREIGN KEY (prov_prod)
       REFERENCES cd.provisions(prov_id) ON DELETE SET NULL,
   CONSTRAINT fk_appliance FOREIGN KEY (appl_id)
       REFERENCES cd.appliance(appl_id) ON DELETE SET NULL
);


CREATE TABLE cd.animal(
   anim_id     INTEGER   NOT NULL, 
   pet_name    CHARACTER VARYING(50)   NOT NULL, 
   animal_type    CHARACTER VARYING(50)   NOT NULL, 
   fighting_strength  NUMERIC NOT NULL CHECK (fighting_strength >= 0),
   
   CONSTRAINT animal_pk PRIMARY KEY (anim_id)
);

CREATE TABLE cd.medicine(
   med_id               INTEGER                NOT NULL, 
   med_type             CHARACTER VARYING(100) NOT NULL, 
   restores_rad         NUMERIC                NOT NULL CHECK (restores_rad >= 0), 
   med_cnt              INTEGER                NOT NULL CHECK (med_cnt >= 0), 
   
   CONSTRAINT medicine_pk PRIMARY KEY (med_id)
);


CREATE TABLE cd.provisions(
   prov_id              INTEGER                  NOT NULL, 
   prov_type            CHARACTER VARYING(100)   NOT NULL, 
   prov_cnt             INTEGER                  NOT NULL CHECK (prov_cnt >= 0), 
   nutritional_val      NUMERIC                  NOT NULL CHECK (nutritional_val >= 0),
   
   CONSTRAINT provisions_pk PRIMARY KEY (prov_id)
);

CREATE TABLE cd.appliance(
   appl_id              INTEGER                NOT NULL, 
   appl_type            CHARACTER VARYING(100) NOT NULL, 
   stamina_req          NUMERIC                NOT NULL CHECK (stamina_req >= 0),
   
   CONSTRAINT appliance_pk PRIMARY KEY (appl_id)
);

CREATE TABLE cd.bedroom(
   bedroom_id           INTEGER                NOT NULL, 
   bed_cnt              INTEGER                NOT NULL CHECK (bed_cnt >= 0), 
   res_stamina          NUMERIC                NOT NULL CHECK (res_stamina >= 0), 
   CONSTRAINT bedroom_pk PRIMARY KEY (bedroom_id)
);

CREATE TABLE cd.actual_tasks(
   executor               INTEGER                NOT NULL UNIQUE, 
   task_id                INTEGER                NOT NULL, 
   CONSTRAINT fk_person FOREIGN KEY (executor)
       REFERENCES cd.person(person_id) ON DELETE SET NULL,
   CONSTRAINT fk_task FOREIGN KEY (task_id)
       REFERENCES cd.task(task_id) ON DELETE SET NULL
);

CREATE TABLE cd.task_history(
   executor             INTEGER                NOT NULL, 
   task_id              INTEGER                NOT NULL, 
   task_started         TIMESTAMP              NOT NULL, 
   task_ended           TIMESTAMP              NOT NULL, CHECK (task_started < task_ended),
   CONSTRAINT fk_person FOREIGN KEY (executor)
       REFERENCES cd.person(person_id) ON DELETE SET NULL,
   CONSTRAINT fk_task FOREIGN KEY (task_id)
       REFERENCES cd.task(task_id) ON DELETE SET NULL
);

CREATE TABLE cd.sleep_schedule(
   person_id             INTEGER           NOT NULL, 
   room_id               INTEGER           NOT NULL, 
   sleep_started         TIMESTAMP         NOT NULL, 
   sleep_ended           TIMESTAMP         NOT NULL, 

   CHECK (sleep_started < sleep_ended),
   
   CONSTRAINT fk_person FOREIGN KEY (person_id)
       REFERENCES cd.person(person_id) ON DELETE SET NULL,

   CONSTRAINT fk_bedroom FOREIGN KEY (room_id)
       REFERENCES cd.bedroom(bedroom_id) ON DELETE SET NULL
);




