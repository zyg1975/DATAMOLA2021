BEGIN
  pkg_etl_paysystems_dim.load_paysystems_dim;
  pkg_etl_providers_dim.load_providers_dim;
END;