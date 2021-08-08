create or replace package body pkg_dim_streets
as
  procedure load_dim_streets
  as
  begin
    merge into u_dw_zkh.dim_streets dw
        using (select distinct street_id, street_name, u_dw_zkh.dim_cityes.city_id, u_dw_zkh.dim_cityes.region_id
              from u_dw_zkh.w_streets
                 , u_dw_zkh.dim_cityes
                 , u_dw_zkh.dim_regions
               where u_dw_zkh.w_streets.city_name   = u_dw_zkh.dim_cityes.city_name  and
                     u_dw_zkh.dim_cityes.region_id  = u_dw_zkh.dim_regions.region_id and
                     u_dw_zkh.w_streets.region_name = u_dw_zkh.dim_regions.region_name
              ) sa
            on (sa.street_name = dw.street_name and sa.city_id = dw.city_id)
        when not matched then 
          insert (street_id, street_name, city_id, region_id, insert_dt, update_dt)
          values (sa.street_id, sa.street_name, sa.city_id, sa.region_id, sysdate, sysdate);
          
    commit;
  end;
end;
