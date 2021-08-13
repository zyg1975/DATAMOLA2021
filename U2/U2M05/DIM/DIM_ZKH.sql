--drop table dim_paysystems;
/*==============================================================*/
/* table: dim_paysystems                                        */
/*==============================================================*/
grant select on dw_data_zkh.dw_paysystems_data to yzhdanovich;

create table dim_paysystems
(
  paysystem_id   number(10) not null,
  paysystem_name varchar2(100) not null,
  insert_dt      date not null,
  update_dt      date,
  constraint paysystem_id_pk primary key ( paysystem_id ) enable
);

--drop table dim_providers;
/*==============================================================*/
/* table: dim_providers                                         */
/*==============================================================*/
grant select on dw_data_zkh.dw_providers_data to yzhdanovich;
create table dim_providers
(
  provider_id      number(10) not null,
  provider_name    varchar2(200) not null,
  provider_hier_id number(10),
  insert_dt        date not null,
  update_dt        date,
  constraint provider_id_pk primary key ( provider_id ) enable
)
;
