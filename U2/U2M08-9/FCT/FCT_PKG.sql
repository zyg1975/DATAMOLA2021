BEGIN
  pkg_etl_payments_fct.load_payments_fct;
  pkg_etl_payments_fct.load_t_rs_fct;
END;