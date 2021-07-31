--drop view u_dw_zkh.w_services;

--==============================================================
-- View: w_services
--==============================================================
create or replace view u_dw_zkh.w_services as
select
   service_id  ,
   service_name
from
   t_services;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_services to u_dw_zkh;
