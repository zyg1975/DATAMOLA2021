select distinct
  nvl(region_name , 'all regions' ) as region_name
, nvl(service_name, 'all services') as services
, sm
from dw_cl_payments
where trunc(date_issue_dt, 'mm') = to_date('12.01.20', 'mm.dd.yy')
group by cube(region_name, service_name) 
having region_name is not null 
model dimension by (region_name, service_name)
measures (sum(sum_issue) sm)
rules(sm[null, for service_name in (select service_name from dw_cl_payments group by service_name)] = sum (sm)[any, cv(service_name)])
order by region_name, services, sm desc;

