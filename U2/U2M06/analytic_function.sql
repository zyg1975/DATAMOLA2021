select service_name, region_name
, to_char(sum(sum_issue),'999,999,999.99') as sm
, rank() over (partition by service_name order by sum(sum_issue) desc) as rnk_in_region
from dw_cl_payments
group by service_name, region_name
;

select * from
(select service_name, region_name
, to_char(sum(sum_issue),'999,999,999.99') as sm
, rank() over (partition by service_name order by sum(sum_issue) desc) as rnk_in_region
, row_number() over (order by sum(sum_issue) desc) as rn
from dw_cl_payments
group by service_name, region_name
)
where rnk_in_region = 1
;

select service_name, region_name
, to_char(sum(sum_issue),'999,999,999.99') as sm
, to_char(first_value(sum(sum_issue)) over (partition by service_name order by sum(sum_issue) desc),'999,999,999.99') fv
, to_char(last_value (sum(sum_issue)) over (partition by service_name order by sum(sum_issue) desc
                                    rows between current row and unbounded following),'999,999,999.99') lv
, rank() over (partition by service_name order by sum(sum_issue) desc) as rnk_in_region
from dw_cl_payments
group by service_name, region_name
;

select service_name, region_name
, to_char(sum(sum_issue),'999,999,999.99') as sm
, to_char(first_value(sum(sum_issue)) over (partition by service_name order by sum(sum_issue) desc),'999,999,999.99') fv
, to_char(last_value (sum(sum_issue)) over (partition by service_name order by sum(sum_issue) desc
                                    rows between current row and unbounded following),'999,999,999.99') lv
, to_char(avg (sum(sum_issue)) over (partition by service_name),'999,999,999.99') av
, rank() over (partition by service_name order by sum(sum_issue) desc) as rnk_in_region
from dw_cl_payments
group by service_name, region_name
;

