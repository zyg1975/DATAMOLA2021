set autotrace on explain;
select
  decode ( grouping ( p.region_id  ), 1, 'all regions' , (select region_name  from dim_regions  where p.region_id  = dim_regions.region_id  ) ) as region_name
, decode ( grouping ( p.service_id ), 1, 'all services', (select service_name from dim_services where p.service_id = dim_services.service_id) ) as service_name
, sum(sum_issue) rs_sum
from
    t_rs_fact_payments_dd p
--left join dim_date on date_issue_dt = time_id and calendar_quarter_number = 4
where to_char(date_issue_dt, 'mm') between 10 and 12
group by cube(p.region_id, p.service_id)
--having grouping_id (p.region_id) < 1
order by region_name, rs_sum desc, service_name
;

set autotrace on explain;
select
  decode ( grouping ( region_name  ), 1, 'all regions' , region_name  ) as region_name
, decode ( grouping ( service_name ), 1, 'all services', service_name ) as service_name
, sum ( sum_issue ) as rs_sum
from sa_zkh.sa_payments
where to_char(date_issue_dt, 'mm') between 10 and 12
group by cube (region_name, service_name)
--having grouping_id (region_name) < 1
order by region_name, rs_sum desc, service_name
;

set autotrace on explain;
select distinct
  nvl(region_name , 'all regions' ) as region_name
, nvl(service_name, 'all services') as service_name
, sm
from dw_cl_zkh.dw_cl_payments
where to_char(date_issue_dt, 'mm') between 10 and 12
group by cube(region_name, service_name) 
having region_name is not null 
model dimension by (region_name, service_name)
measures (sum(sum_issue) sm)
rules(sm[null, for service_name in (select service_name from dw_cl_zkh.dw_cl_payments group by service_name)] = sum (sm)[any, cv(service_name)])
--rules()
order by region_name, sm desc, service_name
;

