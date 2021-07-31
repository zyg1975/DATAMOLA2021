create or replace trigger tr_T_GEO_1  
   before insert on "U_DW_ZKH"."T_GEO" 
   for each row 
begin  
   if inserting then 
      if :NEW."GEO_ID" is null then 
         select SQ_GEO.nextval into :NEW."GEO_ID" from dual; 
      end if; 
   end if; 
end;