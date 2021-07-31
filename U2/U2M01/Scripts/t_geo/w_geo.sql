--drop view u_dw_zkh.w_geo;

--==============================================================
-- View: w_geo                                            
--==============================================================
create or replace view u_dw_zkh.w_geo as
select
   geo_id     ,
   house_id   ,
   street_id  ,
   city_id    ,
   region_id
from
   t_geo;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_geo to u_dw_zkh;

