create or replace package body pkg_dim_paysystems
as
  procedure load_dim_paysystems
  as
  begin
    declare
      cursor cp is select paysystem_id, paysystem_name from u_dw_zkh.w_paysystems;
      t_paysystem_id   u_dw_zkh.t_paysystems.paysystem_id%type;
      t_paysystem_name u_dw_zkh.t_paysystems.paysystem_name%type;
    
    begin
    execute immediate 'truncate table u_dw_zkh.dim_paysystems';

    open cp;

    loop  -- fetches 5 columns into variables
      fetch cp into t_paysystem_id, t_paysystem_name;
      exit when cp%notfound;
      insert into u_dw_zkh.dim_paysystems (paysystem_id, paysystem_name, insert_dt, update_dt)
                                   values (t_paysystem_id, t_paysystem_name, sysdate, sysdate);
    end loop;

    commit;

    close cp;
    end;
  end;
end;
