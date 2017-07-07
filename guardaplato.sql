create or replace 
FUNCTION guardaPlato(plato contiene%ROWTYPE)
    return NUMBER 
  AS
  
 existe_ya VARCHAR2(30);  
  
BEGIN

-- Funcion CREATRAZAPLATOS: Si no existe la tabla "trazaplatos", la crea igual que "contiene"

IF (CREATRAZAPLATOS = 0) THEN
   INSERT INTO trazaplatos VALUES plato;
   return 0;
ELSE
   return 1;
END IF;
  
EXCEPTION
      WHEN OTHERS THEN
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
DBMS_OUTPUT.PUT_LINE( 'devuelve guardaplato, bien si es cero: ' || bien);
END;
-- Mirar a ver si ha creado una fila en la tabla TrazaPlato

--------*/

