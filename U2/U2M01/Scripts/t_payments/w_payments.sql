--drop view u_dw_zkh.w_payments;

--==============================================================
-- View: w_payments
--==============================================================
create or replace view u_dw_zkh.w_payments as
select
   payment_id         ,
   paysystem_id       ,
   provider_id        ,
   service_id         ,
   service_object_id  ,
   house_id           ,
   street_id          ,
   city_id            ,
   region_id          ,
   date_issue_dt      ,
   date_pay_dt        ,
   sum_issue          ,
   sum_pay            

from
   t_payments;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_payments to u_dw_zkh;

