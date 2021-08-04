drop tablespace ts_SB_MBackUp including contents cascade constraints;

create tablespace ts_SB_MBackUp
datafile '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/ts_SB_MBackUp.dat'
size 20M
 autoextend on next 5M
 segment space management auto;

CREATE USER u_SB_MBackUp
  IDENTIFIED BY u_SB_MBackUp123
    DEFAULT TABLESPACE ts_SB_MBackUp;

alter user u_SB_MBackUp quota unlimited on ts_SB_MBackUp;

GRANT all privileges TO u_SB_MBackUp;

--Task 2.1
drop table geo;
create table geo as
select
  parent_geo_id  parent_id
, child_geo_id   geo_id
, decode(level, 1, 'ROOT', 2, 'BRANCH', 'LEAF' ) geo_id_type
, decode((select count(*) from u_dw_references.t_geo_object_links lnk2 where lnk1.child_geo_id = lnk2.parent_geo_id), 0, null
       , (select count(*) from u_dw_references.t_geo_object_links lnk2 where lnk1.child_geo_id = lnk2.parent_geo_id)) child_cnt
, SUBSTR(sys_connect_by_path(parent_geo_id, '->'), 3, LENGTH(sys_connect_by_path(parent_geo_id, '->'))) full_path
from
  u_dw_references.t_geo_object_links lnk1
connect by prior child_geo_id = parent_geo_id
order siblings by child_geo_id;

--Task 2.2
select lpad(' ', level*2, ' ') || t.provider_hier_id parent, t.provider_id child,
       connect_by_root t.provider_hier_id as root,
       decode(level, 1, 'head', 'local') as lvl, sys_connect_by_path(t.provider_name,'->') path
from t_providers t
start with t.provider_hier_id is null
connect by prior t.provider_id = t.provider_hier_id
order siblings by t.provider_name
;
