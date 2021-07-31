drop table u_dw_zkh.t_paysystems cascade constraints;

/*==============================================================*/
/* Table: t_paysystems                                      */
/*==============================================================*/
create table u_dw_zkh.t_paysystems 
(
   paysystem_id       NUMBER(22)           not null,
   paysystem_name     VARCHAR2(100)        not null,
   constraint PK_T_PAYSYSTEMS primary key (paysystem_id)
)
tablespace ts_sa_zkh_data_01;
