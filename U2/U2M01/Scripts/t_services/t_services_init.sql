
--Initial rows
INSERT INTO u_dw_zkh.t_services( service_id, service_name ) VALUES ( 1, '�������� ������' );
INSERT INTO u_dw_zkh.t_services( service_id, service_name ) VALUES ( 2, '������������ ������' );

INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 1, 3, '���������� �����' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 1, 4, '����� ���' );

INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 5, '������� �������������' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 6, '������������� � �������������' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 7, '���������������' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 8, '��������������' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 9, '��������������' );
INSERT INTO u_dw_zkh.t_services( service_hier_id, service_id, service_name ) VALUES ( 2, 10, '���������� ���' );

