create or replace package body pkg_etl_regions_cl
as  
  procedure load_clean_regions
   as
      cursor c_v is select distinct region_name from sa_zkh.sa_regions where region_name is not null;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_regions(region_name) values (i.region_name);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_regions;
end pkg_etl_regions_cl;
