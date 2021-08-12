create or replace package body pkg_etl_service_objects_cl
as  
  procedure load_clean_service_objects
   as
      cursor c_v is select distinct service_object_name from sa_zkh.sa_service_objects where service_object_name is not null;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_service_objects(service_object_name) values (i.service_object_name);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_service_objects;
end pkg_etl_service_objects_cl;
