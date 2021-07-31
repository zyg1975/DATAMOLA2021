alter table u_dw_zkh.t_streets
   drop constraint FK_T_STRE_REFERENCE_T_CITY;

alter table u_dw_zkh.t_streets
   drop constraint FK_T_STRE_REFERENCE_T_REGI;

drop table u_dw_zkh.t_streets cascade constraints;

/*==============================================================*/
/* Table: t_streets                                         */
/*==============================================================*/
create table u_dw_zkh.t_streets 
(
   street_id          NUMBER(22)           not null,
   street_name        VARCHAR2(150)        not null,
   city_id            NUMBER(22)           not null,
   region_id          NUMBER(22)           not null
   constraint PK_T_STREETS primary key (street_id)
)
tablespace ts_sa_zkh_data_01;

alter table u_dw_zkh.t_streets
   add constraint FK_T_STRE_REFERENCE_T_CITY foreign key (city_id)
      references u_dw_zkh.t_cityes (city_id);

alter table u_dw_zkh.t_streets
   add constraint FK_T_STRE_REFERENCE_T_REGI foreign key (region_id)
      references u_dw_zkh.t_regions (region_id);
