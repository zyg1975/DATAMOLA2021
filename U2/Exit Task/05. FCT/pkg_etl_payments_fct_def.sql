CREATE OR REPLACE PACKAGE pkg_etl_payments_fct
AS  
  PROCEDURE load_payments_fct;
  PROCEDURE load_t_rs_fct;
END pkg_etl_payments_fct;