drop tablespace ts_dw_zkh_data_01 including contents cascade constraints;

create tablespace ts_wd_zkh_data_01
datafile '/oracle/u02/oradata/DMORCL19DB/yzhdanovich_db/db_wd_zkh_data_01.dat'
size 150M
 autoextend on next 50M
 segment space management auto;
