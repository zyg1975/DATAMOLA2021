create or replace package body pkg_etl_service_objects_dw_stage
as procedure load_service_objects_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(128);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;
     
     service_object_id   cursor_number;
     service_object_name cursor_varchar;

     service_objects big_cursor;

     begin
       open service_objects for
         select source_cl.service_object_name as service_object_name_source_cl
              , stage.service_object_id       as service_object_id
         from (select distinct * from dw_cl_zkh.dw_cl_service_objects) source_cl
               left join dw_service_objects_data stage on (source_cl.service_object_name = stage.service_object_name);
   
       fetch service_objects bulk collect into service_object_name, service_object_id;
    
       close service_objects;
    
       for i in service_object_id.first .. service_object_id.last loop
         if ( service_object_id (i) is null ) then
           insert into dw_service_objects_data(service_object_id
                                             , service_object_name
                                             , insert_dt
                                             , update_dt)
                values (sq_service_objects.nextval
                      , service_object_name(i)
                      , sysdate
                      , null);
  
           commit;
         else
           update dw_service_objects_data
             set service_object_name = service_object_name(i)
               , update_dt           = sysdate
             where dw_service_objects_data.service_object_id = service_object_id(i);
   
           commit;
         end if;
       end loop;
     end;
  end load_service_objects_dw;
end pkg_etl_service_objects_dw_stage;
