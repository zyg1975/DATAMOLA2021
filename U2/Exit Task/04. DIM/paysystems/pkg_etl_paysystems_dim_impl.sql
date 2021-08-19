create or replace package body pkg_etl_paysystems_dim
as procedure load_paysystems_dim
as
 begin
   declare
     type tpaysystem is ref cursor;

     src_cur tpaysystem;

     ps_name      varchar2(100);
     ps_id_src    number(10);
     ps_insert_dt date;
     ps_id        number(10);

     curid   number(25);
     colcnt  number;
     desctab dbms_sql.desc_tab;
 
     begin
       open src_cur for
         select
           source_dw.paysystem_name as paysystem_name_src
         , source_dw.paysystem_id   as paysystem_id_src
         , source_dw.insert_dt      as insert_dt_src
         , stage.paysystem_id       as paysystem_id
         from (select distinct * from dw_data_zkh.dw_paysystems_data) source_dw
         left join dim_paysystems stage on (source_dw.paysystem_id = stage.paysystem_id);

       curid := dbms_sql.to_cursor_number (src_cur);
       dbms_sql.describe_columns(curid,colcnt,desctab);

       dbms_sql.define_column(curid,1,ps_name,100);
       dbms_sql.define_column(curid,2,ps_id_src);
       dbms_sql.define_column(curid,3,ps_insert_dt);
       dbms_sql.define_column(curid,4,ps_id);

       while dbms_sql.fetch_rows (curid) > 0
       loop
         dbms_sql.column_value (curid, 1, ps_name);
         dbms_sql.column_value (curid, 2, ps_id_src);
         dbms_sql.column_value (curid, 3, ps_insert_dt);
         dbms_sql.column_value (curid, 4, ps_id);

         if ( ps_id is null ) then
           insert into dim_paysystems( paysystem_id
                                     , paysystem_name
                                     , insert_dt
                                     , update_dt)
                values (ps_id_src
                      , ps_name
                      , ps_insert_dt
                      , null);
       
                commit;
         else
           update dim_paysystems
             set paysystem_name = ps_name
               , update_dt      = sysdate
             where dim_paysystems.paysystem_id = ps_id;
           commit;
         end if;
       end loop;
       dbms_sql.close_cursor (curid);
     end;
  end load_paysystems_dim;
end pkg_etl_paysystems_dim;
