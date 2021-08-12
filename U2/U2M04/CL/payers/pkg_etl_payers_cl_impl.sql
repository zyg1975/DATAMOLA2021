create or replace package body pkg_etl_payers_cl
as  
  procedure load_clean_payers
   as
     cursor c_v is select distinct payer_noid, payer_fio from sa_zkh.sa_payers where payer_noid is not null and payer_fio is not null;

   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_payers(payer_noid, payer_fio) values (i.payer_noid, i.payer_fio);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_payers;
end pkg_etl_payers_cl;
