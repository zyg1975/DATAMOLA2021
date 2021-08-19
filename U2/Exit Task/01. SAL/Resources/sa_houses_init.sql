insert into sa_houses (city_name, region_name, street_name, house_no)

with s1 as
(
select round(dbms_random.value(1,100))+1 as no
from dual
connect by level <= round(dbms_random.value(1,7)+1)
)
select sa_streets.city_name, sa_streets.region_name, sa_streets.street_name, s1.no
from sa_streets
cross join s1
;	