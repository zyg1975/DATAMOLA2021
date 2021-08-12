create or replace package body pkg_etl_cityes_cl
as  
  procedure load_clean_cityes
   as
      cursor c_v is select distinct region_name, city_name from sa_zkh.sa_cityes where city_name is not null and region_name is not null;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_cityes(region_name, city_name) values (i.region_name, i.city_name);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_cityes;
end pkg_etl_cityes_cl;
