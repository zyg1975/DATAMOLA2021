drop table u_dw_zkh.t_service_objects cascade constraints;

/*==============================================================*/
/* Table: t_service_objects                                        */
/*==============================================================*/
create table u_dw_zkh.t_service_objects 
(
   service_object_id   NUMBER(22)           not null,
   service_object_name VARCHAR2(200)        not null,
   constraint PK_T_service_objectS primary key (service_object_id)
)
tablespace ts_sa_zkh_data_01;
