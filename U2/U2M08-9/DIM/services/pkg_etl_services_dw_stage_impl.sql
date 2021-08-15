create or replace package body pkg_etl_services_dim
as procedure load_services_dim
as
 begin
    merge into dim_services dim
      using (select service_id, service_hier_id, service_name, insert_dt, update_dt from dw_data_zkh.dw_services_data) dw
          on (dw.service_id = dim.service_id)
      when not matched then 
        insert (service_id, service_hier_id, service_name, insert_dt, update_dt)
        values (dw.service_id, dw.service_hier_id, dw.service_name, dw.insert_dt, dw.update_dt)
      when matched then
        update set service_name = dw.service_name, service_hier_id = dw.service_hier_id;
          
    commit;
  end load_services_dim;
end pkg_etl_services_dim;