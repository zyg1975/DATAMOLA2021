CREATE TABLESPACE tsa
DATAFILE '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/tsa_01.dat'
SIZE 10M
 AUTOEXTEND ON NEXT 2
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE tsb
DATAFILE '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/tsb_01.dat'
SIZE 10M
 AUTOEXTEND ON NEXT 2
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE tsc
DATAFILE '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/tsc_01.dat'
SIZE 10M
 AUTOEXTEND ON NEXT 2
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE tsd
DATAFILE '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/tsd_01.dat'
SIZE 10M
 AUTOEXTEND ON NEXT 2
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLE sales

  ( prod_id       NUMBER(6)
  , cust_id       NUMBER
  , time_id       DATE
  , channel_id    CHAR(1)
  , promo_id      NUMBER(6)
  , quantity_sold NUMBER(3)
  , amount_sold   NUMBER(10,2)
  )
 STORAGE (INITIAL 100K NEXT 50K) LOGGING
 PARTITION BY RANGE (time_id)
 ( PARTITION sales_q1_2006 VALUES LESS THAN (TO_DATE('01-04-2006','dd-mm-yyyy'))
    TABLESPACE tsa STORAGE (INITIAL 20K NEXT 10K)
 , PARTITION sales_q2_2006 VALUES LESS THAN (TO_DATE('01-07-2006','dd-mm-yyyy'))
    TABLESPACE tsb
 , PARTITION sales_q3_2006 VALUES LESS THAN (TO_DATE('01-10-2006','dd-mm-yyyy'))
    TABLESPACE tsc
 , PARTITION sales_q4_2006 VALUES LESS THAN (TO_DATE('01-01-2007','dd-mm-yyyy'))
    TABLESPACE tsd
 )
;

CREATE TABLESPACE tsx
DATAFILE '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/tsx_01.dat'
SIZE 10M
 AUTOEXTEND ON NEXT 2
 SEGMENT SPACE MANAGEMENT AUTO;
 
alter table sales 
  add partition jan99 values less than (TO_DATE('01-02-2007','dd-mm-yyyy'))
    TABLESPACE tsx;
    
ALTER TABLE sales DROP PARTITION jan99;

ALTER TABLE sales
  MERGE PARTITIONS sales_q1_2006, sales_q2_2006 INTO PARTITION sales_q2_2006;
  
CREATE TABLESPACE tsy
DATAFILE '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/tsy_01.dat'
SIZE 10M
 AUTOEXTEND ON NEXT 2
 SEGMENT SPACE MANAGEMENT AUTO;
 
ALTER TABLE sales move PARTITION sales_q2_2006 TABLESPACE tsy nologging;

ALTER TABLE sales split PARTITION
  sales_q3_2006 at (to_date('11-08-2006','dd-mm-yyyy'))
  into
  (PARTITION sales_q3_1_2006, PARTITION sales_q3_2_2006)
  ;
  
DELETE FROM sales PARTITION (sales_q3_2_2006);

drop table u_dw_zkh.fct_payments cascade constraints;

/*==============================================================*/
/* Table: fct_payments                                        */
/*==============================================================*/
create table u_dw_zkh.fct_payments 
(
   paysystem_id       INTEGER,
   provider_id        INTEGER,
   service_id         INTEGER,
   service_object_id  INTEGER,
   payer_id           INTEGER,
   paymant_date_issue DATE,
   paymant_date_pay   DATE,
   geo_id             INTEGER,
   sum_issue          NUMBER(10,2),
   sum_pay            NUMBER(10,2),
   day_pay            number,
   insert_dt          DATE,
   update_dt          DATE
)
partition by range (paymant_date_issue)
INTERVAL (NUMTOYMINTERVAL(1,'MONTH'))
subpartition by range (day_pay)
(PARTITION p2020 VALUES LESS THAN (TO_DATE('01.01.2021','dd.mm.yyyy')) 
 ( subpartition p2020_10 VALUES LESS THAN (11)
 , subpartition p2020_25 VALUES LESS THAN (26)
 , subpartition p2020_late VALUES LESS THAN (maxvalue)
 )
)
;
CREATE OR REPLACE TRIGGER trfct_payments
    before insert or update ON fct_payments
    FOR EACH ROW
    BEGIN
        :new.day_pay:=TO_NUMBER(TO_CHAR(:new.paymant_date_pay, 'd'));
    END;