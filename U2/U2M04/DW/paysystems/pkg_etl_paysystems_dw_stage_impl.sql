create or replace package body pkg_etl_paysystems_dw_stage
as procedure load_paysystems_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(100);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;
     
     paysystem_id   cursor_number;
     paysystem_name cursor_varchar;

     paysystems big_cursor;

     begin
       open paysystems for
         select source_cl.paysystem_name as paysystem_name_source_cl
              , stage.paysystem_id       as paysystem_id
         from (select distinct * from dw_cl_zkh.dw_cl_paysystems) source_cl
               left join dw_paysystems_data stage on (source_cl.paysystem_name = stage.paysystem_name);
   
       fetch paysystems bulk collect into paysystem_name, paysystem_id;
    
       close paysystems;
    
       for i in paysystem_id.first .. paysystem_id.last loop
         if ( paysystem_id (i) is null ) then
           insert into dw_paysystems_data(paysystem_id
                                        , paysystem_name
                                        , insert_dt
                                        , update_dt)
                values (sq_paysystems.nextval
                      , paysystem_name(i)
                      , sysdate
                      , null);
  
           commit;
         else
           update dw_paysystems_data
             set paysystem_name = paysystem_name(i)
               , update_dt      = sysdate
             where dw_paysystems_data.paysystem_id = paysystem_id(i);
   
           commit;
         end if;
       end loop;
     end;
  end load_paysystems_dw;
end pkg_etl_paysystems_dw_stage;
