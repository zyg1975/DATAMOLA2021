create or replace package body pkg_etl_streets_dim
as procedure load_streets_dim
as
 begin
    merge into dim_streets dim
      using (select street_id, street_name, city_id, region_id, insert_dt, update_dt from dw_data_zkh.dw_streets_data) dw
          on (dw.street_id = dim.street_id)
      when not matched then 
        insert (street_id, street_name, city_id, region_id, insert_dt, update_dt)
        values (dw.street_id, dw.street_name, dw.city_id, dw.region_id, dw.insert_dt, dw.update_dt)
      when matched then
        update set street_name = dw.street_name
                 , city_id     = dw.city_id
                 , region_id   = dw.region_id
                 , insert_dt   = dw.insert_dt
                 , update_dt   = dw.update_dt
                 ;
          
    commit;
  end load_streets_dim;
end pkg_etl_streets_dim;
