insert into sa_payers(payer_fio,payer_noid)
select
  (dbms_random.string('U', 1)||dbms_random.string('L', floor(dbms_random.value(5, 10))))
  || ' ' ||
  (dbms_random.string('U', 1)||dbms_random.string('L', floor(dbms_random.value(5, 10))))
  || ' ' ||
  (dbms_random.string('U', 1)||dbms_random.string('L', floor(dbms_random.value(5, 10)))) as FIO
, pass
from
(
  select distinct Pass
  from
  (
  select
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    'B'
    ||
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    floor(dbms_random.value(1, 10))
    ||
    'PB'
    ||
    floor(dbms_random.value(1, 10))
   as Pass

  from dual
  connect by level <= 1000000
  )
);

/*
merge into sa_payers
using
(
select
dbms_random.string('U', 1)
||
dbms_random.string('L', floor(dbms_random.value(5, 10)))
|| ' ' ||
(dbms_random.string('U', 1)
||
dbms_random.string('L', floor(dbms_random.value(5, 10))))
|| ' ' ||
(dbms_random.string('U', 1)||dbms_random.string('L', floor(dbms_random.value(5, 10)))
) as FIO
, pass
from
(
select distinct Pass
from
(
select floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||
'B'
||floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||floor(dbms_random.value(1, 10))||
'PB'
||floor(dbms_random.value(1, 10))
as Pass

from dual
connect by level <= 500000
)
)
)t
on (t.pass = sa_payers.payer_noid)
when not matched then 
  insert (payer_fio,payer_noid)
  values (t.fio, t.pass );
  
*/