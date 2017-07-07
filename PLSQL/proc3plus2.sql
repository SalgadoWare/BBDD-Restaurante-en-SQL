CREATE  OR REPLACE PROCEDURE proc3plus2 (
	dnibusca cliente.DNI%TYPE, 
	NombreCL   cliente.NombreC%TYPE,
	DirCL      cliente.Direccion%TYPE
      ) as

-- variable solo visible dentro del procedimiento

-- vars de trabajo
      TDNICL CHAR(8);
      TNombreCL CHAR(30);

      Tcoderror NUMBER;
      Ttexterror VARCHAR2(100);
-- vars para leer datos
	


BEGIN

  DBMS_output.put_line('--- proc3plus, begin '|| dnibusca);
  update cliente 
       set NombreC = NombreCL  
  WHERE DNI = dnibusca;


 IF SQL%NOTFOUND THEN
  DBMS_output.put_line('--- proc3plus, no encuentra '|| dnibusca);
	insert into cliente 
		values (dnibusca,NombreCL,DirCL);
  END IF;
TDNICL := dnibusca;
IF TDNICL = '00000005' THEN
      DBMS_output.put_line('--- proc3plus, en el IF: '|| TDNICL);
   ELSE
      TDNICL := ':ELSE ';
      DBMS_output.put_line('--- proc3plus, otro cliente: '|| TDNICL);
   END IF;

END proc3plus2;


---------- para ejecutarlo en -----------------
/* 
begin
   proc3plus2('0000plus','nombre PLUS nuevo','dir PLUS nueva');
end;
*/

