--drop view u_dw_zkh.w_providers;

--==============================================================
-- View: w_providers
--==============================================================
create or replace view u_dw_zkh.w_providers as
select
   provider_id        ,
   provider_name      ,
   provider_hier_id
from
   t_providers;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_providers to u_dw_zkh;
