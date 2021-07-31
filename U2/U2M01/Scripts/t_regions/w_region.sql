--drop view u_dw_zkh.w_regions;

--==============================================================
-- View: w_regions                                            
--==============================================================
create or replace view u_dw_zkh.w_regions as
select
   region_id  ,
   region_name
from
   t_regions;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_regions to u_dw_zkh;
