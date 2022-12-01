SET SERVEROUTPUT ON;

/* Crear un procedimiento denominado prueba_dep_emp al que se le pasan un 
 * número de departamento y un empleo y que verifique si existe en ese 
 * departamento ese trabajo. Utilizar: 
 * 
 * - Una tabla indexada para almacenar las combinaciones válidas de 
 * departamento y trabajos.
 * - Si encuentra que existe, que envíe un mensaje indicando tal situación
 * - Levantar un error de aplicación con el mensaje adecuado si la combinación 
 * no es válida. Comprobar si el trabajo ‘vendedor’ es válido en el 
 * departamento 30 y lo mismo en el departamento 20. */
CREATE OR REPLACE PROCEDURE prueba_dep_emp(
	p_coddepto empleado.cod_depto%TYPE,
	p_empleo empleado.empleo%TYPE)
AS
	TYPE r_depto_emp IS record(
		v_depto empleado.cod_depto%TYPE,
		v_empleo empleado.empleo%TYPE
	);

	TYPE t_dep_emp IS table
	OF r_depto_emp;

	index by binary_integer;

	v_tab_dep_empleo t_dep_emp;

	i number :=1;
	isValido number := 0;
BEGIN
	FOR c_reg in (select distinct cod_depto, empleo from empleado)
	LOOP
		v_tab_dep_empleo(i).v_depto:= c_reg.cod_depto;
		v_tab_dep_empleo(i).v_empleo := c_reg.empleo;
		i := i+1;
	END LOOP;

	FOR j IN 1..v_tab_dep_empleo.LAST
	LOOP
		EXIT WHEN isValido = 1;
		IF v_tab_dep_empleo(j).v_depto = p_coddepto AND v_tab_dep_empleo(j).v_empleo = p_empleo THEN
			dbms_output.put_line('Si existe ese trabajo en el depto.');
			isValido := 1;
		END IF;
	END LOOP;

	IF isValido = 0 THEN
		raise_application_error(-20500,'No es un trabajo válido en ese departamento');
	END IF;
END;
