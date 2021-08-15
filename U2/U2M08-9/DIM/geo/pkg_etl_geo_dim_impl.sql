create or replace package body pkg_etl_geo_dim as
procedure load_geo_dim as
 begin
    merge into dim_geo dim
      using (select geo_id, house_id, street_id, city_id, region_id, payer_id, insert_dt, update_dt from dw_data_zkh.dw_gen_geo_data) dw
          on (dw.geo_id = dim.geo_id)
      when not matched then 
        insert (geo_id, house_id, street_id, city_id, region_id, payer_id, insert_dt, update_dt)
        values (dw.geo_id, dw.house_id, dw.street_id, dw.city_id, dw.region_id, dw.payer_id, dw.insert_dt, dw.update_dt)
      when matched then
        update set house_id = dw.house_id, street_id = dw.street_id, city_id = dw.city_id, region_id = dw.region_id, payer_id = dw.payer_id;

    commit;
  end load_geo_dim;
end pkg_etl_geo_dim;