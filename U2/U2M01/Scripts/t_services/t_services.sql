drop table u_dw_zkh.t_services cascade constraints;

/*==============================================================*/
/* Table: t_services                                        */
/*==============================================================*/
create table u_dw_zkh.t_services 
(
   service_id         NUMBER(22)           not null,
   service_name       VARCHAR2(128)        not null,
   service_hier_id    NUMBER(22,0),
   constraint PK_T_SERVICES primary key (service_id)
)
tablespace ts_sa_zkh_data_01;

alter table u_dw_zkh.t_services 
   add constraint FK_T_SERV_REFERENCE_T_SERV foreign key (service_hier_id)
      references u_dw_zkh.t_services (service_id);
