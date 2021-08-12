create or replace package body pkg_etl_streets_cl
as  
  procedure load_clean_streets
   as
      cursor c_v is select distinct region_name, city_name, street_name from sa_zkh.sa_streets where region_name is not null and city_name is not null and street_name is not null;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_streets(region_name, city_name, street_name) values (i.region_name, i.city_name, i.street_name);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_streets;
end pkg_etl_streets_cl;
