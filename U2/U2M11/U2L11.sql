drop table temp_dates;
create global temporary table temp_dates
on commit delete rows
as
(select date_issue_dt as dt from dw_data_zkh.dw_payments_data
union 
select date_pay_dt as dt from dw_data_zkh.dw_payments_data
);

insert into temp_dates
(select date_issue_dt as dt from dw_data_zkh.dw_payments_data
union 
select date_pay_dt as dt from dw_data_zkh.dw_payments_data
);

merge into sa_calendar target
using (select * from temp_dates) source on (target.time_id = source.dt) when not matched then
insert
(
  time_id,             
  day_name,            
  day_number_in_week,  
  day_number_in_month, 
  day_number_in_year,  
  calendar_week_number,
  week_ending_date,     
  calendar_month_number,
  days_in_cal_month,    
  end_of_cal_month,     
  calendar_month_name,  
  days_in_cal_quarter,
  beg_of_cal_quarter, 
  end_of_cal_quarter,     
  calendar_quarter_number,
  calendar_year,          
  days_in_cal_year,
  beg_of_cal_year, 
  end_of_cal_year  
)
values 
(
  source.dt,
  to_char(source.dt, 'fmday')                                                       ,
  to_char(source.dt, 'd')                                                           ,
  to_char(source.dt, 'dd')                                                          ,
  to_char(source.dt, 'ddd')                                                         ,
  to_char(source.dt, 'w')                                                           ,
  (
      case
          when to_char(source.dt, 'd') in ( 1, 2, 3, 4, 5, 6 ) then
              next_day(source.dt, 'воскресенье')
          else
              ( source.dt )
      end
  )                                                                                 ,
  to_char(source.dt, 'mm')                                                          ,
  to_char(last_day(source.dt), 'dd')                                                ,
  last_day(source.dt)                                                               ,
  to_char(source.dt, 'fmmonth')                                                     ,
  ( (
      case
          when to_char(source.dt, 'q') = 1 then to_date('03/31/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
          when to_char(source.dt, 'q') = 2 then to_date('06/30/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
          when to_char(source.dt, 'q') = 3 then to_date('09/30/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
          when to_char(source.dt, 'q') = 4 then to_date('12/31/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
      end
  ) - trunc(source.dt, 'q') + 1 )                                                   ,
  trunc(source.dt, 'q')                                                             ,
  (
      case
          when to_char(source.dt, 'q') = 1 then to_date('03/31/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
          when to_char(source.dt, 'q') = 2 then to_date('06/30/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
          when to_char(source.dt, 'q') = 3 then to_date('09/30/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
          when to_char(source.dt, 'q') = 4 then to_date('12/31/' || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')
      end
  )                                                                                 ,
  to_char(source.dt, 'q')                                                           ,
  to_char(source.dt, 'yyyy')                                                        ,
  ( to_date('12/31/'
          || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy') - trunc(source.dt, 'year') ) ,
  trunc(source.dt, 'year')                                                          ,
  to_date('12/31/'
          || to_char(source.dt, 'yyyy'), 'mm/dd/yyyy')                              
)
;
commit;


--exchange partition

create tablespace archive_2020
  datafile '/oracle/u02/oradata/dmorcl19db/yzhdanoich_db/archive_2020_data_01.dat'
  size 100m autoextend on next 20m segment space management auto;

create table payments_2020 tablespace archive_2020
  nologging compress parallel 4 as select * from dw_data_zkh.dw_payments_data
  where date_issue_dt < '01.01.2021';

alter table fct_payments modify constraint payment_id_pk disable;

select count(*) from fct_payments partition (pays_2020);

select count(*) from payments_2020;

alter table fct_payments exchange partition payments_2020
 with table payments_2020 including indexes;

alter table fct_payments modify constraint payment_id_pk enable novalidate;
alter table fct_payments modify constraint payment_id_pk rely;

--merge partitions

create tablespace before_2022
  datafile '/oracle/u02/oradata/dmorcl19db/yzhdanoich_db/before_2022_data_01.dat'
  size 100m autoextend on next 20m segment space management auto;

alter table fct_payments merge partitions pays_2020, pays_2020
  into partition pays_before_2022 tablespace before_2022 
  compress update global indexes parallel 4;

create table pays_before_2022 tablespace before_2022
  nologging compress parallel 4 as select * from dw_data_zkh.dw_payments_data
  where date_issue_dt < '01.01.2022';

select count(*) from fct_payments partition (before_2022);
select count(*) from pays_before_2022;

alter table fct_payments modify constraint payment_id_pk disable;

alter table fct_payments     exchange partition pays_before_2022
 with table pays_before_2022 including indexes;

alter table fct_payments modify constraint payment_id_pk enable novalidate;
alter table fct_payments modify constraint payment_id_pk rely;
