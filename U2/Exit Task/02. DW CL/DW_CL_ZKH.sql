--drop tablespace ts_dw_cl_zkh including contents;

create tablespace ts_dw_cl_zkh
datafile '/oracle/u02/oradata/DMORCL19DB/yzhdanovich_db/db_dw_cl_zkh.dat'
size 150m autoextend on next 50m nologging segment space management auto;

--drop user dw_cl_zkh;

create user dw_cl_zkh identified by dw_cl_zkh123 default tablespace ts_dw_cl_zkh;

grant dba to dw_cl_zkh;
grant select on sa_zkh.sa_regions to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_regions                                            */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_regions 
(
   region_name varchar2(128) not null
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_city;

grant select on sa_zkh.sa_cityes to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_cityes                                             */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_cityes 
(
   city_name          varchar2(100) not null,
   region_name        varchar2(128) not null
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_streets;

grant select on sa_zkh.sa_streets to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_streets                                            */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_streets
(
   street_name        varchar2(150) not null,
   city_name          varchar2(100) not null,
   region_name        varchar2(128) not null
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_houses;

grant select on sa_zkh.sa_houses to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_houses                                             */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_houses
(
   house_no           varchar2(10)         not null,
   street_name        varchar2(150)        not null,
   city_name          varchar2(100)        not null,
   region_name        varchar2(128)        not null
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_payers;

grant select on sa_zkh.sa_payers to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_payers                                          */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_payers
(
   payer_fio          varchar2(100) not null,
   payer_noid         varchar2(14)  not null
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_paysystems;

/*==============================================================*/
/* table: dw_cl_paysystems                                      */
/*==============================================================*/
grant select on sa_zkh.sa_paysystems to dw_cl_zkh;
create table dw_cl_zkh.dw_cl_paysystems
(
   paysystem_name     varchar2(100) not null
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_providers;

grant select on sa_zkh.sa_providers to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_providers                                       */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_providers
(
   provider_name      varchar2(200) not null,
   provider_hier_name varchar2(200)
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_service_objects;

grant select on sa_zkh.sa_service_objects to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_service_objects                                 */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_service_objects
(
   service_object_name varchar2(200) not null
)
tablespace ts_dw_cl_zkh;


--drop table dw_cl_zkh.dw_cl_services;

grant select on sa_zkh.sa_services to dw_cl_zkh;
/*==============================================================*/
/* table: dw_cl_services                                        */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_services
(
   service_name       varchar2(128)  not null,
   service_hier_name  varchar2(128)
)
tablespace ts_dw_cl_zkh;

--drop table dw_cl_zkh.dw_cl_payments;

grant select on sa_zkh.sa_payments to dw_cl_zkh;
/*==============================================================*/
/* table: fct_payments                                        */
/*==============================================================*/
create table dw_cl_zkh.dw_cl_payments
(
   paysystem_name     varchar2(100) not null,
   provider_name      varchar2(200) not null,
   service_name       varchar2(128)  not null,
   service_object_name varchar2(200) not null,
   house_no           varchar2(10)         not null,
   street_name        varchar2(150)        not null,
   city_name          varchar2(100)        not null,
   region_name        varchar2(128)        not null,
   payer_noid         varchar2(14)         not null,
   date_issue_dt      date                 not null,
   date_pay_dt        date                 not null,
   sum_issue          number(10,2),
   sum_pay            number(10,2)
)
tablespace ts_dw_cl_zkh;
