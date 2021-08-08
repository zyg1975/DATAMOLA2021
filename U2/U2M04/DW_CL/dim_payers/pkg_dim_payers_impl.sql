create or replace package body pkg_dim_payers
as
  procedure load_dim_payers
  as
  begin
    merge into u_dw_zkh.dim_payers dw
        using (select payer_id, payer_noid, payer_fio from u_dw_zkh.t_payers) sa
            on (sa.payer_noid = dw.payer_noid)
        when not matched then 
          insert (payer_id, payer_noid, payer_fio, insert_dt, update_dt)
          values (sa.payer_id, sa.payer_noid, sa.payer_fio, sysdate, sysdate);
          
    commit;
  end;
end;
