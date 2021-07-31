insert into t_streets (city_id, region_id, street_name)

with s1 as
(
select round(dbms_random.value(1,785)) as id
from 
dual
connect by level <= round(dbms_random.value(1,10)+1)


)
select t_cityes.city_id, t_cityes.region_id
, tmp_streets.name
from
t_cityes
CROSS JOIN s1
inner join tmp_streets on (s1.id=tmp_streets.id)
;
