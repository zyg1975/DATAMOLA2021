create or replace package body pkg_etl_providers_dw_stage
as procedure load_providers_dw
as
 begin
   declare
     type cursor_varchar is table of varchar2(128);
     type cursor_number  is table of number(10);

     type big_cursor is ref cursor;

     provider_id      cursor_number;
     provider_hier_id cursor_number;
     provider_name    cursor_varchar;

     providers big_cursor;

     begin
       open providers for
         select source_cl.provider_name as provider_name_source_cl
              , stage.provider_id       as provider_id
         from (select distinct * from dw_cl_zkh.dw_cl_providers) source_cl
         left join dw_providers_data stage on (source_cl.provider_name = stage.provider_name)
         where source_cl.provider_hier_name is null;

       fetch providers bulk collect into provider_name, provider_id;

       close providers;

       for i in provider_id.first .. provider_id.last loop
         if ( provider_id (i) is null ) then
           insert into dw_providers_data(provider_id
                                       , provider_name
                                       , provider_hier_id
                                       , insert_dt
                                       , update_dt)
                values (sq_providers.nextval
                      , provider_name(i)
                      , null
                      , sysdate
                      , null);

           commit;
         else
           update dw_providers_data
             set provider_name    = provider_name(i)
               , provider_hier_id = null
               , update_dt        = sysdate
             where dw_providers_data.provider_id = provider_id(i);

           commit;
         end if;
       end loop;

       open providers for
         select source_cl.provider_name as provider_name_source_cl
              , stage.provider_id       as provider_id
              , owner.provider_id       as provider_hier_id
         from (select distinct * from dw_cl_zkh.dw_cl_providers) source_cl
         left join dw_providers_data stage on (source_cl.provider_name      = stage.provider_name)
         left join dw_providers_data owner on (source_cl.provider_hier_name = owner.provider_name)
         where source_cl.provider_hier_name is not null;

       fetch providers bulk collect into provider_name, provider_id, provider_hier_id;

       close providers;

       for i in provider_id.first .. provider_id.last loop
         if ( provider_id (i) is null ) then
           insert into dw_providers_data(provider_id
                                       , provider_name
                                       , provider_hier_id
                                       , insert_dt
                                       , update_dt)
                values (sq_providers.nextval
                      , provider_name(i)
                      , provider_hier_id(i)
                      , sysdate
                      , null);

           commit;
         else
           update dw_providers_data
             set provider_name    = provider_name(i)
               , provider_hier_id = provider_hier_id(i)
               , update_dt        = sysdate
             where dw_providers_data.provider_id = provider_id(i);

           commit;
         end if;
       end loop;
     end;
  end load_providers_dw;
end pkg_etl_providers_dw_stage;