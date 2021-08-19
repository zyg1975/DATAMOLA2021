create or replace package body pkg_etl_houses_dim
as procedure load_houses_dim
as
 begin
    merge into dim_houses dim
      using (select house_id, house_no, region_id, city_id, street_id, insert_dt, update_dt from dw_data_zkh.dw_houses_data) dw
          on (dw.house_id = dim.house_id)
      when not matched then 
        insert (house_id, house_no, region_id, city_id, street_id, insert_dt, update_dt)
        values (dw.house_id, dw.house_no, dw.region_id, dw.city_id, dw.street_id, dw.insert_dt, dw.update_dt)
      when matched then
        update set house_no  = dw.house_no
                 , region_id = dw.region_id
                 , city_id   = dw.city_id
                 , street_id = dw.street_id
                 ;
          
    commit;
  end load_houses_dim;
end pkg_etl_houses_dim;
