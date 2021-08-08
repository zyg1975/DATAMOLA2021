
create or replace package body pkg_dim_services
as
  procedure load_dim_services
  as
  begin
    execute immediate 'truncate table u_dw_zkh.dim_services';
    declare
      type ñservices is ref cursor;

      type srv_id_arr      is table of u_dw_zkh.w_services.service_id%type;
      type srv_hier_id_arr is table of u_dw_zkh.w_services.service_hier_id%type;
      type srv_name_arr    is table of u_dw_zkh.w_services.service_name%type;

      cs          ñservices;
      srv_id      srv_id_arr;
      srv_hier_id srv_hier_id_arr;
      srv_name    srv_name_arr;

    begin
      open cs for select service_id, service_hier_id, service_name from u_dw_zkh.w_services;

      loop
        fetch cs bulk collect into srv_id, srv_hier_id, srv_name;

        forall i in 1..srv_id.count
          insert into u_dw_zkh.dim_services (service_id, service_hier_id, service_name, insert_dt, update_dt)
                                     values (srv_id(i), srv_hier_id(i), srv_name(i), sysdate, sysdate);

        commit;

        exit when cs%notfound;
      end loop;

      close cs;

    end;
  end;
end;
