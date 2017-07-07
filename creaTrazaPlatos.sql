create or replace 
    return NUMBER 
  AS
  
     existe_ya NUMERIC;  
 
    Tcoderror NUMBER;
    Ttexterror VARCHAR2(100);

  
BEGIN

-- Si no existe la tabla "trazaplatos", la crea igual que tabla "contiene"

select count(table_name) into existe_ya from tabs where table_name ='TRAZAPLATOS';

-- DBMS_OUTPUT.PUT_LINE( 'existe si es 1: ' || existe_ya);

IF existe_ya = 0 THEN -- si no existe la tabla, la crea 
   execute immediate 'create table TRAZAPLATOS as select * from CONTIENE where 1=0';
END IF;

return 0;
 
 EXCEPTION
    WHEN OTHERS THEN
    	Tcoderror:= SQLCODE;
    	Ttexterror:= SUBSTR(SQLERRM,1, 100);
      DBMS_OUTPUT.PUT_LINE('--, ERROR '|| Tcoderror || ' -- ' || Ttexterror);

      return 1;
      
      
END;

/* ------ comprobacion 

DECLARE
plato contiene%ROWTYPE; 
bien numeric := 0;
BEGIN
-- prueba : solo puede devolver una fila
select * into plato from contiene where precio_con_comision = 17.85;
bien := guardaplato(plato);
DBMS_OUTPUT.PUT_LINE( 'devuelve guardaplato: ' || bien);
END;

--------*/

