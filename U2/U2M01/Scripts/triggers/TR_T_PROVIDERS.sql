create or replace trigger TR_T_PROVIDERS
   before insert on "U_DW_ZKH"."T_PROVIDERS" 
   for each row 
begin  
   if inserting then 
      if :NEW."PROVIDER_ID" is null then 
         select SQ_PROVIDERS.nextval into :NEW."PROVIDER_ID" from dual; 
      end if; 
   end if; 
end;