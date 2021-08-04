drop table dw.dim_times cascade constraints;

/*==============================================================*/
/* Table: dim_times                                           */
/*==============================================================*/
create table dw.dim_times 
(
   time_id            DATE                 not null,
   year_calendar      NUMBER(4),
   year_days_cnt      NUMBER(3),
   quarter_number     NUMBER(1),
   quarter_days_cnt   NUMBER(3),
   quarter_begin_dt   DATE,
   quarter_end_dt     DATE,
   quarter_number2    NUMBER(2),
   month_name         VARCHAR2(30),
   month_days_cnt     NUMBER(2),
   week_number        NUMBER(1),
   week_begin_dt      DATE,
   week_end_dt        DATE,
   day_name_week      VARCHAR2(30),
   day_number_week    NUMBER(1),
   day_number_year    NUMBER(3),
   constraint PK_DIM_TIMES primary key (time_id)
);