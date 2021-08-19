set autotrace on;
select
  decode ( grouping ( region_name  ), 1, 'all regions' , region_name  ) as region
, decode ( grouping ( service_name ), 1, 'all services', service_name ) as service
, sum ( sum_issue ) as rs_sum
from sa_zkh.sa_payments
where to_char(date_issue_dt, 'mm') = 12
group by to_char(date_issue_dt, 'mm'), cube (region_name, service_name)
having grouping_id (region_name) < 1
order by 1,2,rs_sum;

set autotrace on;
select
--  to_char(date_issue_dt, 'mm') as month_dt
 decode ( grouping ( region_id  ), 1, 'all regions' , region_id  ) as region
, decode ( grouping ( service_id ), 1, 'all services', service_id ) as service
, sum ( sum_issue ) as rs_sum
from dw_data_zkh.dw_payments_data p
inner join dw_data_zkh.dw_gen_geo_data g on p.geo_id = g.geo_id
where to_char(date_issue_dt, 'mm') = 12
group by to_char(date_issue_dt, 'mm'), cube (region_id, service_id)
having grouping_id (region_id) < 1
order by 1,2,rs_sum;
