create or replace package body pkg_etl_providers_dim as
procedure load_providers_dim as
begin
  declare
    type type_rec is record
    (
      provider_name    varchar2(100)
    , provider_id      number(10)
    , provider_hier_id number(10)
    , insert_dt        date
    , provider_id_src  number(10)
    );

    type type_provider IS REF CURSOR;
    t_provider type_provider;

    rprovider type_rec;

    curid     number  (25);
    query_cur varchar2(2000);
    ret       number  (25);

    type cursor_varchar is table of varchar2(100);
    type cursor_number  is table of number(10);
    type cursor_date    is table of date;

    type big_cursor is ref cursor;

    providers big_cursor;

    begin
      query_cur :=
        'select source_dw.provider_name    as provider_name_src
              , source_dw.provider_id      as provider_id_src
              , source_dw.provider_hier_id as provider_hier_id_src
              , source_dw.insert_dt        as insert_dt_src
              , stage.provider_id          as provider_id
         from (select distinct * from dw_data_zkh.dw_providers_data) source_dw
         left join dim_providers stage on (source_dw.provider_id = stage.provider_id)';

      curid := dbms_sql.open_cursor;

      dbms_sql.parse(curid, query_cur, dbms_sql.native);

      ret := dbms_sql.execute(curid);
      
      t_provider := dbms_sql.to_refcursor(curid);

      loop
        fetch t_provider into rprovider;
        exit when t_provider%notfound;

        if ( rprovider.provider_id_src is null) then
          insert into dim_providers(provider_id
                                  , provider_hier_id
                                  , provider_name
                                  , insert_dt
                                  , update_dt)
               values (rprovider.provider_id
                     , rprovider.provider_hier_id
                     , rprovider.provider_name
                     , rprovider.insert_dt
                     , null);

          commit;
        else
          update dim_providers
            set provider_name    = rprovider.provider_name
              , provider_hier_id = rprovider.provider_hier_id
              , update_dt        = sysdate
            where dim_providers.provider_id = rprovider.provider_id;

          commit;
        end if;
      end loop;
    end;
end load_providers_dim;
end pkg_etl_providers_dim;
