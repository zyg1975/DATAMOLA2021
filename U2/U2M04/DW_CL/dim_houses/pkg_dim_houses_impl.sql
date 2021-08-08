create or replace package body pkg_dim_houses
as
  procedure load_dim_houses
  as
  begin
    merge into u_dw_zkh.dim_houses dw
        using (select distinct house_id, house_no, u_dw_zkh.dim_streets.street_id, u_dw_zkh.dim_streets.city_id, u_dw_zkh.dim_streets.region_id
               from u_dw_zkh.w_houses
                 , u_dw_zkh.dim_streets
                 , u_dw_zkh.dim_cityes
                 , u_dw_zkh.dim_regions
               where u_dw_zkh.w_houses.street_name  = u_dw_zkh.dim_streets.street_name and
                     u_dw_zkh.dim_streets.city_id   = u_dw_zkh.dim_cityes.city_id      and
                     u_dw_zkh.w_houses.city_name    = u_dw_zkh.dim_cityes.city_name    and
                     u_dw_zkh.w_houses.region_name  = u_dw_zkh.dim_regions.region_name and
                     u_dw_zkh.dim_streets.region_id = u_dw_zkh.dim_regions.region_id
              ) sa
            on (sa.house_no = dw.house_no and sa.street_id = dw.street_id)
        when not matched then 
          insert (house_id, house_no, street_id, city_id, region_id, insert_dt, update_dt)
          values (sa.house_id, sa.house_no, sa.street_id, sa.city_id, sa.region_id, sysdate, sysdate);
          
    commit;
  end;
end;
