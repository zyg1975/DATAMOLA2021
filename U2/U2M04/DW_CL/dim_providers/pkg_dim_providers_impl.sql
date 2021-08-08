create or replace package body pkg_dim_providers
as
  procedure load_dim_providers
  as
  begin
    merge into u_dw_zkh.dim_providers dw
        using (select provider_id, provider_hier_id, provider_name from u_dw_zkh.w_providers) sa
            on (sa.provider_name = dw.provider_name)
        when not matched then 
          insert (provider_id, provider_hier_id, provider_name, insert_dt, update_dt)
          values (sa.provider_id, sa.provider_hier_id, sa.provider_name, sysdate, sysdate);
          
    commit;
  end;
end;
