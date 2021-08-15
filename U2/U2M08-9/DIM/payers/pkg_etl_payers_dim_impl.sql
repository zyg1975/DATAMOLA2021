create or replace package body pkg_etl_payers_dim
as procedure load_payers_dim
as
 begin
    merge into dim_payers dim
      using (select payer_id, payer_noid, payer_fio, insert_dt, update_dt from dw_data_zkh.dw_payers_data) dw
          on (dw.payer_id = dim.payer_id)
      when not matched then 
        insert (payer_id, payer_noid, payer_fio, insert_dt, update_dt)
        values (dw.payer_id, dw.payer_noid, dw.payer_fio, dw.insert_dt, dw.update_dt)
      when matched then
        update set payer_noid = dw.payer_noid, payer_fio = dw.payer_fio;
          
    commit;
  end load_payers_dim;
end pkg_etl_payers_dim;
