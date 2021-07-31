alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_SERV;

alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_PAYE;

alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_DATE;

alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_PAYS;

alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_SERV;

alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_PROV;

alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_DATE;

alter table u_dw_zkh.t_payments
   drop constraint FK_t_PAYM_REFERENCE_T_GEO;

drop table u_dw_zkh.t_payments cascade constraints;

/*==============================================================*/
/* Table: t_payments                                        */
/*==============================================================*/
create table u_dw_zkh.t_payments 
(
   payment_id         NUMBER(22)           not null,
   paysystem_id       NUMBER(22)           not null,
   provider_id        NUMBER(22)           not null,
   service_id         NUMBER(22)           not null,
   service_object_id  NUMBER(22)           not null,
   house_id           NUMBER(22)           not null,
   street_id          NUMBER(22)           not null,
   city_id            NUMBER(22)           not null,
   region_id          NUMBER(22)           not null,
   date_issue_dt      DATE                 not null,
   date_pay_dt        DATE                 not null,
   sum_issue          NUMBER(10,2),
   sum_pay            NUMBER(10,2),
   constraint PK_T_PAYMENTS primary key (payment_id)
)
tablespace ts_sa_zkh_data_01;

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_SERV foreign key (service_id)
      references u_dw_zkh.t_services (service_id);

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_PAYS foreign key (paysystem_id)
      references u_dw_zkh.t_paysystems (paysystem_id);

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_SOBJ foreign key (service_object_id)
      references u_dw_zkh.t_service_objects (service_object_id);

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_PROV foreign key (provider_id)
      references u_dw_zkh.t_providers (provider_id);

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_HOUSE foreign key (house_id)
      references u_dw_zkh.t_houses (house_id);

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_STREET foreign key (street_id)
      references u_dw_zkh.t_streets (street_id);

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_CITY foreign key (city_id)
      references u_dw_zkh.t_cityes (city_id);

alter table u_dw_zkh.t_payments
   add constraint FK_t_PAYM_REFERENCE_T_REGION foreign key (region_id)
      references u_dw_zkh.t_regions (region_id);