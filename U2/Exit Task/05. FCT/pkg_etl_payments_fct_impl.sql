create or replace package body pkg_etl_payments_fct
as
procedure load_payments_fct as
 begin
    merge into fct_payments dim
      using (select payment_id
                  , paysystem_id
                  , provider_id
                  , service_id
                  , service_object_id
                  , geo_id
                  , date_issue_dt
                  , date_pay_dt
                  , sum_issue
                  , NVL(sum_pay, 0) sum_pay
                  , insert_dt
                  , update_dt
             from dw_data_zkh.dw_payments_data) dw
          on (dw.payment_id = dim.payment_id)
      when not matched then 
        insert (payment_id
              , paysystem_id
              , provider_id
              , service_id
              , service_object_id
              , geo_id
              , date_issue_dt
              , date_pay_dt
              , sum_issue
              , sum_pay
              , insert_dt
              , update_dt)
        values (dw.payment_id
              , dw.paysystem_id
              , dw.provider_id
              , dw.service_id
              , dw.service_object_id
              , dw.geo_id
              , dw.date_issue_dt
              , dw.date_pay_dt
              , dw.sum_issue
              , dw.sum_pay
              , dw.insert_dt
              , dw.update_dt
                )
      when matched then
        update set paysystem_id     = dw.paysystem_id
                , provider_id       = dw.provider_id
                , service_id        = dw.service_id
                , service_object_id = dw.service_object_id
                , geo_id            = dw.geo_id
                , date_issue_dt     = dw.date_issue_dt
                , date_pay_dt       = dw.date_pay_dt
                , sum_issue         = dw.sum_issue
                , sum_pay           = dw.sum_pay
                , insert_dt         = dw.insert_dt
                , update_dt         = dw.update_dt
                 ;

    commit;
end load_payments_fct;

procedure load_t_rs_fct as
begin
    merge into t_rs_fact_payments_dd dim
      using (select payment_id
                  , paysystem_id
                  , provider_id
                  , service_id
                  , dw_data_zkh.dw_gen_geo_data.region_id as region_id
                  , date_issue_dt
                  , date_pay_dt
                  , sum_issue
                  , NVL(sum_pay, 0) sum_pay
                  , dw_data_zkh.dw_payments_data.insert_dt as insert_dt
                  , dw_data_zkh.dw_payments_data.update_dt as update_dt
             from dw_data_zkh.dw_payments_data left join dw_data_zkh.dw_gen_geo_data on dw_data_zkh.dw_payments_data.geo_id = dw_data_zkh.dw_gen_geo_data.geo_id) dw
          on (dw.payment_id = dim.payment_id)
      when not matched then 
        insert (payment_id
              , paysystem_id
              , provider_id
              , service_id
              , region_id
              , date_issue_dt
              , date_pay_dt
              , sum_issue
              , sum_pay
              , percent_pay
              , insert_dt
              , update_dt)
        values (dw.payment_id
              , dw.paysystem_id
              , dw.provider_id
              , dw.service_id
              , dw.region_id
              , dw.date_issue_dt
              , dw.date_pay_dt
              , dw.sum_issue
              , dw.sum_pay
              , round(dw.sum_pay / dw.sum_issue * 100, 2)
              , dw.insert_dt
              , dw.update_dt
                )
      when matched then
        update set paysystem_id = dw.paysystem_id
                , provider_id   = dw.provider_id
                , service_id    = dw.service_id
                , region_id     = dw.region_id
                , date_issue_dt = dw.date_issue_dt
                , date_pay_dt   = dw.date_pay_dt
                , sum_issue     = dw.sum_issue
                , sum_pay       = dw.sum_pay
                , percent_pay   = round(dw.sum_pay / dw.sum_issue * 100, 2)
                , insert_dt     = dw.insert_dt
                , update_dt     = dw.update_dt
                 ;
    commit;
end load_t_rs_fct;

end pkg_etl_payments_fct;