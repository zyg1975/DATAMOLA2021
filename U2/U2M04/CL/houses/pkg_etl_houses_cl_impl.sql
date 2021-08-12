create or replace package body pkg_etl_houses_cl
as  
  procedure load_clean_houses
   as
      cursor c_v is select distinct region_name, city_name, street_name, house_no from sa_zkh.sa_houses;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_houses(region_name, city_name, street_name, house_no) values (i.region_name, i.city_name, i.street_name, i.house_no);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_houses;
end pkg_etl_houses_cl;
