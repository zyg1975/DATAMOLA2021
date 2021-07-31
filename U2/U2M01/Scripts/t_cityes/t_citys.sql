alter table u_dw_zkh.t_cityes
   drop constraint FK_T_CITY_REFERENCE_T_REGION;

drop table u_dw_zkh.t_cityes cascade constraints;

/*==============================================================*/
/* Table: t_cityes                                          */
/*==============================================================*/
create table u_dw_zkh.t_cityes 
(
   city_id            NUMBER(22)           not null,
   city_name          VARCHAR2(100)        not null,
   region_id          NUMBER(22)           not null,
   constraint PK_T_CITYES primary key (city_id)
)
tablespace ts_sa_zkh_data_01;

alter table u_dw_zkh.t_cityes
   add constraint FK_T_CITY_REFERENCE_T_REGION foreign key (region_id)
      references u_dw_zkh.t_regions (region_id);


CREATE SEQUENCE SEQUENCE_ID INCREMENT BY 1 START WITH 1;

create or replace trigger tr_T_CITYES_1  
   before insert on "U_DW_ZKH"."T_CITYES" 
   for each row 
begin  
   if inserting then 
      if :NEW."CITY_ID" is null then 
         select SEQUENCE_ID.nextval into :NEW."CITY_ID" from dual; 
      end if; 
   end if; 
end;
