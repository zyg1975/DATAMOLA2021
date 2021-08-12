create or replace package body pkg_etl_providers_cl
as  
  procedure load_clean_providers
   as
     cursor c_v is select distinct provider_name, provider_hier_name from sa_zkh.sa_providers where provider_name is not null;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_providers(provider_name, provider_hier_name) values (i.provider_name, i.provider_hier_name);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_providers;
end pkg_etl_providers_cl;
