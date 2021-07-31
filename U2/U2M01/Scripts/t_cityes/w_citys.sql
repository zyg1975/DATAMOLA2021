--drop view u_dw_zkh.w_cityes;

--==============================================================
-- View: w_cityes                                            
--==============================================================
create or replace view u_dw_zkh.w_cityes as
select
    city_id  
,   city_name
,   region_id
from
   t_cityes;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_cityes to u_dw_zkh;
