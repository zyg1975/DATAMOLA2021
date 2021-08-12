create or replace package body pkg_etl_geo_dw_stage
as procedure load_geo_dw
as
 begin
   declare
     type cursor_number is table of number(10);

     type big_cursor is ref cursor;
     
     geo_id            cursor_number;
     house_id          cursor_number;
     street_id         cursor_number;
     city_id           cursor_number;
     region_id         cursor_number;
     payer_id          cursor_number;

     geo big_cursor;

     begin
       open geo for
         select house.house_id   as house_id
              , street.street_id as street_id
              , city.city_id     as city_id
              , region.region_id as region_id
              , payer.payer_id   as payer_id                  
              , stage.geo_id     as geo_id
         from (select distinct house_no
                             , street_name
                             , city_name
                             , region_name
                             , payer_noid from dw_cl_zkh.dw_cl_payments) source_cl
               left join dw_regions_data region on (source_cl.region_name = region.region_name)
               left join dw_cityes_data  city   on (source_cl.city_name   = city.city_name     and region.region_id = city.region_id)
               left join dw_streets_data street on (source_cl.street_name = street.street_name and region.region_id = street.region_id and city.city_id = street.city_id)
               left join dw_houses_data  house  on (source_cl.house_no    = house.house_no     and region.region_id = house.region_id  and city.city_id = house.city_id  and street.street_id = house.street_id)
               left join dw_payers_data  payer  on (source_cl.payer_noid  = payer.payer_noid)
               left join dw_gen_geo_data stage  on (house.house_id   = stage.house_id
                                                and street.street_id = stage.street_id
                                                and city.city_id     = stage.city_id
                                                and region.region_id = stage.region_id
                                                and payer.payer_id   = stage.payer_id);
   
       fetch geo bulk collect into house_id, street_id, city_id, region_id, payer_id, geo_id;
    
       close geo;
    
       for i in geo_id.first .. geo_id.last loop
         if ( geo_id (i) is null ) then
           insert into dw_gen_geo_data(geo_id,
                                       house_id,
                                       street_id,
                                       city_id,
                                       region_id,
                                       payer_id,
                                       is_active,
                                       valid_from,
                                       valid_to,
                                       insert_dt,
                                       update_dt)
                values (sq_geo.nextval
                      , house_id (i)
                      , street_id(i)
                      , city_id  (i)
                      , region_id(i)
                      , payer_id (i)
                      , '1'
                      , sysdate
                      , null
                      , sysdate
                      , null);
  
           commit;
         else
           update dw_gen_geo_data
             set is_active = '0'
               , valid_to  = sysdate
               , update_dt = sysdate
             where dw_gen_geo_data.geo_id    = geo_id   (i)
               and dw_gen_geo_data.house_id  = house_id (i)
               and dw_gen_geo_data.street_id = street_id(i)
               and dw_gen_geo_data.city_id   = city_id  (i)
               and dw_gen_geo_data.region_id = region_id(i)
               ;
   
           commit;
         end if;
       end loop;
     end;
  end load_geo_dw;
end pkg_etl_geo_dw_stage;
