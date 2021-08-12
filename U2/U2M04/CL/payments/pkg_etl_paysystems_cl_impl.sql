create or replace package body pkg_etl_payments_cl
as  
  procedure load_clean_payments
   as
      cursor c_v is select distinct 
                      paysystem_name
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
                    from sa_zkh.sa_payments
                    where paysystem_name is not null
                      and provider_name is not null
                      and service_name is not null
                      and service_object_name is not null
                      and house_no is not null
                      and street_name is not null
                      and city_name is not null
                      and region_name is not null
                      and payer_noid is not null
                      and date_issue_dt is not null
                      and sum_issue is not null
                    ;
   begin
      for i in c_v loop
         insert into dw_cl_zkh.dw_cl_payments(paysystem_name
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
                                            , sum_pay)
                                    values (i.paysystem_name
                                          , i.provider_name
                                          , i.service_name
                                          , i.service_object_name
                                          , i.house_no
                                          , i.street_name
                                          , i.city_name
                                          , i.region_name
                                          , i.payer_noid
                                          , i.date_issue_dt
                                          , i.date_pay_dt
                                          , i.sum_issue
                                          , i.sum_pay);

         exit when c_v%notfound;
      end loop;

      commit;
   end load_clean_payments;
end pkg_etl_payments_cl;
