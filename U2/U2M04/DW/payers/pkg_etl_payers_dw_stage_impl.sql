create or replace package body pkg_etl_payers_dw_stage
as procedure load_payers_dw
as
 begin
   declare
     type cursor_varchar1 is table of varchar2(14);
     type cursor_varchar2 is table of varchar2(100);
     type cursor_number   is table of number(10);

     type big_cursor is ref cursor;
     
     payer_id   cursor_number;
     payer_fio  cursor_varchar2;
     payer_noid cursor_varchar1;

     payers big_cursor;

     begin
       open payers for
         select source_cl.payer_noid as payer_noid_source_cl
              , source_cl.payer_fio  as payer_fio_source_cl
              , stage.payer_id       as payer_id
         from (select distinct * from dw_cl_zkh.dw_cl_payers) source_cl
               left join dw_payers_data stage on (source_cl.payer_noid = stage.payer_noid);
   
       fetch payers bulk collect into payer_noid, payer_fio, payer_id;
    
       close payers;
    
       for i in payer_id.first .. payer_id.last loop
         if ( payer_id (i) is null ) then
           insert into dw_payers_data(payer_id
                                    , payer_fio
                                    , payer_noid
                                    , insert_dt
                                    , update_dt)
                values (sq_payers.nextval
                      , payer_fio(i)
                      , payer_noid(i)
                      , sysdate
                      , null);
  
           commit;
         else
           update dw_payers_data
             set payer_fio = payer_fio(i)
               , update_dt  = sysdate
             where dw_payers_data.payer_id = payer_id(i);
   
           commit;
         end if;
       end loop;
     end;
  end load_payers_dw;
end pkg_etl_payers_dw_stage;
