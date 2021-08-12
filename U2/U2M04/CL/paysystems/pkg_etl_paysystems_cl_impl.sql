create or replace package body pkg_etl_paysystems_cl
as  
  procedure load_clean_paysystems
   as
      cursor c_v is select distinct paysystem_name from sa_zkh.sa_paysystems where paysystem_name is not null;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_paysystems(paysystem_name) values (i.paysystem_name);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_paysystems;
end pkg_etl_paysystems_cl;
