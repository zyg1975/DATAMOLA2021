
grant select on dw_data_zkh.dw_payments_data to yzhdanovich;
/*==============================================================*/
/* table: t_service_fact_payments_dd                            */
/*==============================================================*/
create table fct_payments
(
  payment_id        number(10) not null,
  paysystem_id      number(10) not null,
  provider_id       number(10) not null,
  service_id        number(10) not null,
  service_object_id number(10) not null,
  geo_id            number(10) not null,
  date_issue_dt     date       not null,
  date_pay_dt       date       not null,
  sum_issue         number(10,2) not null,
  sum_pay           number(10,2),
  insert_dt         date not null,
  update_dt         date,
  constraint payment_id_pk primary key ( payment_id ) enable
)
;

/*==============================================================*/
/* table: t_rs_fact_payments_dd                            */
/*==============================================================*/
create table t_rs_fact_payments_dd
(
  payment_id        number(10) not null,
  paysystem_id      number(10) not null,
  provider_id       number(10) not null,
  service_id        number(10) not null,
  region_id         number(10) not null,
  date_issue_dt     date       not null,
  date_pay_dt       date       not null,
  sum_issue         number(10,2) not null,
  sum_pay           number(10,2),
  percent_pay       number(10,2),
  insert_dt         date not null,
  update_dt         date,
  constraint rs_payment_id_pk primary key ( payment_id ) enable
)
;
