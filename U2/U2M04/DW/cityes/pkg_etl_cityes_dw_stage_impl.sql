create or replace package body pkg_etl_cityes_dw_stage
as procedure load_cityes_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(100);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;
     
     city_id   cursor_number;
     region_id cursor_number;
     city_name cursor_varchar;

     cityes big_cursor;

     begin
       open cityes for
         select source_cl.city_name as city_name_source_cl
              , stage.city_id       as city_id
              , region.region_id    as region_id
         from (select distinct * from dw_cl_zkh.dw_cl_cityes) source_cl
               left join dw_cityes_data  stage  on (source_cl.city_name   = stage.city_name)
               left join dw_regions_data region on (source_cl.region_name = region.region_name)
               ;
   
       fetch cityes bulk collect into city_name, city_id, region_id;
    
       close cityes;
    
       for i in city_id.first .. city_id.last loop
         if ( city_id (i) is null ) then
           insert into dw_cityes_data(city_id
                                    , city_name
                                    , region_id
                                    , insert_dt
                                    , update_dt)
                values (sq_cityes.nextval
                      , city_name(i)
                      , region_id(i)
                      , sysdate
                      , null);
  
           commit;
         else
           update dw_cityes_data
             set city_name = city_name  (i)
               , region_id = region_id(i)
               , update_dt = sysdate
             where dw_cityes_data.city_id = city_id(i);
   
           commit;
         end if;
       end loop;
     end;
  end load_cityes_dw;
end pkg_etl_cityes_dw_stage;
