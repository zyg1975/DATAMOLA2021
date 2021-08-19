create or replace package body pkg_etl_service_objects_dim
as procedure load_service_objects_dim
as
 begin
    merge into dim_service_objects dim
      using (select service_object_id, service_object_name, insert_dt, update_dt from dw_data_zkh.dw_service_objects_data) dw
          on (dw.service_object_id = dim.service_object_id)
      when not matched then 
        insert (service_object_id, service_object_name, insert_dt, update_dt)
        values (dw.service_object_id, dw.service_object_name, dw.insert_dt, dw.update_dt)
      when matched then
        update set service_object_name = dw.service_object_name;
          
    commit;
  end load_service_objects_dim;
end pkg_etl_service_objects_dim;
