drop table u_dw_zkh.sa_payments ;
create table u_dw_zkh.sa_payments 
(
   paysystem_name       varchar2(150),
   provider_name        varchar2(150),
   service_name         varchar2(150),
   service_object_name  varchar2(150),
   region_name          varchar2(150),
   city_name            varchar2(150),
   street_name          varchar2(150),
   house_no             varchar2(150),
   date_issue_dt        DATE         ,
   date_pay_dt          DATE         ,
   sum_issue            NUMBER(10,2) ,
   sum_pay              NUMBER(10,2) ,
   insert_dt            date default sysdate
)
tablespace ts_sa_zkh_data_01;

drop table u_dw_zkh.sa_payments ;
create table u_dw_zkh.sa_payments 
(
   paysystem_name       varchar2(150),
   provider_name        varchar2(150),
   service_name         varchar2(150),
   service_object_name  varchar2(150),
   region_name          varchar2(150),
   city_name            varchar2(150),
   street_name          varchar2(150),
   house_no             varchar2(150),
   date_issue_dt        DATE         ,
   date_pay_dt          DATE         ,
   sum_issue            NUMBER(10,2) ,
   sum_pay              NUMBER(10,2) ,
   insert_dt            date default sysdate
)
tablespace ts_sa_zkh_data_01;


select p.*
,t_paysystems.paysystem_id
,t_providers.provider_id
,t_service_objects.service_object_id
,t_regions.region_id
,t_cityes.city_id
,t_streets.street_id
,t_houses.house_id

from sa_payments p
left join t_paysystems on p.paysystem_name=t_paysystems.paysystem_name
left join t_providers on p.provider_name=t_providers.provider_name
left join t_service_objects on p.service_object_name=t_service_objects.service_object_name
left join t_services on p.service_name=t_services.service_name
left join t_regions on p.region_name=t_regions.region_name
left join t_cityes on p.city_name=t_cityes.city_name and t_cityes.region_id = t_regions.region_id
left join t_streets on p.street_name=t_streets.street_name and t_streets.region_id = t_regions.region_id and t_streets.city_id = t_cityes.city_id
left join t_houses on p.house_no=t_houses.house_no and t_houses.region_id = t_regions.region_id and t_houses.city_id = t_cityes.city_id and t_houses.street_id = t_streets.street_id
