declare 
   cursor cPayment is SELECT * from t_payments;
   cursor cPayer is SELECT * from t_payers;
   tPayer t_payers%ROWTYPE;
begin
  EXECUTE IMMEDIATE 'TRUNCATE TABLE t_geo';
  
  open cPayer;
  
  FOR tP in cPayment
  LOOP
    fetch cPayer into tPayer;
    
    insert into t_geo (house_id, street_id, city_id, region_id, payer_id)
    values(tP.house_id, tP.street_id, tP.city_id, tP.region_id, tPayer.payer_id);
    
--        DBMS_OUTPUT.PUT_LINE (tp.Payment_id||' '||tPayer.payer_id);
    
    if cPayer%notfound then
      exit;
    end if;
  END LOOP;
  
  CLOSE cPayer;
end;
