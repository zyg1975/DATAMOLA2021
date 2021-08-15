--drop table dim_paysystems;
/*==============================================================*/
/* table: dim_paysystems                                        */
/*==============================================================*/
grant select on dw_data_zkh.dw_paysystems_data to yzhdanovich;

create table dim_paysystems
(
  paysystem_id   number(10) not null,
  paysystem_name varchar2(100) not null,
  insert_dt      date not null,
  update_dt      date,
  constraint paysystem_id_pk primary key ( paysystem_id ) enable
);

--drop table dim_providers;
/*==============================================================*/
/* table: dim_providers                                         */
/*==============================================================*/
grant select on dw_data_zkh.dw_providers_data to yzhdanovich;
create table dim_providers
(
  provider_id      number(10) not null,
  provider_name    varchar2(200) not null,
  provider_hier_id number(10),
  insert_dt        date not null,
  update_dt        date,
  constraint provider_id_pk primary key ( provider_id ) enable
)
;

--drop table dim_regions;
/*==============================================================*/
/* table: dim_regions                                           */
/*==============================================================*/
grant select on dw_data_zkh.dw_regions_data to yzhdanovich;
create table dim_regions
(
  region_id   number(10) not null,
  region_name varchar2(128) not null,
  insert_dt   date not null,
  update_dt   date,
  constraint region_id_pk primary key ( region_id ) enable
);

--drop table dim_cityes;
/*==============================================================*/
/* table: dim_cityes                                            */
/*==============================================================*/
grant select on dw_data_zkh.dw_cityes_data to yzhdanovich;
create table dim_cityes
(
  city_id     number(10) not null,
  city_name   varchar2(100) not null,
  region_id   number(10) not null,
  insert_dt   date not null,
  update_dt   date,
  constraint city_id_pk primary key ( city_id ) enable
)
;
--drop table dim_streets;
/*==============================================================*/
/* table: dim_streets                                           */
/*==============================================================*/
grant select on dw_data_zkh.dw_streets_data to yzhdanovich;
create table dim_streets
(
  street_id   number(10) not null,
  street_name varchar2(150) not null,
  city_id     number(10) not null,
  region_id   number(10) not null,
  insert_dt   date not null,
  update_dt   date,
  constraint street_id_pk primary key ( street_id ) enable
)
;
--drop table dim_houses;
/*==============================================================*/
/* table: dim_houses                                            */
/*==============================================================*/
grant select on dw_data_zkh.dw_houses_data to yzhdanovich;
create table dim_houses
(
  house_id    number(10) not null,
  house_no    varchar2(10) not null,
  street_id   number(10) not null,
  city_id     number(10) not null,
  region_id   number(10) not null,
  insert_dt   date not null,
  update_dt   date,
  constraint house_id_pk primary key ( house_id ) enable
)
;

--drop table dim_payers;
/*==============================================================*/
/* table: dim_payers                                            */
/*==============================================================*/
grant select on dw_data_zkh.dw_payers_data to yzhdanovich;
create table dim_payers
(
  payer_id    number(10) not null,
  payer_fio   varchar2(100) not null,
  payer_noid  varchar2(14)  not null,
  insert_dt   date not null,
  update_dt   date,
  constraint payer_id_pk primary key ( payer_id ) enable
)
;

--drop table dim_service_objects;
/*==============================================================*/
/* table: dim_service_objects                                   */
/*==============================================================*/
grant select on dw_data_zkh.dw_service_objects_data to yzhdanovich;
create table dim_service_objects
(
  service_object_id   number(10) not null,
  service_object_name varchar2(200) not null,
  insert_dt           date not null,
  update_dt           date,
  constraint service_object_id_pk primary key ( service_object_id ) enable
)
;

grant select on dw_data_zkh.dw_services_data to yzhdanovich;
/*==============================================================*/
/* table: dim_services                                          */
/*==============================================================*/
create table dim_services
(
  service_id      number(10) not null,
  service_name    varchar2(128)  not null,
  service_hier_id number(10),
  insert_dt       date not null,
  update_dt       date,
  constraint service_id_pk primary key ( service_id ) enable
)
;

grant select on dw_data_zkh.dw_gen_geo_data to yzhdanovich;
/*==============================================================*/
/* table: dim_geo                                               */
/*==============================================================*/
create table dim_geo
(
  geo_id      number(10) not null,
  house_id    number(10) not null,
  street_id   number(10) not null,
  city_id     number(10) not null,
  region_id   number(10) not null,
  payer_id    number(10) not null,
  insert_dt   date not null,
  update_dt   date,
  constraint geo_id_pk primary key ( geo_id ) enable
)
;

grant select on dw_data_zkh.dw_payments_data to yzhdanovich;
/*==============================================================*/
/* table: dw_payments_data                                        */
/*==============================================================*/
create table fct_payments
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
  update_dt         date,
  constraint payment_id_pk primary key ( payment_id ) enable
)
;
