alter table u_dw_zkh.t_geo
   drop constraint FK_T_GEO_REFERENCE_T_HOUS;

alter table u_dw_zkh.t_geo
   drop constraint FK_T_GEO_REFERENCE_T_STRE;

alter table u_dw_zkh.t_geo
   drop constraint FK_T_GEO_REFERENCE_T_CITY;

alter table u_dw_zkh.t_geo
   drop constraint FK_T_GEO_REFERENCE_T_REGI;

drop table u_dw_zkh.t_geo cascade constraints;

/*==============================================================*/
/* Table: t_geo                                             */
/*==============================================================*/
create table u_dw_zkh.t_geo 
(
   geo_id             NUMBER(22)           not null,
   house_id           NUMBER(22)           not null,
   street_id          NUMBER(22)           not null,
   city_id            NUMBER(22)           not null,
   region_id          NUMBER(22)           not null,
   payer_id           NUMBER(22)           not null,
   constraint PK_T_GEO primary key (geo_id)
);

alter table u_dw_zkh.t_geo
   add constraint FK_T_GEO_REFERENCE_T_HOUS foreign key (house_id)
      references u_dw_zkh.t_houses (house_id);

alter table u_dw_zkh.t_geo
   add constraint FK_T_GEO_REFERENCE_T_STRE foreign key (street_id)
      references u_dw_zkh.t_streets (street_id);

alter table u_dw_zkh.t_geo
   add constraint FK_T_GEO_REFERENCE_T_CITY foreign key (city_id)
      references u_dw_zkh.t_cityes (city_id);

alter table u_dw_zkh.t_geo
   add constraint FK_T_GEO_REFERENCE_T_REGI foreign key (region_id)
      references u_dw_zkh.t_regions (region_id);

alter table u_dw_zkh.t_geo
   add constraint FK_T_GEO_REFERENCE_T_PAYER foreign key (payer_id)
      references u_dw_zkh.t_payers (payer_id);
