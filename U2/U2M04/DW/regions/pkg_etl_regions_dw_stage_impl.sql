create or replace package body pkg_etl_regions_dw_stage
as procedure load_regions_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(128);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;
     
     region_id   cursor_number;
     region_name cursor_varchar;

     regions big_cursor;

     begin
       open regions for
         select source_cl.region_name as region_name_source_cl
              , stage.region_id       as region_id
         from (select distinct * from dw_cl_zkh.dw_cl_regions) source_cl
               left join dw_regions_data stage on (source_cl.region_name = stage.region_name);
   
       fetch regions bulk collect into region_name, region_id;
    
       close regions;
    
       for i in region_id.first .. region_id.last loop
         if ( region_id (i) is null ) then
           insert into dw_regions_data(region_id
                                     , region_name
                                     , insert_dt
                                     , update_dt)
                values (sq_regions.nextval
                      , region_name(i)
                      , sysdate
                      , null);
  
           commit;
         else
           update dw_regions_data
             set region_name = region_name(i)
               , update_dt   = sysdate
             where dw_regions_data.region_id = region_id(i);
   
           commit;
         end if;
       end loop;
     end;
  end load_regions_dw;
end pkg_etl_regions_dw_stage;
