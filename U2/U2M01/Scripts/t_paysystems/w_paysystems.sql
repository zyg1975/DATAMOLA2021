--drop view u_dw_zkh.w_paysystems;

--==============================================================
-- View: w_paysystems
--==============================================================
create or replace view u_dw_zkh.w_paysystems as
select
   paysystem_id  ,
   paysystem_name
from
   t_paysystems;
