
grant select on dw_data_zkh.dw_payments_data to yzhdanovich;
/*==============================================================*/
/* table: fct_payments                                          */
/*==============================================================*/
--drop table fct_payments;
create table fct_payments
(
  payment_id        number(10) not null,
  paysystem_id      number(10) not null constraint fk_paysystem_id      references dim_paysystems      on delete cascade,
  provider_id       number(10) not null constraint fk_provider_id       references dim_providers       on delete cascade,
  service_id        number(10) not null constraint fk_service_id        references dim_services        on delete cascade,
  service_object_id number(10) not null constraint fk_service_object_id references dim_service_objects on delete cascade,
  geo_id            number(10) not null constraint fk_geo_id            references dim_geo             on delete cascade,
  date_issue_dt     date       not null constraint fk_date_issue_dt     references dim_date            on delete cascade,
  date_pay_dt       date       not null constraint fk_date_pay_dt       references dim_date            on delete cascade,
  sum_issue         number(10,2) not null,
  sum_pay           number(10,2),
  insert_dt         date not null,
  update_dt         date,
  constraint payment_id_pk primary key ( payment_id ) enable
)
partition by range(date_issue_dt)
(
  partition pays_2016 values less than(TO_DATE('01.01.2017','dd.mm.yyyy')),
  partition pays_2017 values less than(TO_DATE('01.01.2018','dd.mm.yyyy')),
  partition pays_2018 values less than(TO_DATE('01.01.2019','dd.mm.yyyy')),
  partition pays_2019 values less than(TO_DATE('01.01.2020','dd.mm.yyyy')),
  partition pays_2020 values less than(TO_DATE('01.01.2021','dd.mm.yyyy')),
  partition pays_2021 values less than(TO_DATE('01.01.2022','dd.mm.yyyy'))
)
tablespace TS_DW_DATA_ZKH
;

/*==============================================================*/
/* table: t_rs_fact_payments_dd                            */
/*==============================================================*/
drop table t_rs_fact_payments_dd;
create table t_rs_fact_payments_dd
(
  payment_id        number(10) not null,
  paysystem_id      number(10) not null constraint fk_rspaysystem_id      references dim_paysystems      on delete cascade,
  provider_id       number(10) not null constraint fk_rsprovider_id       references dim_providers       on delete cascade,
  service_id        number(10) not null constraint fk_rsservice_id        references dim_services        on delete cascade,
  region_id         number(10) not null,
  date_issue_dt     date       not null constraint fk_rsdate_issue_dt     references dim_date            on delete cascade,
  date_pay_dt       date       not null constraint fk_rsdate_pay_dt       references dim_date            on delete cascade,
  sum_issue         number(10,2) not null,
  sum_pay           number(10,2),
  percent_pay       number(10,2),
  insert_dt         date not null,
  update_dt         date,
  constraint rs_payment_id_pk primary key ( payment_id ) enable
)
PARTITION BY RANGE(date_issue_dt)
(
  partition pays_2016 values less than(TO_DATE('01.01.2017','dd.mm.yyyy')),
  partition pays_2017 values less than(TO_DATE('01.01.2018','dd.mm.yyyy')),
  partition pays_2018 values less than(TO_DATE('01.01.2019','dd.mm.yyyy')),
  partition pays_2019 values less than(TO_DATE('01.01.2020','dd.mm.yyyy')),
  partition pays_2020 values less than(TO_DATE('01.01.2021','dd.mm.yyyy')),
  partition pays_2021 values less than(TO_DATE('01.01.2022','dd.mm.yyyy'))
)
tablespace TS_DW_DATA_ZKH
;
