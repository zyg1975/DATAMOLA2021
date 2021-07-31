drop table u_dw_zkh.t_payers cascade constraints;

/*==============================================================*/
/* Table: t_payers                                          */
/*==============================================================*/
create table u_dw_zkh.t_payers 
(
   payer_id           NUMBER(22)           not null,
   payer_fio          VARCHAR2(100)        not null,
   payer_noid         VARCHAR2(14)         not null,
   constraint PK_t_PAYERS primary key (payer_id, payer_noid)
)
tablespace ts_sa_zkh_data_01;
