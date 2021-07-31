--drop view u_dw_zkh.w_houses;

--==============================================================
-- View: w_houses                                            
--==============================================================
create or replace view u_dw_zkh.w_houses as
select
   house_id ,
   house_no,
   region_id,
   city_id  ,
   street_id
from
   t_houses;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_houses to u_dw_zkh;
