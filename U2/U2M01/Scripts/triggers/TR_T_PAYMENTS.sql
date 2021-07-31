create or replace trigger TR_T_PAYMENTS
   before insert on "U_DW_ZKH"."T_PAYMENTS" 
   for each row 
begin  
   if inserting then 
      if :NEW."PAYMENT_ID" is null then 
         select SQ_PAYMENTS.nextval into :NEW."PAYMENT_ID" from dual; 
      end if; 
   end if; 
end;