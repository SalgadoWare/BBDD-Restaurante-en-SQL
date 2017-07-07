
-- ====================================================================== 
--   EJEMPLOS PARA ILUSTRAR apuntes SQL-2.pdf para hacer en ORACLE
-- ======================================================================

-- Queremos el DNI y el Nombre de los clientes que invierten el bono1

select Cliente.DNI , Cliente.NombreC  --Proyección de Atributos o columnas
from Cliente, Invierte -- Prod cartesiano (se optimiza internamente)
where Cliente.DNI = Invierte.DNI -- Selección filas 
      and Invierte.TIPO = 'bono1';

-- queremos las tiendas donde se han hecho compras, quitando filas duplicadas
 select distinct tienda  
 from compras;
 
-- Queremos las tiendas donde se hayan hecho compras y  cuántas compras de cada tienda.
--  Como repite filas iguales del resultado, podemos contarlas 
 select tienda, count(*)    
 from compras
 group by tienda;
 
tienda1             	3
tienda7             	5
tienda2             	1
tienda8             	2

-- Escribe operaciones división y raíz cuadrada de 100 en los atributos
-- en una consulta a la tabla DUAL, y renombra las cabeceras
--  

 select 20/5 "Horas", SQRT(100) "raiz C." , 'buen ' || 'Turrón' "Me Gusta"
 from dual;
 

-- Queremos el DNI, nombre, y el valor de cada inversión multiplicado por 10
-- de los clientes que invierten en el bono2 
-- Cambia las cabeceras para indicar el resultado

select Cliente.DNI "clientillo", Cliente.NombreC "nombrecillo", 
         Invierte.CANTIDAD * 10 "multiplico X10"
from Cliente, Invierte 
where Cliente.DNI = Invierte.DNI 
      and Invierte.TIPO = 'bono2';
      
-- Cláusula WHERE : AND, OR,NOT , < ,> , =, =!, IS , NULL
-- Selecciona num de tarjeta,importe y tienda de compras de importe entre 50 y 5000
-- sin incluir ambos extremos

select numt, importe, tienda
 from compras
 where importe < 50 OR importe > 5000;
   
-- En la consulta anterior excluye las compras sin tarjeta

select numt, importe, tienda
 from compras
 where (importe < 50 OR importe > 5000) AND
 NOT (tienda = 'tienda7')
 AND (numt is not NULL); -- que tienen tarjeta

-- Queremos DNI y nombre de clientes cuyo nombre tiene 
-- en la 7ª posición la letra A
      
select DNI, NombreC
from CLiente 
where NombreC LIKE '_______A%';  -- en la 7ª posición tiene la letra A 


-- Queremos el  num de tarjeta,importe de las compras 
-- ordenados de forma descendente del importe

select numt, importe
 from compras
order by importe desc;

-----  ==  Funciones == ----

-- Queremos Num tarjeta, la tercera parte del importe redondeado a dos decimales
-- de las compras, ordenadas de modo descendente por el importe.


select numt, (ROUND(importe/3,2)), UPPER(tienda)
 from compras
order by importe desc;

-- Queremos el dni, y la letra mayúscula que tiene el nombre del cliente
-- que se puede obtener con SUBSTR

select DNI, SUBSTR(NombreC,8,1) "Letra del Nombre"
from CLiente;


select DNI, NombreC from CLiente;

-- Queremos DNI, el nombre (sin lo blancos que tiene la derecha)
-- y la longitud del nombre de los clientes 

select DNI, RTRIM(NombreC) "blancDcha", LENGTH(NOmbreC) -- long. original, sin recortar
from CLiente;



----- ===  Aritmética de Fechas  === ----

-- queremos la fecha actual del sistema 
select sysdate from dual; 

-- queremos sumarle 12 días a la fecha actual del sistema 

select sysdate + 12 from dual;

-- queremos sumarle 6 meses a la fecha actual del sistema 

select ADD_MONTHS(sysdate,6) from dual;

-- Queremos probar la función de cálculo de meses entre dos fechas
-- para ello usa la fecha actual del sistema y la fecha de seis meses más
-- tarde obtenida por el método de la consulta anterior

select MONTHS_BETWEEN (ADD_MONTHS(sysdate,6),    sysdate) "da seis" from dual;


--- == Conversión de datos : TEXTO a FECHA y viceversa  ==---

---   TEXTO a FECHA y viceversa ---

-- Insertar una fila en tabla Horarios a partir de datos en formato de texto
INSERT INTO Horarios
   VALUES (1234,'X',to_date('12:00', 'HH24:MI'), to_date('23:00', 'HH24:MI'));

-- Consultar todas las fechas de apertura en tabla Horarios
select to_char(hora_apertura, 'HH24:MI') from Horarios;

-- Consultar la fecha actual del sistema para que la muestre en forma de texto
-- con este formato concreto  DD/MONTH/YYYY, DAY HH:MI:SS

select TO_CHAR(sysdate, 'DD/MONTH/YYYY, DAY HH:MI:SS') from dual;

-- -- === Sobre la BD Restaurantes del enunciado PRAC1 == --

-- Insertar un pedido de esta forma usando valores de texto y aplicando to_date
--  usando este formato: to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI')
--  y para el número de pedido la secuencia Seq_CodPedidos

INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'REST', to_date('09-02-17:19:50', 'YY:MM:DD HH24:MI'),
                 to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI'), 34.25, '12345678N', 1100);


-- consulta todos los  pedidos con todos los atributos para que las fechas tengan el 
-- formato descrito en la consulta anterior

SELECT codigo, estado, TO_CHAR(fecha_hora_pedido, 'YY:MM:DD HH24:MI') "Fecha-Hora Pedido", 
                       TO_CHAR(fecha_hora_entrega, 'YY:MM:DD HH24:MI') "Fecha-Hora Entrega",
         importe_total, codigoDescuento   
FROM Pedidos;

-- ===  DECODIFICAR VALORES  === --
--      Cambia el valor del un atributo según su valor siguiendo una equivalencia


-- Queremos saber los bonos en los que se invierte, pero con estos nombres largos según Tipo:
--   si es bono1   poner  'bono super super',
--   si es bono2   poner  'bono menos super',
--   si es bono3   poner  'bono solo super',
--   si es cualquier otro tipo poner   'bono normal')


select DECODE(Tipo, 'bono1', 'bono super super', -- so tenía 'bono1' le asigna 'bono super super'
                                                 -- pero NO lo reconoce porque hay que poner blancos
              'bono normal') -- por defecto
from invierte;
                                               -- Ahora sí lo reconoce
select DNI, DECODE(Tipo, 'bono1     ', 'bono super super',
                    'bono2     ', 'bono menos super',
                    'bono3     ', 'bono solo super',
              'bono normal')
from invierte;

------------------------------------------------------------------


-- ==     OPERACIONES SOBRE CONJUNTOS    ====

-- Ver qué filas tenemos en cliente y moroso antes de operar
select * from cliente;
select * from moroso;

-- Queremos todas las filas de cliente y moroso

(select * from cliente) union (select * from moroso); -- igual columnas ambos resultados
                                                      -- quita filas duplicadas (no si usas UNION ALL)
                                                      -- el DNI 3 y 5
 
-- ¿Qué pasa si ejecutamos esta operación? ¿y Pr qué?
--       (select * from cliente) union (select * from cliente_I);


-- Queremos los clientes que son clientes y tembién morosos
(select * from cliente) intersect (select * from moroso);

-- ¿Porqué no sale en la consulta anterior el cliente 0000006?


-- ==  OPERACIONES de AGREGACION == 


-- Queremos el dNI y la suma de los importe de Compras hechas por cada cliente

select dni, sum(importe) "Total Compras"
from compras 
group by dni; 


-- La misma consulta anterior pero multiplicando el importe por 10 y cambiando las cabeceras
-- para distinguir las salidas. Debe dar estas filas y valores

select dni, sum(importe* 10) "Total Compras"
from compras 
group by dni; 

00000003	333330
00000004	40
00000005	555550

-- Queremos para cada dni: la compra con máximo importe, el mínimo, cuantas compras
-- hay que tengan el importe distinto de nulo
 (otras funciones AVG,MIN,COUNT)
select dni, MAX(importe) "MAX Compras", MIN(importe), count(importe) "Todas las filas no nulas"
from compras 
group by dni; 

00000003	30000	3	5
00000004	4	4	1
00000005	50000	5	5


-- == select Extendida: Combinando funciones de grupos y funciones de filas  ==

-- Queremos lo mismo que la consulta anterior, pero solo los DNI que tengan 
--    el importe con valor máximo mayor de 4 
--    y el importe individual de cada compra menor de 5000
 
select dni, MAX(importe) "MAX Compras", MIN(importe), count(*) "Todas las filas, incluye nulas y dupl"
from compras 
where importe < 5000       --  1º solo filas que cumplan esa condición
group by dni               --  2º agrupa por ese atributo
having max(importe) > 4;   --  3º calcula las funciones de grupo y 4º Filtra con having

00000003	3000	3	4
00000005	500	5	3


-- Queremos la misma consulta con orden descendente  del importe máximo
-- 
select dni, MAX(importe) "MAX Compras", MIN(importe), count(*) "Todas las filas no nulas"
from compras 
where importe < 5000       --  1º
group by dni               --  2º
having max(importe) > 4   --  3º calcula las funciones de grupo y 4º Filtra con having
order by min(importe) DESC; -- 5º orden descendente del min.imp. para cada grupo dni

00000005	500	5	3
00000003	3000	3	4


-- Queremos poner un filtro al resultado anterior para que solo se tenga en cuenta las
-- compras que tengan como número de factura un 1.
-- Además solo nos interesan los DNI que tienen más de una compra

select dni, MAX(importe) "MAX Compras", MIN(importe), count(*) "Todas las filas no nulas"
from compras 
where NUMF = 1       --  1º
group by dni               --  2º
having count(*) > 1   --  3º calcula las funciones de grupo y 4º Filtra con having
order by min(importe) DESC;

00000005	50000	5	3
00000003	300	3	3


--- == re-uniones JOIN == --- (sintáxis con comas )

-- Queremos nombre de cliente, tarjetas con las que compras, importe de cada compra
-- pero solo clientes de Madrid (aquellos cuyo teléfono empiece por 91


select nombreC, numt, importe
from compras, cliente,tienetel
where compras.DNI = cliente.DNI
and cliente.dni = tienetel.DNI
and tienetel.TELEFONO Like '91%';

Client A                      	50000400	50
Client A                      	50000030	5
Client A                      	50000400	500
Client A                      	50000400	5000
Client A                      	50000003	50000
Client B                      	30000002	3
Client B                      	30000300	30
Client B                      	30000020	300
Client B                      	30000020	3000
Client B                      	30000020	30000
Client A                      	40000200	4


-- Queremos lo mismo que en la consulta anterior pero que NO sean de Madrid

select nombreC, numt, importe
from compras, cliente,tienetel
where compras.DNI = cliente.DNI
and cliente.dni = tienetel.DNI
and tienetel.TELEFONO  not Like '91%';

devuelve 0 filas


-- Queremos obtener todas las filas de los morosos (la IZQ) 
-- y solo aquellas de puesto (la DCHA) que sí corresponden con alguna de la izq
-- ( es Combinación exterior izquierda)

select moroso.DNI "morosoDNI", puesto.DNI "puestoDNI"
from moroso left outer join puesto
  on moroso.dni = puesto.dni;

00000003	00000003
00000005	00000005
00000006	00000006
00000007	(null)  --> no tiene valor

-- Con la misma con sulta de moroso y puesto, queremos
-- obtener las filas de la DCHA y solo las de la IZQ si corresponden con las de DCHA
-- (es Combinación exterior derecha)

select moroso.DNI "morosoDNI", puesto.DNI "puestoDNI"
from moroso right outer join puesto
  on moroso.dni = puesto.dni;

(null) 		00000001
(null) 		00000002
00000003	00000003
(null) 		00000004
00000005	00000005
00000006	00000006

-- Con la misma consulta de moroso y puesto, queremos
-- obtener todas las filas de la DCHA y las de la IZQ tengan o no correspondencia con la otra tabla
-- Combinación exterior completa

select moroso.DNI "morosoDNI", puesto.DNI "puestoDNI"
from moroso full outer join puesto
  on moroso.dni = puesto.dni;

(null) 		00000001
(null) 		00000002
00000003	00000003
(null) 		00000004
00000005	00000005
00000006	00000006
00000007	(null)  

-- Con la misma consulta de moroso y puesto, queremos
-- obtener solo las filas de IZQ y DCHA que tienen correspondencia en la otra tabla

select moroso.DNI "morosoDNI", puesto.DNI "puestoDNI"
from moroso inner join puesto
  on moroso.dni = puesto.dni;

00000003	00000003
00000005	00000005
00000006	00000006

-- Hacer la misma consulta anterior con sintaxis simple con comas

select moroso.DNI "morosoDNI", puesto.DNI "puestoDNI"
from moroso,puesto
where moroso.dni = puesto.dni;



-- ==== CONSULTAS ANIDADAS ==== -- 

-- Queremos el DNI y el menor importe de todas las compras

select dni, importe "el menor importe de compra"
from compras 
where importe <= all  
      (select importe from compras);


00000003	3

-- Porqué no da ningún resultado esta consulta ?

-- select dni, importe "el menor importe de compra"
-- from compras 
-- where importe < all   --> no da ninguno !!  
--       (select importe from compras);

 
-- == CONSULTAS ANIDADAS CORRELACIONADAS == --

-- Queremos el DNI y nombre de clientes que compran con 
-- la tarjeta  'VXK'

select DNI,nombreC
from Cliente
where 'VXK' in (select TipoT      -- que 'VXK' esté dentro de los Tipos seleccionados
                 from Compras, Tarjeta
                 where (Cliente.DNI = Compras.DNI AND  -- <-- para cada cliente
                    Compras.NumT = Tarjeta.NumT)
                );

00000003	Client B                      
00000005	Client A                      
00000004	Client A                      


-- Queremos el DNI, la suma de los importes de las compras y el mínimo importe de sus compras
-- solo de las compras cuyo importe individual es menor de 5000
-- y cuya suma de importes de las compras nunca alcance la suma de sus inversiones

select dni, sum(importe) "SUM Compras", MIN(importe)
from compras 
where importe < 5000
group by dni
having sum(importe) < (select sum(Cantidad)   -- si solo tenemos una cantidad devuelta
                            from invierte where compras.dni = invierte.dni); 

00000003	3333	3
00000004	4	4


-- Lo mismo que la consulta anterior excepto la condición de la última línea:
-- y cuya suma de importes de las compras sea menor de TODAS las cantidades individuales invertidas
-- por ese DNI.

select dni, sum(importe) "SUM Compras", MIN(importe)
from compras 
where importe < 5000
group by dni
having sum(importe) < ALL (select Cantidad   -- incluye a los que dan 0 filas , como NULL
                            from invierte where compras.dni = invierte.dni); 

00000003	3333	3
00000004	4	4
00000005	555	5

-- ¿Por qué sale el cliente 5? ¿Debería salir?
-- No debería salir porque no tiene inversiones

-- ¿Cómo quitarlo?
-- == consultando la existencia en un resultado de consulta == --

select dni, sum(importe) "SUM Compras", MIN(importe)
from compras 
where importe < 5000
group by dni
having sum(importe) < ALL (select Cantidad   
                            from invierte where compras.dni = invierte.dni)
       and EXISTS (select Cantidad   
                            from invierte where compras.dni = invierte.dni)
                            ; 

00000003	3333	3
00000004	4	4


-- Queremos la lista de DNIs de clientes que también son morosos
select CL.DNI "clienteDNI"
from cliente CL
where EXISTS (select dni from moroso where moroso.dni = CL.dni);



--  ========== VISTAS  =========--

-- Crear una vista de la lista de DNIs y nombres de clientes que también son morosos
create view mismorosos (dni, nombrec) -- atributos
  AS 
  select CL.DNI , CL.NOMBREC
from cliente CL
where EXISTS (select dni from moroso where moroso.dni = CL.dni)
with read only;

  desc mismorosos

  select * from mismorosos;

00000003	Client B                      
00000005	Client A                      
00000006	Client D                      


-- Crear otra vista MODICABLE con la misma consulta anterior


create view morososmodificables (dni, nombrec) -- atributos
  AS 
  select CL.DNI , CL.NOMBREC
from cliente CL
where EXISTS (select dni from moroso where moroso.dni = CL.dni)
with check option;

 select * from MOROSOSMODFICABLES;
  
00000003	Client B                      
00000005	Client A                      
00000006	Client D                      


-- Actualizar el nombre del cliente 6 y poner 'morosooo'

 update MOROSOSMODFICABLES
     set NombreC = 'morosooo'
     where DNI = '00000006';

-- Comprobar que se ha modificado la vista
 select * from MOROSOSMODFICABLES;

00000003	Client B                      
00000005	Client A                      
00000006	morosooo                      


-- Comprobar que ha cambiado la tabla cliente (la original)

select * from cliente;  --- ha modificado la tabla original

00000001	Client A                      	direc 11
00000003	Client B                      	direc 13
00000002	Client C                      	direc 12
00000005	Client A                      	direc 15
00000004	Client A                      	direc 14
00000006	morosooo                      	direc 12






