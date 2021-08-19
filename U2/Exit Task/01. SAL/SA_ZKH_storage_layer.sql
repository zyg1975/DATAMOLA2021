drop tablespace ts_sa_zkh_data_01 including contents;

create tablespace ts_sa_zkh_data_01
datafile '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/db_sa_zkh_data_01.dat'
size 150M autoextend on next 50M segment space management auto;


--DROP USER sa_zkh;

CREATE USER sa_zkh IDENTIFIED BY sa_zkh123  DEFAULT TABLESPACE ts_sa_zkh_data_01;
GRANT DBA TO sa_zkh;

/*==============================================================*/
/* Table: SA_regions                                            */
/*==============================================================*/
create table sa_zkh.SA_regions 
(
   region_name VARCHAR2(128) not null
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_city;

/*==============================================================*/
/* Table: SA_cityes                                             */
/*==============================================================*/
create table sa_zkh.SA_cityes 
(
   city_name          VARCHAR2(100) not null,
   region_name        VARCHAR2(128) not null
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_streetnames;

/*==============================================================*/
/* Table: SA_streetnames                                        */
/*==============================================================*/
create table sa_zkh.SA_streetnames
(
   id                 number not null,
   street_name        VARCHAR2(150) not null
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_streets;

/*==============================================================*/
/* Table: SA_streets                                            */
/*==============================================================*/
create table sa_zkh.SA_streets 
(
   street_name        VARCHAR2(150) not null,
   city_name          VARCHAR2(100) not null,
   region_name        VARCHAR2(128) not null
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_houses;

/*==============================================================*/
/* Table: SA_houses                                             */
/*==============================================================*/
create table sa_zkh.SA_houses
(
   house_no           VARCHAR2(10)         not null,
   street_name        VARCHAR2(150)        not null,
   city_name          VARCHAR2(100)        not null,
   region_name        VARCHAR2(128)        not null
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_payers;

/*==============================================================*/
/* Table: SA_payers                                          */
/*==============================================================*/
create table sa_zkh.SA_payers 
(
   payer_fio          VARCHAR2(100) not null,
   payer_noid         VARCHAR2(14)  not null
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_paysystems;

/*==============================================================*/
/* Table: SA_paysystems                                      */
/*==============================================================*/
create table sa_zkh.SA_paysystems 
(
   paysystem_name     VARCHAR2(100) not null
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_providers;

/*==============================================================*/
/* Table: SA_providers                                       */
/*==============================================================*/
create table sa_zkh.SA_providers 
(
   provider_name      VARCHAR2(200) not null,
   provider_hier_name VARCHAR2(200)
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_service_objects;

/*==============================================================*/
/* Table: SA_service_objects                                 */
/*==============================================================*/
create table sa_zkh.SA_service_objects 
(
   service_object_name VARCHAR2(200) not null
)
tablespace ts_sa_zkh_data_01;


--drop table sa_zkh.SA_services;

/*==============================================================*/
/* Table: SA_services                                        */
/*==============================================================*/
create table sa_zkh.SA_services 
(
   service_name       VARCHAR2(128)  not null,
   service_hier_name  VARCHAR2(128)
)
tablespace ts_sa_zkh_data_01;

--drop table sa_zkh.SA_payments;

/*==============================================================*/
/* Table: fct_payments                                        */
/*==============================================================*/
create table sa_zkh.SA_payments 
(
   paysystem_name     VARCHAR2(100) not null,
   provider_name      VARCHAR2(200) not null,
   service_name       VARCHAR2(128)  not null,
   service_object_name VARCHAR2(200) not null,
   house_no           VARCHAR2(10)         not null,
   street_name        VARCHAR2(150)        not null,
   city_name          VARCHAR2(100)        not null,
   region_name        VARCHAR2(128)        not null,
   payer_noid         VARCHAR2(14)         not null,
   date_issue_dt      DATE                 not null,
   date_pay_dt        DATE                 not null,
   sum_issue          NUMBER(10,2),
   sum_pay            NUMBER(10,2)
)
tablespace ts_sa_zkh_data_01;
