
--Initial rows
INSERT INTO u_dw_zkh.t_services( service_id, service_name ) VALUES ( 1, 'Жилищные услуги' );
INSERT INTO u_dw_zkh.t_services( service_id, service_name ) VALUES ( 2, 'Коммунальные услуги' );

INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 1, 3, 'Содержание жилья' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 1, 4, 'Вывоз ТБО' );

INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 5, 'Горячее водоснабжение' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 6, 'Водоснабжение и водоотведение' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 7, 'Энергоснабжение' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 8, 'Теплоснабжение' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 9, 'Газооснабжение' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 10, 'Утилизация ТБО' );

