insert /*+ parallel(16) append */ into sa_payments
(
  paysystem_name
, provider_name
, service_name
, service_object_name
, house_no    
, street_name 
, city_name   
, region_name 
, payer_noid
, date_issue_dt
, date_pay_dt
, sum_issue
, sum_pay
)
select
  paysystem_name
, provider_name
, sr_name service_name
, service_object_name
, house_no    
, street_name 
, city_name   
, region_name 
, payer_noid
, date_issue
, date_pay
, sum_issue
, round(sum_issue*percent, 2) sum_pay
from
(
  select 
     add_months(mydate,-rn) as date_issue
  , (add_months(mydate,-rn) + floor(dbms_random.value(1, extract (day from last_day(add_months(mydate,-rn))) ))) as date_pay
  , (select * from (select paysystem_name      from sa_paysystems      order by dbms_random.value) where rownum = 1) paysystem_name
  , (select * from (select provider_name       from sa_providers       order by dbms_random.value) where rownum = 1) provider_name
  , (select * from (select service_object_name from sa_service_objects order by dbms_random.value) where rownum = 1) service_object_name
  , house_no    
  , street_name 
  , city_name   
  , region_name 
  , payer_noid
  , sr_name
  , round(dbms_random.value(70, 200),2) sum_issue
  , case when dbms_random.value(0, 100) < 95 then 1.0 else dbms_random.value(90, 100)/100 end percent
  from
  (
    select 
      to_date('20210701', 'yyyymmdd') mydate,
      rownum rn
    from dual
      connect by level <= 12
  )
  cross join 
  (
    select 
      house_no    
    , street_name 
    , city_name   
    , region_name 
    , payer_noid
    from sa_houses
    cross join sa_payers fetch next 10000 rows only
  )
  cross join (select sa_services.service_name as sr_name from sa_services where sa_services.service_hier_name is not null)
);   

