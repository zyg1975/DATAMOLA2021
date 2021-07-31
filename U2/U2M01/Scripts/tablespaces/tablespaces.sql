drop tablespace ts_sa_zkh_data_01 including contents cascade constraints;

create tablespace ts_sa_zkh_data_01
datafile '/oracle/u02/oradata/DMORCL21DB/yzhdanovich_db/db_sa_zkh_data_01.dat'
size 150M
 autoextend on next 50M
 segment space management auto;
