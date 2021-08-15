create materialized view m_OnDemand
refresh complete on demand
as
(select to_char(date_issue_dt, 'mon') m
, to_char(sum(sum_issue),'999,999,999.99') as sm
, rank() over (order by sum(sum_issue) desc) as rnk
from dw_cl_payments
group by to_char(date_issue_dt, 'mon')
);

grant create any table to yzhdanovich;
grant create any materialized view to yzhdanovich;
grant create database link to yzhdanovich;

grant on commit refresh on dw_data_zkh.dw_payments_data to yzhdanovich;
grant query rewrite to yzhdanovich;
grant update on dw_data_zkh.dw_payments_data to yzhdanovich;

create materialized view log on dw_data_zkh.dw_payments_data
with rowid, sequence (
 payment_id
,paysystem_id
,provider_id
,service_id
,service_object_id
,geo_id
,date_issue_dt
,date_pay_dt
,sum_issue
,sum_pay
)
including new values;

create materialized view m_OnCommit
refresh complete on demand
as
(select
  to_char(date_issue_dt, 'mon') m
, sum(sum_issue)
from dw_data_zkh.dw_payments_data
group by to_char(date_issue_dt, 'mon')
);

create materialized view m_OnTime
refresh complete next sysdate + numtodsinterval(1, 'Minute')
as
(select
  to_char(date_issue_dt, 'mon') m
, sum(sum_issue)
from dw_data_zkh.dw_payments_data
group by to_char(date_issue_dt, 'mon')
);
