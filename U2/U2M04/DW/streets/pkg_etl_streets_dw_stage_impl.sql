create or replace package body pkg_etl_streets_dw_stage
as procedure load_streets_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(150);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;
     
     street_id   cursor_number;
     city_id     cursor_number;
     region_id   cursor_number;
     street_name cursor_varchar;

     streets big_cursor;

     begin
       open streets for
         select source_cl.street_name as street_name_source_cl
              , stage.street_id       as street_id
              , city.city_id          as city_id
              , region.region_id      as region_id
         from (select distinct * from dw_cl_zkh.dw_cl_streets) source_cl
               left join dw_regions_data region on (source_cl.region_name = region.region_name)
               left join dw_cityes_data  city   on (source_cl.city_name   = city.city_name    and region.region_id = city.region_id)
               left join dw_streets_data stage  on (source_cl.street_name = stage.street_name and city.city_id = stage.city_id and region.region_id = stage.region_id)
               ;
   
       fetch streets bulk collect into street_name, street_id, city_id, region_id;
    
       close streets;
    
       for i in street_id.first .. street_id.last loop
         if ( street_id (i) is null ) then
           insert into dw_streets_data(street_id
                                     , street_name
                                     , city_id
                                     , region_id
                                     , insert_dt
                                     , update_dt)
                values (sq_streets.nextval
                      , street_name(i)
                      , city_id(i)
                      , region_id(i)
                      , sysdate
                      , null);
  
           commit;
         end if;
       end loop;
     end;
  end load_streets_dw;
end pkg_etl_streets_dw_stage;
