--drop tablespace ts_dw_data including contents and datafiles cascade constraints;

create tablespace ts_dw_data_zkh
datafile '/oracle/u02/oradata/DMORCL19DB/yzhdanovich_db/db_dw_data_zkh.dat'
size 150m autoextend on next 50m logging segment space management auto;

create user dw_data_zkh identified by dw_data_zkh123 default tablespace ts_dw_data_zkh;

grant dba to dw_data_zkh;

grant select on dw_cl_zkh.dw_cl_regions to dw_data_zkh;
/*==============================================================*/
/* table: dw_regions_data                                       */
/*==============================================================*/
create table dw_data_zkh.dw_regions_data
(
  region_id   number(10) not null,
  region_name varchar2(128) not null,
  insert_dt   date not null,
  update_dt   date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_regions_data
  add constraint pk_dw_regions_data primary key (region_id);

--drop sequence seq_customers;
create sequence sq_regions start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_cityes_data;

grant select on dw_cl_zkh.dw_cl_cityes to dw_data_zkh;
/*==============================================================*/
/* table: dw_cityes_data                                        */
/*==============================================================*/
create table dw_data_zkh.dw_cityes_data
(
  city_id     number(10) not null,
  city_name   varchar2(100) not null,
  region_id   number(10) not null,
  insert_dt   date not null,
  update_dt   date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_cityes_data
  add constraint pk_dw_cityes_data primary key (city_id);

--drop sequence seq_customers;
create sequence sq_cityes start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_streets_data;

grant select on dw_cl_zkh.dw_cl_streets to dw_data_zkh;
/*==============================================================*/
/* table: dw_cl_streets                                            */
/*==============================================================*/
create table dw_data_zkh.dw_streets_data
(
  street_id   number(10) not null,
  street_name varchar2(150) not null,
  city_id     number(10) not null,
  region_id   number(10) not null,
  insert_dt   date not null,
  update_dt   date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_streets_data
  add constraint pk_dw_streets_data primary key (street_id);

--drop sequence sq_streets;
create sequence sq_streets start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_houses_data;

grant select on dw_cl_zkh.dw_cl_houses to dw_data_zkh;
/*==============================================================*/
/* table: dw_houses_data                                        */
/*==============================================================*/
create table dw_data_zkh.dw_houses_data
(
  house_id    number(10) not null,
  house_no    varchar2(10) not null,
  street_id   number(10) not null,
  city_id     number(10) not null,
  region_id   number(10) not null,
  insert_dt   date not null,
  update_dt   date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_houses_data
  add constraint pk_dw_houses_data primary key (house_id);

--drop sequence seq_houses;
create sequence sq_houses start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_payers_data;

grant select on dw_cl_zkh.dw_cl_payers to dw_data_zkh;
/*==============================================================*/
/* table: dw_payers_data                                        */
/*==============================================================*/
create table dw_data_zkh.dw_payers_data
(
  payer_id    number(10) not null,
  payer_fio   varchar2(100) not null,
  payer_noid  varchar2(14)  not null,
  insert_dt   date not null,
  update_dt   date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_payers_data
  add constraint pk_dw_payers_data primary key (payer_id);

--drop sequence seq_payers;
create sequence sq_payers start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_paysystems_data;

/*==============================================================*/
/* table: dw_paysystems_data                                    */
/*==============================================================*/
grant select on dw_cl_zkh.dw_cl_paysystems to dw_data_zkh;
create table dw_data_zkh.dw_paysystems_data
(
  paysystem_id   number(10) not null,
  paysystem_name varchar2(100) not null,
  insert_dt      date not null,
  update_dt      date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_paysystems_data
  add constraint pk_dw_paysystems_data primary key (paysystem_id);

--drop sequence seq_paysystems;
create sequence sq_paysystems start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_providers_data;

grant select on dw_cl_zkh.dw_providers_data to dw_data_zkh;
/*==============================================================*/
/* table: dw_providers_data                                     */
/*==============================================================*/
create table dw_data_zkh.dw_providers_data
(
  provider_id      number(10) not null,
  provider_name    varchar2(200) not null,
  provider_hier_id number(10),
  insert_dt        date not null,
  update_dt        date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_providers_data
  add constraint pk_dw_providers_data primary key (provider_id);

--drop sequence seq_providers;
create sequence sq_providers start with 1 increment by 1 nocache nocycle;

--drop table dw_cl_zkh.dw_service_objects_data;

grant select on dw_cl_zkh.dw_cl_service_objects to dw_data_zkh;
/*==============================================================*/
/* table: dw_service_objects_data                               */
/*==============================================================*/
create table dw_data_zkh.dw_service_objects_data
(
  service_object_id   number(10) not null,
  service_object_name varchar2(200) not null,
  insert_dt           date not null,
  update_dt           date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_service_objects_data
  add constraint pk_dw_service_objects_data primary key (service_object_id);

--drop sequence seq_providers;
create sequence sq_service_objects start with 1 increment by 1 nocache nocycle;

--drop table dw_cl_zkh.dw_services_data;

grant select on dw_cl_zkh.dw_cl_services to dw_data_zkh;
/*==============================================================*/
/* table: dw_services_data                                      */
/*==============================================================*/
create table dw_data_zkh.dw_services_data
(
  service_id      number(10) not null,
  service_name    varchar2(128)  not null,
  service_hier_id number(10),
  insert_dt       date not null,
  update_dt       date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_services_data
  add constraint pk_dw_services_data primary key (service_id);

--drop sequence sq_services;
create sequence sq_services start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_gen_geo_hist;

/*==============================================================*/
/* table: dw_gen_geo_hist                                       */
/*==============================================================*/
create table dw_data_zkh.dw_gen_geo_hist
(
  geo_surr_id number(10) not null,
  geo_id      number(10) not null,
  house_id    number(10) not null,
  street_id   number(10) not null,
  city_id     number(10) not null,
  region_id   number(10) not null,
  payer_id    number(10) not null,
  is_active   char(1) default '1' check (is_active in ('0','1')),
  valid_from  date not null,
  valid_to    date,
  insert_dt   date not null,
  update_dt   date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_gen_geo_hist
  add constraint pk_dw_gen_geo_hist primary key (geo_id,valid_from);

--drop sequence sq_geo_hist;
create sequence sq_geo_hist start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_gen_geo_data;

/*==============================================================*/
/* table: dw_gen_geo_data                                        */
/*==============================================================*/
create table dw_data_zkh.dw_gen_geo_data
(
  geo_id      number(10) not null,
  house_id    number(10) not null,
  street_id   number(10) not null,
  city_id     number(10) not null,
  region_id   number(10) not null,
  payer_id    number(10) not null,
  insert_dt   date not null,
  update_dt   date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_gen_geo_data
  add constraint pk_dw_gen_geo_data primary key (geo_id);

--drop sequence sq_geo;
create sequence sq_geo start with 1 increment by 1 nocache nocycle;

--drop table dw_data_zkh.dw_payments_data;

grant select on dw_cl_zkh.dw_cl_payments to dw_data_zkh;
/*==============================================================*/
/* table: dw_payments_data                                        */
/*==============================================================*/
create table dw_data_zkh.dw_payments_data
(
  payment_id        number(10) not null,
  paysystem_id      number(10) not null,
  provider_id       number(10) not null,
  service_id        number(10) not null,
  service_object_id number(10) not null,
  geo_id            number(10) not null,
  date_issue_dt     date                 not null,
  date_pay_dt       date                 not null,
  sum_issue         number(10,2) not null,
  sum_pay           number(10,2),
  insert_dt         date not null,
  update_dt         date
)
tablespace ts_dw_data_zkh;

alter table dw_data_zkh.dw_payments_data
  add constraint pk_dw_payments_data primary key (payment_id);

--drop sequence sq_payments;
create sequence sq_payments start with 1 increment by 1 nocache nocycle;

