drop table u_dw_zkh.t_regions cascade constraints;

/*==============================================================*/
/* Table: t_regions                                         */
/*==============================================================*/
create table u_dw_zkh.t_regions 
(
   region_id          NUMBER(22)           not null,
   region_name        VARCHAR2(50)         not null,
   constraint PK_T_REGIONS primary key (region_id)
)
tablespace ts_sa_zkh_data_01;
