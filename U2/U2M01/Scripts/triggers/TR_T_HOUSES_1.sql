create or replace trigger tr_T_HOUSES_1  
   before insert on "U_DW_ZKH"."T_HOUSES" 
   for each row 
begin  
   if inserting then 
      if :NEW."HOUSE_ID" is null then 
         select SEQUENCE_ID.nextval into :NEW."HOUSE_ID" from dual; 
      end if; 
   end if; 
end;