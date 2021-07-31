alter table u_dw_zkh.t_providers
   drop constraint FK_T_PROV_REFERENCE_t_PROV;

drop table u_dw_zkh.t_providers cascade constraints;

/*==============================================================*/
/* Table: t_providers                                       */
/*==============================================================*/
create table u_dw_zkh.t_providers 
(
   provider_id        NUMBER(22)           not null,
   provider_name      VARCHAR2(200)        not null,
   provider_hier_id   NUMBER(22,0),
   constraint PK_T_PROVIDERS primary key (provider_id)
)
tablespace ts_sa_zkh_data_01;

alter table u_dw_zkh.t_providers
   add constraint FK_T_PROV_REFERENCE_T_PROV foreign key (provider_hier_id)
      references u_dw_zkh.t_providers (provider_id);
