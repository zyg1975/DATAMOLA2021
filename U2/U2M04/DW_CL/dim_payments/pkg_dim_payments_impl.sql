create or replace package body pkg_dim_payments
as
  procedure load_dim_payments
  as
  begin
    merge into u_dw_zkh.fct_payments dw
        using (select paysystem_id,
                      provider_id,
                      service_id,
                      service_object_id,
                      geo_id,
                      date_issue_dt,
                      date_pay_dt,
                      sum_issue,
                      sum_pay 
               from u_dw_zkh.w_payments) sa
            on (sa.paysystem_id      = dw.paysystem_id      and
                sa.provider_id       = dw.provider_id       and
                sa.service_id        = dw.service_id        and
                sa.service_object_id = dw.service_object_id and
                sa.geo_id            = dw.geo_id            and
                sa.date_issue_dt     = dw.date_issue_dt    
               )
        when not matched then 
          insert (paysystem_id,
                  provider_id,
                  service_id,
                  service_object_id,
                  geo_id,
                  date_issue_dt,
                  date_pay_dt,
                  sum_issue,
                  sum_pay,
                  insert_dt,
                  update_dt)
          values (sa.paysystem_id,
                  sa.provider_id,
                  sa.service_id,
                  sa.service_object_id,
                  sa.geo_id,
                  sa.date_issue_dt,
                  sa.date_pay_dt,
                  sa.sum_issue,
                  sa.sum_pay,
                  sysdate,
                  sysdate)
        when matched then
          update set dw.sum_issue   = sa.sum_issue
                   , dw.sum_pay     = sa.sum_pay
                   , dw.date_pay_dt = sa.date_pay_dt
    ;

    commit;
  end;
end;
