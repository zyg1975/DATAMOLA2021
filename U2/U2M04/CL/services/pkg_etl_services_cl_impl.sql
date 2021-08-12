create or replace package body pkg_etl_services_cl
as  
  procedure load_clean_services
   as
     cursor c_v is select distinct service_name, service_hier_name from sa_zkh.sa_services where service_name is not null;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_services(service_name, service_hier_name) values (i.service_name, i.service_hier_name);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_services;
end pkg_etl_services_cl;
