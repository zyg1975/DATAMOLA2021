create or replace package body pkg_etl_services_dw_stage
as procedure load_services_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(128);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;

     service_id      cursor_number;
     service_hier_id cursor_number;
     service_name    cursor_varchar;

     services big_cursor;

     begin
       open services for
         select source_cl.service_name as service_name_source_cl
              , stage.service_id       as service_id
         from (select distinct * from dw_cl_zkh.dw_cl_services) source_cl
         left join dw_services_data stage on (source_cl.service_name = stage.service_name)
         where source_cl.service_hier_name is null;

       fetch services bulk collect into service_name, service_id;

       close services;

       for i in service_id.first .. service_id.last loop
         if ( service_id (i) is null ) then
           insert into dw_services_data(service_id
                                      , service_name
                                      , service_hier_id
                                      , insert_dt
                                      , update_dt)
                values (sq_services.nextval
                      , service_name(i)
                      , null
                      , sysdate
                      , null);

           commit;
         else
           update dw_services_data
             set service_name    = service_name(i)
               , service_hier_id = null
               , update_dt       = sysdate
             where dw_services_data.service_id = service_id(i);

           commit;
         end if;
       end loop;

       open services for
         select source_cl.service_name as service_name_source_cl
              , stage.service_id       as service_id
              , owner.service_id       as service_hier_id
         from (select distinct * from dw_cl_zkh.dw_cl_services) source_cl
         left join dw_services_data stage on (source_cl.service_name      = stage.service_name)
         left join dw_services_data owner on (source_cl.service_hier_name = owner.service_name)
         where source_cl.service_hier_name is not null;

       fetch services bulk collect into service_name, service_id, service_hier_id;

       close services;

       for i in service_id.first .. service_id.last loop
         if ( service_id (i) is null ) then
           insert into dw_services_data(service_id
                                      , service_name
                                      , service_hier_id
                                      , insert_dt
                                      , update_dt)
                values (sq_services.nextval
                      , service_name(i)
                      , service_hier_id(i)
                      , sysdate
                      , null);

           commit;
         else
           update dw_services_data
             set service_name    = service_name(i)
               , service_hier_id = service_hier_id(i)
               , update_dt       = sysdate
             where dw_services_data.service_id = service_id(i);

           commit;
         end if;
       end loop;
     end;
  end load_services_dw;
end pkg_etl_services_dw_stage;