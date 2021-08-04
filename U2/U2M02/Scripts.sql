--Task 3.1
select 
  decode(grouping(t_regions.region_name),1, 'all income region', t_regions.region_name) region_level
, decode(grouping(t_cityes.city_name   ),1, 'all income city'  , t_cityes.city_name   ) city_level
, decode(grouping(t_streets.street_name),1, 'all income street', t_streets.street_name) street_level
, sum(sum_issue) as sums
, grouping(t_regions.region_name)
, grouping(t_cityes.city_name)
, GROUPING_ID(t_regions.region_name,t_cityes.city_name,t_streets.street_name) grouping_level

from t_payments

inner join t_regions on t_payments.region_id=t_regions.region_id
inner join t_cityes on t_payments.city_id=t_cityes.city_id
inner join t_streets on t_payments.street_id=t_streets.street_id

group by cube(t_regions.region_name, t_cityes.city_name, t_streets.street_name)

having GROUPING_ID(t_regions.region_name,t_cityes.city_name,t_streets.street_name) = 2
order by sums desc
;

 --Task 3.2
set autotrace on;

select 
  decode(grouping(t_regions.region_name),1, 'all income region', t_regions.region_name) region_level
, decode(grouping(t_cityes.city_name   ),1, 'all income city'  , t_cityes.city_name   ) city_level
, decode(grouping(t_streets.street_name),1, 'all income street', t_streets.street_name) street_level
, sum(sum_issue) as sums
, grouping(t_regions.region_name)
, grouping(t_cityes.city_name)
, GROUPING_ID(t_regions.region_name,t_cityes.city_name,t_streets.street_name) grouping_level

from t_payments

inner join t_regions on t_payments.region_id=t_regions.region_id
inner join t_cityes on t_payments.city_id=t_cityes.city_id
inner join t_streets on t_payments.street_id=t_streets.street_id

group by grouping sets((t_regions.region_name, t_cityes.city_name),(t_cityes.city_name, t_streets.street_name))
order by sums desc
;

 --Task 3.3
with s1 as
(
select 
    EXTRACT (year from date_issue_dt) year_pay
,   case
     when EXTRACT (month from date_issue_dt) between 1 and 3 then 1
     when EXTRACT (month from date_issue_dt) between 4 and 6 then 2
     when EXTRACT (month from date_issue_dt) between 7 and 9 then 3
     else 4
    end quarter_pay
,   EXTRACT (month from date_issue_dt) month_pay
,   EXTRACT (day from date_issue_dt) day_pay
, t_services.service_name service_name
, sum_issue
    
from t_payments
inner join t_services on t_payments.service_id = t_services.service_id
)
select
  decode(GROUPING(service_name),1,'ALL servicess',service_name) service_decode
, decode(GROUPING(year_pay),1,'ALL years',year_pay) year_decode
, decode(GROUPING(quarter_pay),1,'ALL quarters',quarter_pay) year_quarter
, decode(GROUPING(month_pay),1,'ALL months',month_pay) month_decode
, decode(GROUPING(day_pay),1,'ALL days',day_pay) day_decode
, GROUPING_Id(service_name) gr_services_id
, GROUPING_Id(year_pay,quarter_pay,month_pay,day_pay) gr_date_id
, sum(sum_issue)
    
from s1
group by 
 ROLLUP(service_name)
,ROLLUP (year_pay,quarter_pay,month_pay,day_pay)
order by service_name, gr_services_id desc, gr_date_id desc
;