CREATE  OR REPLACE PROCEDURE proc3 (
	dnibusca cliente.DNI%TYPE, -- el tipo del atributo de tabla cliente
	NombreCL   cliente.NombreC%TYPE, -- el modo por defecto es "IN"
	DirCL      cliente.Direccion%TYPE
        -- si fuera un tipo como CHAR(10), solo se pone CHAR
      ) as    -- también se usa "IS"

-- variable solo visible dentro del procedimiento

-- vars de trabajo
      TDNICL CHAR(8);
      TNombreCL CHAR(30);

      Tcoderror NUMBER;
      Ttexterror VARCHAR2(100);
-- vars para leer datos
	
-- excepción del usuario
	cliente_listillo EXCEPTION;

BEGIN

-- la SELECT necesita variables para almacenar el resultado.
-- Si no devuelve nada o devuelve varias filas: salta una excepcion

  SELECT DNI, NombreC
    INTO TDNICL, TNombreCL  -- es OBLIGATORIO tener el INTO 
    FROM Cliente
    WHERE DNI = dnibusca;

DBMS_OUTPUT.PUT_LINE('selecciona cliente: ' || TDNICL);

IF TDNICL = '00000005' THEN
      DBMS_OUTPUT.PUT_LINE('Activa EXCEPCION cliente_listillo: ' || TDNICL);
      RAISE cliente_listillo;
   ELSE
      TDNICL := 'PROC3: -- ELSE ';
   END IF;

-------------- instrucciones DML de SQL y PL/SQL --------
-- quiero poner todos los clientes en morosos
-- pero debo evitar incluir los que ya estaban

insert into moroso
  select * from cliente where dni not in (select dni from moroso);
 

-- quiero poner todos los clientes en morosos
insert into moroso
  select * from cliente where dni not in (select dni from moroso);

-- quiero quitar de moroso aquellos clientes que están en cliente
-- porque son buenos clientes (excepto el 3 para probar después)

delete from moroso 
where moroso.dni IN (select dni from cliente)
    and moroso.dni <> '00000003';

-- Quiero poner a 'basura' el tipo de bono en las inversiones
--  de los morosos cuya cantidad es menor de 320000 euros

update invierte 
  set Tipo = 'basura'
where invierte.dni in (select dni from moroso)
   and cantidad < 320000;
    




EXCEPTION
  WHEN NO_DATA_FOUND THEN   -- automática: tiene un código y un texto largo 
	Tcoderror:= SQLCODE;
	Ttexterror:= SUBSTR(SQLERRM,1, 100);
  DBMS_OUTPUT.PUT_LINE( Tcoderror || ' -- ' || Ttexterror);
	insert into cliente values (dnibusca,NombreCL,DirCL);

  WHEN cliente_listillo THEN   -- del usuario o programador
	Tcoderror:= SQLCODE;
	Ttexterror:= '----- PROC3: CLIENTE PELIGROSO ------';
  DBMS_OUTPUT.PUT_LINE( Tcoderror || ' -- ' || Ttexterror);

  WHEN OTHERS THEN       -- en cualquier otro caso 
	Tcoderror:= SQLCODE;
	Ttexterror:= SUBSTR(SQLERRM,1, 100);
  DBMS_OUTPUT.PUT_LINE( Tcoderror || ' -- ' || Ttexterror);

END proc3;


/* ---------- para ejecutarlo en un Bloque PL/SQL en SQLDeveloper ----
  declare  -- opcional
-- A --
   begin
     proc3('00000005','nombre 5 nuevo','dir 5 nueva');
   end;
-- B --
   begin
     proc3('000000xx','nombre XX nuevo','dir XX nueva');
   end;
*/
