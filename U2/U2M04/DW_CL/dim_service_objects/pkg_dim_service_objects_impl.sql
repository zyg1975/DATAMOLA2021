create or replace package body pkg_dim_srv_objects
as
  procedure load_dim_service_objects
  as
  begin
    merge into u_dw_zkh.dim_service_objects dw
        using (select service_object_id, service_object_name from u_dw_zkh.w_service_objects) sa
            on (sa.service_object_name = dw.service_object_name)
        when not matched then 
          insert (service_object_id, service_object_name, insert_dt, update_dt)
          values (sa.service_object_id, sa.service_object_name, sysdate, sysdate);

    commit;
  end;
end;
