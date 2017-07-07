
/* Esto es un comentario en varias líneas:
  - Este procedimiento es de INTRODUCCION al PL/SQL
  - Es sobre la BDejemplo
*/

CREATE  OR REPLACE PROCEDURE cursor3  as


--------  ======= SECCION Declaración Variables : si es un proc.,fun. o trigger
--      NO necesita poner "declare"

-- variables locales solo visibles dentro del procedimiento

      TDNICL CHAR(8) := '00000000'; -- sin valor tiene NULL por defecto
      TNombreCL CHAR(30);

      Tcoderror NUMBER;
      Ttexterror VARCHAR2(100);

  CURSOR cursor_ricos IS
      select dni, nombreC
      from cliente
      where dni in ( select dni from invierte
                     group by dni
                     having sum(cantidad) > 650000
                     )
      -- para actualizar una atrib. de tabla al recorrer el cursor añado:   
       FOR UPDATE OF nombreC NOWAIT;


      fila_rico cursor_ricos%ROWTYPE; -- variable de fila completa cursor_ricos
                                    -- se puede usar en el fetch
                                    -- no la usamos aquí, solo es un ejemplo

------- ======= SECCION  -- BEGIN sentencias procedimentales 
BEGIN

--- Abro cursor: el puntero se posiciona al principio
  OPEN cursor_ricos;

LOOP
  FETCH  cursor_ricos
    INTO TDNICL, TNombreCL;
  EXIT WHEN cursor_ricos%NOTFOUND; -- si el fetch no da ninguna fila

--            --> atencion  DBMS_output.put_line necesita "set serveroutput on"

--   Ejemplo de uso de IF
  IF TDNICL LIKE '%2' THEN
  DBMS_output.put_line('---- cursor3: sumando , DNI: '|| TDNICL);
      update invierte
          set cantidad = cantidad + 1
      where dni = TDNICL;
  END IF;
  IF TDNICL LIKE '%4' THEN
  DBMS_output.put_line('---- cursor3: restando , DNI: '|| TDNICL);
      update invierte
          set cantidad = cantidad - 1
      where dni = TDNICL;
  END IF;
END LOOP;

DBMS_output.put_line('--> cursor3: proceso acabado por EXIT loop');



--    EJEMPLO de BUCLE usando el FOR:
--        muestro todas las inversiones mayores de esa cantidad.
--    la variable invierte_rec es local al for y no se declara         


FOR invierte_rec in (select * from invierte
                      where cantidad > 300000)
 LOOP
     DBMS_output.put_line('-- buen inversor: ' || invierte_rec.dni || 
                         ' cantidad: ' ||  invierte_rec.cantidad  );
 END LOOP;

--- cierro cursor para volver a ponerlo en la fila primera 
IF cursor_ricos%ISOPEN 
   THEN  CLOSE cursor_ricos; 
END IF;

--- EJEMPLO de actualizar usando el cursor, FOR , CURRENT OF 

FOR r_ricos IN cursor_ricos 
 LOOP
  update cliente SET nombreC = RTRIM(nombreC) || ' es rico'
    WHERE CURRENT OF cursor_ricos;
 END LOOP;




------- SECCION --  EXCEPTION tratamiento de excepciones
--                  pueden ser automáticas de oracle o del usuario 

EXCEPTION
  WHEN NO_DATA_FOUND THEN
   DBMS_output.put_line('--> cursor3: proceso acabado por NODATAFOUND');
   IF cursor_ricos%ISOPEN 
     THEN  CLOSE cursor_ricos; 
   END IF;

  WHEN OTHERS THEN
	Tcoderror:= SQLCODE;
	Ttexterror:= SUBSTR(SQLERRM,1, 100);
  DBMS_output.put_line('--> cursor3: ERROR en DNI : '|| TDNICL );
  DBMS_output.put_line('--> cursor3: ERROR COD: '|| Tcoderror);
  DBMS_output.put_line('--> cursor3: ERROR texto: ' ||  Ttexterror );

------- SECCION -- END  Final del bloque,proc.,func. o trigger
END cursor3;


-------- FUERA: otras instrucciones para el compilador


/* ---------- para ejecutarlo en un Bloque PL/SQL en SQLDeveloper ----
--    en hoja de trabajo: show errors  -- muestra en pantalla errores compilación

   begin
     cursor3;
   end;
*/
 
 




