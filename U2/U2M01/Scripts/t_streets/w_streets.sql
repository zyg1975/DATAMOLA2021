--drop view u_dw_zkh.w_streets;

--==============================================================
-- View: w_streets
--==============================================================
create or replace view u_dw_zkh.w_streets as
select
   street_id ,
   street_name ,
   city_id   ,
   region_id
from
   t_streets;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_streets to u_dw_zkh;
