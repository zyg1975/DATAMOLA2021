insert into sa_streets (city_name, region_name, street_name)

with s1 as
(
  select round(dbms_random.value(1,5297)) as id
  from dual
  connect by level <= round(dbms_random.value(1,10)+1)
)
select sa_cityes.city_name, sa_cityes.region_name, sa_streetnames.street_name
from
  sa_cityes
CROSS JOIN s1
inner join sa_streetnames on (s1.id=sa_streetnames.id)
;
