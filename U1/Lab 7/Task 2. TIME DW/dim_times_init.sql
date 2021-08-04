select * from dw.dim_times;

insert into dw.dim_times
(
   time_id            ,
   year_calendar      ,
   year_days_cnt      ,
   quarter_number     ,
   quarter_days_cnt   ,
   quarter_begin_dt   ,
   quarter_end_dt     ,
   month_number       ,
   month_name         ,
   month_days_cnt     ,
   week_number        ,
   week_begin_dt      ,
   week_end_dt        ,
   day_name_week      ,
   day_number_week    ,
   day_number_year
   )

SELECT 
    time_id,
    TO_CHAR(time_id, 'YYYY') as year_calendar,
    (TO_DATE('12/31/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
    - TRUNC(time_id, 'YEAR')) + 1 as year_days_cnt, 
    
    TO_CHAR(time_id, 'Q') as quarter_number,
        ((CASE
          WHEN TO_CHAR(time_id, 'Q') = 1 THEN
            TO_DATE('03/31/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
          WHEN TO_CHAR(time_id, 'Q') = 2 THEN
            TO_DATE('06/30/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
          WHEN TO_CHAR(time_id, 'Q') = 3 THEN
            TO_DATE('09/30/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
          WHEN TO_CHAR(time_id, 'Q') = 4 THEN
            TO_DATE('12/31/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
        END) - TRUNC(time_id, 'Q') + 1) as  quarter_days_cnt,
        
    TRUNC(time_id, 'Q') as quarter_begin_dt,
        (CASE
          WHEN TO_CHAR(time_id, 'Q') = 1 THEN
            TO_DATE('03/31/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
          WHEN TO_CHAR(time_id, 'Q') = 2 THEN
            TO_DATE('06/30/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
          WHEN TO_CHAR(time_id, 'Q') = 3 THEN
            TO_DATE('09/30/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
          WHEN TO_CHAR(time_id, 'Q') = 4 THEN
            TO_DATE('12/31/' || TO_CHAR(time_id, 'YYYY'), 'MM/DD/YYYY')
        END) as quarter_end_dt,
    
        TO_CHAR(time_id          , 'MM'     ) as month_number,
        TO_CHAR(time_id          , 'FMMonth') as month_name,
        TO_CHAR(LAST_DAY(time_id), 'DD'     ) as month_days_cnt,
        
        TO_CHAR(time_id, 'W') as week_number,

        (CASE
          WHEN TO_CHAR(time_id, 'D') IN (1, 2, 3, 4, 5, 6) THEN
            NEXT_DAY(time_id, '¬Œ— –≈—≈Õ‹≈')
          ELSE
            time_id
          END) - 7 as week_begin_dt,

        (CASE
          WHEN TO_CHAR(time_id, 'D') IN (1, 2, 3, 4, 5, 6) THEN
            NEXT_DAY(time_id, '¬Œ— –≈—≈Õ‹≈')
          ELSE
            time_id
          END) as week_end_dt,
       
        TO_CHAR(time_id, 'fmDay') as day_name_week,
        TO_CHAR(time_id, 'D'    ) as day_number_week,
        TO_CHAR(time_id, 'DDD'  ) as day_number_year
    
    FROM
  (
    SELECT 
      TRUNC(mydate + rn - 1) as time_id
    FROM
    (
      SELECT 
        sysdate mydate,
        rownum rn
      FROM dual
        CONNECT BY level <= 700
   )
 )
;
  
  