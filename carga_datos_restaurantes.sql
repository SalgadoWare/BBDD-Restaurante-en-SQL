SET AUTOCOMMIT ON;


DROP SEQUENCE Seq_CodPedidos;
CREATE SEQUENCE Seq_CodPedidos INCREMENT BY 1 START WITH 1 NOMAXVALUE;

delete from Horarios;

delete from AreasCobertura;

delete from Contiene;

delete from Pedidos;

delete from platos;

delete from Restaurantes;

delete from clientes;

delete from Descuentos;




/*****************************************************************************************************/

--1234; pizzahud; abascal 45; 12345; 2,0;
INSERT INTO Restaurantes VALUES (1234, 'pizzahud', 'abascal 45', '12345', 2.0);

--2345; Templo hindú; carbón 22; 12567; 5,0;
INSERT INTO Restaurantes VALUES (2345, 'Templo hindú', 'carbón 22', '12567', 5.0);

--3456; burguer-burguer; diamante 12; 28224; 10,0;
INSERT INTO Restaurantes VALUES (3456, 'burguer-burguer', 'diamante 12', '28224', 10.0);

--5678; telericatorta; cántaro 17; 28225; 7,5;
INSERT INTO Restaurantes VALUES (5678, 'telericatorta', 'cántaro 17', '28225', 7.5);

-- 5677 rissoto - nuevo retsaurante 
INSERT INTO Restaurantes VALUES (5677, 'rissoto', 'viñagrande 29', '28925', 5.5);

/*****************************************************************************************************/


INSERT INTO PLATOS VALUES (1234, 'pizza arrabiata', 17.50, 'pizza de carne y guindilla', 'picante');
INSERT INTO PLATOS VALUES (1234, 'pizza margarita', 8.50, 'tomate y queso', 'pizza');
INSERT INTO PLATOS VALUES (1234, 'pizza vegetal', 10.50, 'queso y verduras', 'pizza');
INSERT INTO PLATOS VALUES (2345, 'pollo tikka', 16.50, 'pollo con especias', 'picante');
INSERT INTO PLATOS VALUES (2345, 'chana masala', 12.00, 'garbanzos y arroz', 'vegetariano');
INSERT INTO PLATOS VALUES (3456, 'hot-burguer', 6.00, 'hamburguesa con salsa picante', 'picante');
INSERT INTO PLATOS VALUES (3456, 'vege-burguer', 7.20, 'hamburguesa vegetal', 'vegetariano');
INSERT INTO PLATOS VALUES (3456, 'crunch-burguer', 15.50, 'hamburguesa con pan crujiente', 'carne');
INSERT INTO PLATOS VALUES (5678, 'tortaDeCarneEspecial', 12.10, 'torta de carne y queso brie', 'carne');
INSERT INTO PLATOS VALUES (5678, 'torta gallega', 21.00, 'torta de pulpo', 'pescado');

/********************************************************************************************************/

--1234;12345;
INSERT INTO AreasCobertura VALUES (1234, '12345');

--1234;12346;
INSERT INTO AreasCobertura VALUES (1234, '12346');

--2345;12345;
INSERT INTO AreasCobertura VALUES (2345, '12345');

--2345;12568;
INSERT INTO AreasCobertura VALUES (2345, '12568');

--3456;28224;
INSERT INTO AreasCobertura VALUES (3456, '28224');

--5677;28224;
INSERT INTO AreasCobertura VALUES (5677, '28224');


/********************************************************************************************************/


--para visualizar la hora de apertura
--     select to_char(hora_apertura, 'HH24:MI') from Horarios;


--para visualizar la hora de apertura
--     select to_char(hora_cierre, 'HH24:MI') from Horarios;

--1234; X; 12:00; 23:00;
INSERT INTO Horarios VALUES(1234, 'X', to_date('12:00', 'HH24:MI'), to_date('23:00', 'HH24:MI'));

--1234; J; 12:00; 23:00;
INSERT INTO Horarios VALUES(1234, 'J', to_date('12:00', 'HH24:MI'), to_date('23:00', 'HH24:MI'));

--1234; V; 20:00; 03:00;
INSERT INTO Horarios VALUES(1234, 'V', to_date('20:00', 'HH24:MI'), to_date('03:00', 'HH24:MI'));

--1234; V; 12:00; 17:00;
INSERT INTO Horarios VALUES(1234, 'S', to_date('12:00', 'HH24:MI'), to_date('17:00', 'HH24:MI'));

--2345; J; 12:00; 23:00;
INSERT INTO Horarios VALUES(2345, 'J', to_date('12:00', 'HH24:MI'), to_date('23:00', 'HH24:MI'));

--2345; V; 12:00; 03:00;
INSERT INTO Horarios VALUES(2345, 'V', to_date('12:00', 'HH24:MI'), to_date('03:00', 'HH24:MI'));

--2345; S; 20:00; 03:00;
INSERT INTO Horarios VALUES(2345, 'S', to_date('20:00', 'HH24:MI'), to_date('03:00', 'HH24:MI'));

--2345; D; 12:00; 23:00;
INSERT INTO Horarios VALUES(2345, 'D', to_date('12:00', 'HH24:MI'), to_date('23:00', 'HH24:MI'));

--3456; J; 12:00; 23:00;
INSERT INTO Horarios VALUES(3456, 'J', to_date('12:00', 'HH24:MI'), to_date('23:00', 'HH24:MI'));

--3456; V; 20:00; 03:00;
INSERT INTO Horarios VALUES(3456, 'V', to_date('20:00', 'HH24:MI'), to_date('03:00', 'HH24:MI'));

--3456; S; 20:00; 03:00;
INSERT INTO Horarios VALUES(3456, 'S', to_date('20:00', 'HH24:MI'), to_date('03:00', 'HH24:MI'));

--3456; D; 12:00; 18:00;
INSERT INTO Horarios VALUES(3456, 'D', to_date('12:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));

--5678; L; 12:00; 18:00;
INSERT INTO Horarios VALUES(5678, 'L', to_date('12:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));

--5678; M; 12:00; 18:00;
INSERT INTO Horarios VALUES(5678, 'M', to_date('12:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));

--5678; X; 12:00; 18:00;
INSERT INTO Horarios VALUES(5678, 'X', to_date('12:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));

--5678; J; 12:00; 23:00;
INSERT INTO Horarios VALUES(5678, 'J', to_date('12:00', 'HH24:MI'), to_date('23:00', 'HH24:MI'));

--5677; V; 20:00; 01:00;
INSERT INTO Horarios VALUES(5677, 'V', to_date('20:00', 'HH24:MI'), to_date('01:00', 'HH24:MI'));

/* CONSULTA LOS HORARIOS EN SU FORMATO CORRESPONDIENTE 
   SELECT restaurante "RESTAURANTE", dia_semana "DIA", 
           TO_CHAR(hora_apertura, 'HH24:MI') HORA_APERTURA,
           TO_CHAR(hora_cierre, 'HH24:MI') HORA_CIERRE 
    FROM Horarios;
   */ 

/*******************************************************************************************************/


INSERT INTO CLIENTES VALUES ('12345678N', 'Pedro', 'Pérez', 'Torralba', 29, '4-B', 'Madrid', '12345', '676856753', '12345612', 'pedro');

INSERT INTO CLIENTES VALUES ('12345678M', 'Francisco', 'García Siñeriz', 'Tembleque', 78, 'BJ-A', 'Madrid', '12346', '789345312', 'Nopass', 'Nopass');
INSERT INTO CLIENTES VALUES ('12345679M', '�?gata', 'Valle Dorado', 'Gallur', 78, '3-A', 'Leganés', '28224', '676856743', 'agata', 'agata');
INSERT INTO CLIENTES VALUES ('45678901Y', 'María', 'Jorda Lorente', 'Leiva', 1, '4-I', 'Móstoles', '78945', '666123456', 'mari', 'passwd');
/***********************************************************************************************************/


INSERT INTO Descuentos VALUES (1100, to_date('2009-04-20', 'YYYY:MM:DD'), 50);
INSERT INTO Descuentos VALUES (1200, to_date('2009-03-30', 'YYYY:MM:DD'), 25);
INSERT INTO Descuentos VALUES (1300, to_date('2009-06-30', 'YYYY:MM:DD'), 5);
INSERT INTO Descuentos VALUES (1400, to_date('2009-06-30', 'YYYY:MM:DD'), 10);
INSERT INTO Descuentos VALUES (1500, to_date('2009-06-30', 'YYYY:MM:DD'), 100);
/***********************************************************************************************************/


INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'REST', to_date('09-02-17:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI'), 34.25, '12345678N', 1100);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-16:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-16:20:50', 'YY:MM:DD HH24:MI'), 14.25, '12345678N', 1100);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-15:22:50', 'YY:MM:DD HH24:MI'), to_date('09-02-15:23:10', 'YY:MM:DD HH24:MI'), 16.50, '12345678N', 1400);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'REST', to_date('09-02-17:20:10', 'YY:MM:DD HH24:MI'), to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI'), 34.25, '12345678M', null);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'RECHAZADO', to_date('09-02-16:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-16:20:50', 'YY:MM:DD HH24:MI'), 25.00, '12345678M', null);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'CANCEL', to_date('09-02-15:22:50', 'YY:MM:DD HH24:MI'), to_date('09-02-15:23:10', 'YY:MM:DD HH24:MI'), 10.00, '12345678M', 1400);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'CANCEL', to_date('09-02-15:15:10', 'YY:MM:DD HH24:MI'), to_date('09-02-15:15:20', 'YY:MM:DD HH24:MI'), 30.00, '12345679M', null);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'RUTA', to_date('09-02-16:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-16:20:50', 'YY:MM:DD HH24:MI'), 15.00, '45678901Y', 1200);
INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-15:22:50', 'YY:MM:DD HH24:MI'), to_date('09-02-15:23:10', 'YY:MM:DD HH24:MI'), 25.00, '45678901Y', 1100);


/* --Consultas
describe Pedidos;
select * from Pedidos;
SELECT codigo, estado, TO_CHAR(fecha_hora_pedido, 'YY:MM:DD HH24:MI'), 
                       TO_CHAR(fecha_hora_entrega, 'YY:MM:DD HH24:MI'),
         importe_total, codigoDescuento   
FROM Pedidos;

*/

/**************************************************************************************************/


INSERT INTO Contiene VALUES (1234, 'pizza arrabiata', 2, NULL, 2);
INSERT INTO Contiene VALUES (2345, 'chana masala', 2, NULL, 1);
INSERT INTO Contiene VALUES (3456, 'vege-burguer', 3, NULL, 4);
INSERT INTO Contiene VALUES (5678, 'torta gallega', 4, NULL, 1);
INSERT INTO Contiene VALUES (2345, 'pollo tikka', 7, NULL, 3);
INSERT INTO Contiene VALUES (5678, 'tortaDeCarneEspecial', 8, NULL, 1);
INSERT INTO Contiene VALUES (3456, 'crunch-burguer', 7, NULL, 1);
INSERT INTO Contiene VALUES (3456, 'vege-burguer', 7, NULL, 1);
INSERT INTO Contiene VALUES (1234, 'pizza margarita', 10, NULL, 2);

INSERT INTO Contiene VALUES (1234, 'pizza vegetal', 10, NULL, 2);
INSERT INTO Contiene VALUES (3456, 'hot-burguer', 10, NULL, 1);
/********************************************************************************************/
