--drop view u_dw_zkh.w_service_objects;

--==============================================================
-- View: w_service_objects
--==============================================================
create or replace view u_dw_zkh.w_service_objects as
select
   service_object_id   ,
   service_object_name
from
   t_service_objects;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_service_objects to u_dw_zkh;
