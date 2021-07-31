insert into t_houses (city_id, region_id, street_id, house_no)

with s1 as
(
select round(dbms_random.value(1,100))+1 as no
from 
dual
connect by level <= round(dbms_random.value(1,7)+1)


)
select t_streets.city_id, t_streets.region_id, t_streets.street_id
, s1.no
from
t_streets
CROSS JOIN s1
;