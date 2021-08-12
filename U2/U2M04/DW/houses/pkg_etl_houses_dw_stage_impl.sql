create or replace package body pkg_etl_houses_dw_stage
as procedure load_houses_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(10);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;
     
     house_id  cursor_number;
     street_id cursor_number;
     city_id   cursor_number;
     region_id cursor_number;
     house_no  cursor_varchar;

     houses big_cursor;

     begin
       open houses for
         select source_cl.house_no as house_no_source_cl
              , stage.house_id     as house_id
              , street.street_id   as street_id
              , city.city_id       as city_id
              , region.region_id   as region_id
         from (select distinct * from dw_cl_zkh.dw_cl_houses) source_cl
               left join dw_regions_data region on (source_cl.region_name = region.region_name)
               left join dw_cityes_data  city   on (source_cl.city_name   = city.city_name     and region.region_id = city.region_id)
               left join dw_streets_data street on (source_cl.street_name = street.street_name and region.region_id = street.region_id and city.city_id = street.city_id)
               left join dw_houses_data  stage  on (source_cl.house_no    = stage.house_no     and city.city_id = stage.city_id and region.region_id = stage.region_id)
               ;
   
       fetch houses bulk collect into house_no, house_id, street_id, city_id, region_id;
    
       close houses;
    
       for i in house_id.first .. house_id.last loop
         if ( house_id (i) is null ) then
           insert into dw_houses_data(house_id
                                    , house_no
                                    , street_id
                                    , city_id
                                    , region_id
                                    , insert_dt
                                    , update_dt)
                values (sq_houses.nextval
                      , house_no(i)
                      , street_id(i)
                      , city_id(i)
                      , region_id(i)
                      , sysdate
                      , null);
  
           commit;
         end if;
       end loop;
     end;
  end load_houses_dw;
end pkg_etl_houses_dw_stage;
