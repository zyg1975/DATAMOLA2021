create or replace package body pkg_dim_geo
as
  procedure load_dim_geo
  as
  begin
    merge into u_dw_zkh.dim_geo dw
        using (select house_id, street_id, city_id, region_id, payer_id from u_dw_zkh.w_geo) sa
            on (sa.house_id = dw.house_id and sa.street_id = dw.street_id and sa.city_id = dw.city_id and sa.region_id = dw.region_id and sa.payer_id = dw.payer_id)
        when not matched then 
          insert (house_id, street_id, city_id, region_id, payer_id, valid_from, insert_dt, is_active)
          values (sa.house_id, sa.street_id, sa.city_id, sa.region_id, sa.payer_id, sysdate, sysdate, '1');


    merge into u_dw_zkh.dim_geo dw
        using (select house_id, street_id, city_id, region_id, payer_id from u_dw_zkh.w_geo) sa
            on (sa.house_id = dw.house_id and sa.street_id = dw.street_id and sa.city_id = dw.city_id and sa.region_id = dw.region_id)
        when matched then
          update set dw.is_active = '0'
                   , dw.valid_to  = sysdate
          where dw.is_active = '1' and sa.payer_id != dw.payer_id;

    commit;
  end;
end;
