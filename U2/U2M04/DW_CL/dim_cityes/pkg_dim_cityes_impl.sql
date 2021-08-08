create or replace package body pkg_dim_cityes
as
  procedure load_dim_cityes
  as
  begin
    merge into u_dw_zkh.dim_cityes dw
        using (select city_id, city_name, region_id
               from u_dw_zkh.w_cityes
                  , u_dw_zkh.dim_regions
               where u_dw_zkh.w_cityes.region_name = u_dw_zkh.dim_regions.region_name
              ) sa
            on (sa.city_name = dw.city_name and sa.region_id = dw.region_id)
        when not matched then 
          insert (city_id, city_name, region_id, insert_dt, update_dt)
          values (sa.city_id, sa.city_name, sa.region_id, sysdate, sysdate);
          
    commit;
  end;
end;
