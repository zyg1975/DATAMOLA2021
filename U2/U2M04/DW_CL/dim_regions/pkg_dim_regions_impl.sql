create or replace package body pkg_dim_regions
as
  procedure load_dim_regions
  as
  begin
    merge into u_dw_zkh.dim_regions dw
        using (select region_id, region_name from u_dw_zkh.w_regions) sa
            on (sa.region_name = dw.region_name)
        when not matched then 
          insert (region_id, region_name, insert_dt, update_dt)
          values (sa.region_id, sa.region_name, sysdate, sysdate);
          
    commit;
  end;
end;
