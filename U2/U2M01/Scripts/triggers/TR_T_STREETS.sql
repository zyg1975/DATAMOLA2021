create or replace trigger TR_T_STREETS_1   
   before insert on "U_DW_ZKH"."T_STREETS" 
   for each row 
begin  
   if inserting then 
      if :NEW."STREET_ID" is null then 
         select SEQUENCE_ID.nextval into :NEW."STREET_ID" from dual; 
      end if; 
   end if; 
end;