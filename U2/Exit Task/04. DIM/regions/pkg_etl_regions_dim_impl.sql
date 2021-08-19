create or replace package body pkg_etl_regions_dim
as procedure load_regions_dim
as
 begin
    merge into dim_regions dim
      using (select region_id, region_name, insert_dt, update_dt from dw_data_zkh.dw_regions_data) dw
          on (dw.region_id = dim.region_id)
      when not matched then 
        insert (region_id, region_name, insert_dt, update_dt)
        values (dw.region_id, dw.region_name, dw.insert_dt, dw.update_dt)
      when matched then
        update set region_name = dw.region_name;
          
    commit;
  end load_regions_dim;
end pkg_etl_regions_dim;
