--drop view u_dw_zkh.w_payers;

--==============================================================
-- View: w_payers
--==============================================================
create or replace view u_dw_zkh.w_payers as
select
   payer_id  ,
   payer_fio ,
   payer_noid
from
   t_payers;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_zkh.w_payers to u_dw_zkh;
