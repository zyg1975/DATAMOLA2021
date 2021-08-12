create or replace package body pkg_etl_payments_dw_stage
as procedure load_payments_dw
as
 begin
   declare
     type cursor_number is table of number(10);
     type cursor_date   is table of date;
     type cursor_sum    is table of number(10,2);

     type big_cursor is ref cursor;
     
     payment_id        cursor_number;
     paysystem_id      cursor_number;
     provider_id       cursor_number;
     service_id        cursor_number;
     service_object_id cursor_number;
     geo_id            cursor_number;
     date_issue_dt     cursor_date;
     date_pay_dt       cursor_date;
     sum_issue         cursor_sum;
     sum_pay           cursor_sum;

     payments big_cursor;

     begin
       open payments for
         select paysystem.paysystem_id           as paysystem_id          
              , provider.provider_id             as provider_id            
              , services.service_id              as service_id              
              , service_object.service_object_id as service_object_id
              , geo.geo_id                       as geo_id
              , source_cl.date_issue_dt          as date_issue_dt
              , source_cl.date_pay_dt            as date_pay_dt
              , source_cl.sum_issue              as sum_issue
              , source_cl.sum_pay                as sum_pay
              , stage.payment_id                 as payment_id
         from (select distinct paysystem_name
                             , provider_name
                             , service_name
                             , service_object_name
                             , house_no
                             , street_name
                             , city_name
                             , region_name
                             , payer_noid 
                             , date_issue_dt
                             , date_pay_dt
                             , sum_issue
                             , sum_pay
               from dw_cl_zkh.dw_cl_payments) source_cl
               left join dw_paysystems_data      paysystem      on (source_cl.paysystem_name      = paysystem.paysystem_name)
               left join dw_providers_data       provider       on (source_cl.provider_name       = provider.provider_name)
               left join dw_services_data        services       on (source_cl.service_name        = services.service_name)
               left join dw_service_objects_data service_object on (source_cl.service_object_name = service_object.service_object_name)
               left join dw_payers_data          payer          on (source_cl.payer_noid          = payer.payer_noid)

               left join dw_regions_data region on (source_cl.region_name = region.region_name)
               left join dw_cityes_data  city   on (source_cl.city_name   = city.city_name     and region.region_id = city.region_id)
               left join dw_streets_data street on (source_cl.street_name = street.street_name and region.region_id = street.region_id and city.city_id = street.city_id)
               left join dw_houses_data  house  on (source_cl.house_no    = house.house_no     and region.region_id = house.region_id  and city.city_id = house.city_id  and street.street_id = house.street_id)

               left join dw_gen_geo_data geo on (house.house_id   = geo.house_id  and
                                                 street.street_id = geo.street_id and
                                                 city.city_id     = geo.city_id   and
                                                 region.region_id = geo.region_id and
                                                 payer.payer_id   = geo.payer_id)

               left join dw_payments_data stage on (paysystem.paysystem_id           = stage.paysystem_id      and
                                                    provider.provider_id             = stage.provider_id       and
                                                    services.service_id              = stage.service_id        and
                                                    service_object.service_object_id = stage.service_object_id and
                                                    geo.geo_id                       = stage.geo_id            and
                                                    source_cl.date_issue_dt          = stage.date_issue_dt
                                                    );
   
       fetch payments bulk collect into paysystem_id          
                                      , provider_id            
                                      , service_id              
                                      , service_object_id
                                      , geo_id
                                      , date_issue_dt
                                      , date_pay_dt  
                                      , sum_issue    
                                      , sum_pay      
                                      , payment_id
                                      ;
    
       close payments;
    
       for i in payment_id.first .. payment_id.last loop
         if ( payment_id (i) is null ) then
           insert into dw_payments_data(payment_id,
                                        paysystem_id,
                                        provider_id,
                                        service_id,
                                        service_object_id,
                                        geo_id,
                                        date_issue_dt,
                                        date_pay_dt,
                                        sum_issue,
                                        sum_pay,
                                        insert_dt,
                                        update_dt)
                values (sq_payments.nextval,
                        paysystem_id(i),
                        provider_id(i),
                        service_id(i),
                        service_object_id(i),
                        geo_id(i),
                        date_issue_dt(i),
                        date_pay_dt(i),
                        sum_issue(i),
                        sum_pay(i),
                        sysdate,
                        null);
  
           commit;
         else
           update dw_payments_data
             set date_pay_dt = date_pay_dt(i)
               , sum_issue   = sum_issue  (i)
               , sum_pay     = sum_pay    (i)
               , update_dt   = sysdate
             where dw_payments_data.paysystem_id = paysystem_id(i);
   
           commit;
         end if;
       end loop;
     end;
  end load_payments_dw;
end pkg_etl_payments_dw_stage;
