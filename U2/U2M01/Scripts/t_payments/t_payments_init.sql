declare 
    cursor c1 is
    SELECT 
      ADD_MONTHS(mydate,-rn) as time_id
    FROM
    (
      SELECT 
        TO_DATE('20210701', 'yyyymmdd') mydate,
        rownum rn
      FROM dual
        CONNECT BY level <= 60
   );
   cursor c2 is SELECT service_id from t_services;
   cursor cgeo is select geo_id from t_geo;
   cursor c2 is SELECT service_id from t_services;
   cursor c3 is SELECT payer_id from t_payers;
begin
   FOR t1 in c1
   LOOP
       FOR t2 in c2
        LOOP
            FOR t3 in c3
            LOOP
--                DBMS_OUTPUT.PUT_LINE (t1.time_id||','||t2.service_id||','||t3.payer_id);
                insert into t_payments(paysystem_id,provider_id,service_id, service_object_id,payer_id,date_issue_dt,date_pay_dt, sum_issue, sum_pay,sum_debt. geo_id)
                values(
                  paysystem_id
                , provider_id
                , service_id
                , service_object_id
                , payer_id
                , date_issue_dt
                , date_pay_dt
                , sum_issue
                , sum_pay
                , sum_debt
                , geo_id
                );
            END LOOP;
        END LOOP;
   END LOOP;
end;

insert /*+ PARALLEL(16) APPEND */ into t_payments
(
      paysystem_id
    , provider_id
    , service_id
    , service_object_id
    , house_id
    , street_id
    , city_id
    , region_id
    , date_issue_dt
    , date_pay_dt
    , sum_issue
    , sum_pay
)
select
      paysystem_id
    , provider_id
    , sr_id service_id
    , service_object_id
    , h_id house_id
    , s_id street_id
    , c_id city_id
    , r_id region_id
    , date_issue
    , date_pay
    , sum_issue
    , round(sum_issue*percent, 2) sum_pay
from(    
    SELECT 
      ADD_MONTHS(mydate,-rn) as date_issue
    , (ADD_MONTHS(mydate,-rn) + floor(dbms_random.value(1, EXTRACT (DAY FROM LAST_DAY(ADD_MONTHS(mydate,-rn))) ))) as date_pay
    , floor(dbms_random.value(1, 5))  paysystem_id
    , floor(dbms_random.value(6, 36)) provider_id
    , floor(dbms_random.value(1, 3)) service_object_id
    , h_id
    , s_id
    , c_id
    , r_id
    , sr_id
    , round(dbms_random.value(70, 200),2) sum_issue
    , case when dbms_random.value(0, 100) < 95 then 1.0 else dbms_random.value(90, 100)/100 end percent
    FROM
    (
      SELECT 
        TO_DATE('20210701', 'yyyymmdd') mydate,
        rownum rn
      FROM dual
        CONNECT BY level <= 12
   )
   cross join 
   (select house_id h_id, street_id s_id, city_id c_id, region_id r_id
   from t_houses FETCH NEXT 10000 ROWS ONLY
   )
   cross join (select t_services.service_id as sr_id from t_services where t_services.service_id >= 3)
)   
;   
