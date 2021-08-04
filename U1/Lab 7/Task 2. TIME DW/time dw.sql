alter table "dw"."time"
   drop constraint FK_TIME_REFERENCE_T_MONTHS;

alter table "dw"."time"
   drop constraint FK_TIME_REFERENCE_T_QUATER;

alter table "dw"."time"
   drop constraint FK_TIME_REFERENCE_T_YEARS;

alter table "dw"."time"
   drop constraint FK_TIME_REFERENCE_T_DAYS;

alter table "dw"."time"
   drop constraint FK_TIME_REFERENCE_T_WEEKS;

drop table "dw"."time" cascade constraints;
drop table "dw"."t_days" cascade constraints;
drop table "dw"."t_months" cascade constraints;
drop table "dw"."t_quaters" cascade constraints;
drop table "dw"."t_weeks" cascade constraints;
drop table "dw"."t_years" cascade constraints;

/*==============================================================*/
/* Table: "time"                                                */
/*==============================================================*/
create table "dw"."time" 
(
   "time_id"            NUMBER(22)           not null,
   "day_id"             NUMBER(22),
   "week_id"            NUMBER(22),
   "month_id"           NUMBER(22),
   "quater_id"          NUMBER(22),
   "quarter_id"         NUMBER(22),
   "year_id"            NUMBER(22),
   constraint PK_TIME primary key ("time_id")
);

alter table "dw"."time"
   add constraint FK_TIME_REFERENCE_T_MONTHS foreign key ("month_id")
      references "dw"."t_months" ("month_id");

alter table "dw"."time"
   add constraint FK_TIME_REFERENCE_T_QUATER foreign key ("quater_id")
      references "dw"."t_quaters" ("quater_id");

alter table "dw"."time"
   add constraint FK_TIME_REFERENCE_T_YEARS foreign key ("year_id")
      references "dw"."t_years" ("year_id");

alter table "dw"."time"
   add constraint FK_TIME_REFERENCE_T_DAYS foreign key ("day_id")
      references "dw"."t_days" ("day_id");

alter table "dw"."time"
   add constraint FK_TIME_REFERENCE_T_WEEKS foreign key ("week_id")
      references "dw"."t_weeks" ("week_id");

/*==============================================================*/
/* Table: "t_days"                                              */
/*==============================================================*/
create table "dw"."t_days" 
(
   "day_id"             NUMBER(22)           not null,
   "day_name"           VARCHAR2(30),
   "day_number_week"    NUMBER(1),
   "day_number_month"   NUMBER(2),
   "day_number_year"    NUMBER(3),
   constraint PK_T_DAYS primary key ("day_id")
);

/*==============================================================*/
/* Table: "t_months"                                            */
/*==============================================================*/
create table "dw"."t_months" 
(
   "month_id"           NUMBER(22)           not null,
   "month_number"       NUMBER(2),
   "month_name"         VARCHAR2(30),
   "month_days_cnt"     NUMBER(3),
   constraint PK_T_MONTHS primary key ("month_id")
);

/*==============================================================*/
/* Table: "t_quaters"                                           */
/*==============================================================*/
create table "dw"."t_quaters" 
(
   "quater_id"          NUMBER(22)           not null,
   "quater_number"      NUMBER(1),
   "quater_days_cnt"    NUMBER(2),
   "quater_begin_dt"    DATE,
   "quater_end_dt"      DATE,
   constraint PK_T_QUATERS primary key ("quater_id")
);

/*==============================================================*/
/* Table: "t_weeks"                                             */
/*==============================================================*/
create table "dw"."t_weeks" 
(
   "week_id"            NUMBER(22)           not null,
   "week_number"        NUMBER(2),
   "week_end_dt"        DATE,
   constraint PK_T_WEEKS primary key ("week_id")
);

/*==============================================================*/
/* Table: "t_years"                                             */
/*==============================================================*/
create table "dw"."t_years" 
(
   "year_id"            NUMBER(22)           not null,
   "year_calendar"      NUMBER(4),
   "year_days_cnt"      NUMBER(3),
   constraint PK_T_YEARS primary key ("year_id")
);
