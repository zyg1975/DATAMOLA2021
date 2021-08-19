create or replace package body pkg_etl_cityes_dim
as procedure load_cityes_dim
as
 begin
    merge into dim_cityes dim
      using (select city_id, city_name, region_id, insert_dt, update_dt from dw_data_zkh.dw_cityes_data) dw
          on (dw.city_id = dim.city_id)
      when not matched then 
        insert (city_id, city_name, region_id, insert_dt, update_dt)
        values (dw.city_id, dw.city_name, dw.region_id, dw.insert_dt, dw.update_dt)
      when matched then
        update set city_name = dw.city_name;
          
    commit;
  end load_cityes_dim;
end pkg_etl_cityes_dim;
