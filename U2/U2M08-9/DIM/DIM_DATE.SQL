create table sa_calendar
    as
        ( select
            trunc(sd + rn)                                                                  time_id,
            to_char(sd + rn, 'fmday')                                                       day_name,
            to_char(sd + rn, 'd')                                                           day_number_in_week,
            to_char(sd + rn, 'dd')                                                          day_number_in_month,
            to_char(sd + rn, 'ddd')                                                         day_number_in_year,
            to_char(sd + rn, 'w')                                                           calendar_week_number,
            (
                case
                    when to_char(sd + rn, 'd') in ( 1, 2, 3, 4, 5, 6 ) then
                        next_day(sd + rn, 'воскресенье')
                    else
                        ( sd + rn )
                end
            )                                                                               week_ending_date,
            to_char(sd + rn, 'mm')                                                          calendar_month_number,
            to_char(last_day(sd + rn), 'dd')                                                days_in_cal_month,
            last_day(sd + rn)                                                               end_of_cal_month,
            to_char(sd + rn, 'fmmonth')                                                     calendar_month_name,
            ( (
                case
                    when to_char(sd + rn, 'q') = 1 then to_date('03/31/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                    when to_char(sd + rn, 'q') = 2 then to_date('06/30/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                    when to_char(sd + rn, 'q') = 3 then to_date('09/30/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                    when to_char(sd + rn, 'q') = 4 then to_date('12/31/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                end
            ) - trunc(sd + rn, 'q') + 1 )                                                   days_in_cal_quarter,
            trunc(sd + rn, 'q')                                                             beg_of_cal_quarter,
            (
                case
                    when to_char(sd + rn, 'q') = 1 then to_date('03/31/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                    when to_char(sd + rn, 'q') = 2 then to_date('06/30/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                    when to_char(sd + rn, 'q') = 3 then to_date('09/30/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                    when to_char(sd + rn, 'q') = 4 then to_date('12/31/' || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')
                end
            )                                                                               end_of_cal_quarter,
            to_char(sd + rn, 'q')                                                           calendar_quarter_number,
            to_char(sd + rn, 'yyyy')                                                        calendar_year,
            ( to_date('12/31/'
                      || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy') - trunc(sd + rn, 'year') ) days_in_cal_year,
            trunc(sd + rn, 'year')                                                          beg_of_cal_year,
            to_date('12/31/'
                    || to_char(sd + rn, 'yyyy'), 'mm/dd/yyyy')                              end_of_cal_year
        from
            (
                select
                    to_date('12/31/2020', 'mm/dd/yyyy')    sd,
                    rownum                                 rn
                from
                    dual
                connect by
                    level <= 365*5
              )
        );

create table t_days
    as
        ( select
            time_id,
            day_name,
            day_number_in_week,
            day_number_in_month,
            day_number_in_year
        from
            sa_calendar
        );

alter table t_days add constraint time_id_pk primary key ( time_id );


create table t_weeks
    as
        ( select distinct
            to_number(to_char(week_ending_date, 'yyyy') || to_char(week_ending_date, 'mm') || to_char(week_ending_date, 'dd')) as week_id,
            trunc(time_id, 'day') as week_beg_date,
            week_ending_date
        from
            sa_calendar
        );

alter table t_weeks add constraint week_id_pk primary key ( week_id );

create table t_years
    as
        ( select distinct
            to_number(calendar_year) as year_id,
            calendar_year,
            days_in_cal_year,
            beg_of_cal_year,
            end_of_cal_year
        from
            sa_calendar
        );

alter table t_years add constraint year_id_pk primary key ( year_id );

create table t_months
    as
        ( select distinct
            to_number(to_char(end_of_cal_month, 'yyyy') || to_char(end_of_cal_month, 'mm') || to_char(end_of_cal_month, 'dd')) as month_id,
            calendar_month_number,
            days_in_cal_month,
            trunc(time_id, 'mm')      as beg_of_cal_month,
            end_of_cal_month,
            calendar_month_name
        from
            sa_calendar
        );

alter table t_months add constraint month_id_pk primary key ( month_id );

create table t_quarters
    as
        ( select distinct
            to_number(to_char(end_of_cal_quarter, 'yyyy') || calendar_quarter_number) as quarter_id,
            days_in_cal_quarter,
            beg_of_cal_quarter,
            end_of_cal_quarter,
            calendar_quarter_number
        from
            sa_calendar
        );

alter table t_quarters add constraint quarter_id_pk primary key ( quarter_id );

create table dim_date as
(
  select
    t_days.time_id                        time_id,
    t_days.day_name                       day_name,
    t_days.day_number_in_week             day_number_in_week,
    t_days.day_number_in_month            day_number_in_month,
    t_days.day_number_in_year             day_number_in_year,
    t_weeks.week_id                       week_id,
    t_weeks.week_beg_date                 week_beg_date,
    t_weeks.week_ending_date              week_ending_date,
    t_months.month_id                     month_id,
    t_months.calendar_month_number        calendar_month_number,
    t_months.days_in_cal_month            days_in_cal_month,
    t_months.beg_of_cal_month             beg_of_cal_month,
    t_months.end_of_cal_month             end_of_cal_month,
    t_months.calendar_month_name          calendar_month_name,
    t_quarters.quarter_id                 quarter_id,
    t_quarters.days_in_cal_quarter        days_in_cal_quarter,
    t_quarters.beg_of_cal_quarter         beg_of_cal_quarter,
    t_quarters.end_of_cal_quarter         end_of_cal_quarter,
    t_quarters.calendar_quarter_number    calendar_quarter_number,
    t_years.year_id                       year_id,
    t_years.calendar_year                 calendar_year,
    t_years.days_in_cal_year              days_in_cal_year,
    t_years.beg_of_cal_year               beg_of_cal_year,
    t_years.end_of_cal_year               end_of_cal_year
from
    t_days
    inner join t_weeks    on t_days.time_id between week_beg_date                 and week_ending_date
    inner join t_months   on t_days.time_id between beg_of_cal_month              and end_of_cal_month
    inner join t_quarters on t_days.time_id between t_quarters.beg_of_cal_quarter and t_quarters.end_of_cal_quarter
    inner join t_years    on t_days.time_id between t_years.beg_of_cal_year       and t_years.end_of_cal_year
);

        
alter table dim_date add constraint dim_id_pk primary key (time_id);

drop table dim_date;

create table dim_date as
( 
  select
    t_days.time_id                     time_id,
    t_days.day_name                    day_name,
    t_days.day_number_in_week          day_number_in_week,
    t_days.day_number_in_month         day_number_in_month,
    t_days.day_number_in_year          day_number_in_year,
    t_weeks.week_id                    week_id,
    t_weeks.week_beg_date              week_beg_date,
    t_weeks.week_ending_date           week_ending_date,
    t_months.month_id                  month_id,
    t_months.calendar_month_number     calendar_month_number,
    t_months.days_in_cal_month         days_in_cal_month,
    t_months.beg_of_cal_month          beg_of_cal_month,
    t_months.end_of_cal_month          end_of_cal_month,
    t_months.calendar_month_name       calendar_month_name,
    t_quarters.quarter_id              quarter_id,
    t_quarters.days_in_cal_quarter     days_in_cal_quarter,
    t_quarters.beg_of_cal_quarter      beg_of_cal_quarter,
    t_quarters.end_of_cal_quarter      end_of_cal_quarter,
    t_quarters.calendar_quarter_number calendar_quarter_number,
    t_years.year_id                    year_id,
    t_years.calendar_year              calendar_year,
    t_years.days_in_cal_year           days_in_cal_year,
    t_years.beg_of_cal_year            beg_of_cal_year,
    t_years.end_of_cal_year            end_of_cal_year,
  from
    t_days
    inner join t_weeks    on t_days.time_id between week_beg_date      and week_ending_date
    inner join t_months   on t_days.time_id between beg_of_cal_month   and end_of_cal_month
    inner join t_quarters on t_days.time_id between beg_of_cal_quarter and end_of_cal_quarter
    inner join t_years    on t_days.time_id between beg_of_cal_year    and end_of_cal_year
);

        
alter table dim_date
 add constraint dim_id_pk
 primary key (time_id);
