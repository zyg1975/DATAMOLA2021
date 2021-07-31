create or replace trigger tr_T_PAYERS_1  
   before insert on "U_DW_ZKH"."T_PAYERS" 
   for each row 
begin  
   if inserting then 
      if :NEW."PAYER_ID" is null then 
         select SEQUENCE_ID.nextval into :NEW."PAYER_ID" from dual; 
      end if; 
   end if; 
end;