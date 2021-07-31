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
