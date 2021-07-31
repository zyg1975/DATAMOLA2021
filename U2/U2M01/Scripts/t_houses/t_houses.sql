alter table u_dw_zkh.t_houses
   drop constraint FK_T_HOUS_REFERENCE_T_STRE;

alter table u_dw_zkh.t_houses
   drop constraint FK_T_HOUS_REFERENCE_T_REGI;

alter table u_dw_zkh.t_houses
   drop constraint FK_T_HOUS_REFERENCE_T_CITY;

drop table u_dw_zkh.t_houses cascade constraints;

/*==============================================================*/
/* Table: t_houses                                          */
/*==============================================================*/
create table u_dw_zkh.t_houses 
(
   house_id           NUMBER(22)           not null,
   house_no           VARCHAR2(10)         not null,
   region_id          NUMBER(22)           not null,
   city_id            NUMBER(22)           not null,
   street_id          NUMBER(22)           not null,
   constraint PK_T_HOUSES primary key (house_id)
)
tablespace ts_sa_zkh_data_01;

alter table u_dw_zkh.t_houses
   add constraint FK_t_HOUS_REFERENCE_T_STRE foreign key (street_id)
      references u_dw_zkh.t_streets (street_id);

alter table u_dw_zkh.t_houses
   add constraint FK_t_HOUS_REFERENCE_T_REGI foreign key (region_id)
      references u_dw_zkh.t_regions (region_id);

alter table u_dw_zkh.t_houses
   add constraint FK_T_HOUS_REFERENCE_T_CITY foreign key (city_id)
      references u_dw_zkh.t_cityes (city_id);
