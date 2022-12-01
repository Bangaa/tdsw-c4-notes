SET SERVEROUTPUT ON;
SET VERIFY OFF;
/* 
 * Ejercicio 01:
 * 
 * Escribir un procedimiento que tenga un
 * 
 * parámetro de entrada
 *  - valor de salario de empleado.
 * 
 * Este procedimiento deberá mostrar los empleados que tengan dicho salario, 
 * sino deberá enviar un mensaje que indique que no se encontraron datos.
 */
CREATE OR REPLACE PROCEDURE EJ01(
  p_salario empleado.salario_sem%TYPE
)
AS
	cursor c_empleado is
		SELECT nom_emp
		FROM empleado
		WHERE salario_sem = p_salario;

	v_nombre empleado.nom_emp%type;
BEGIN
	OPEN c_empleado;
	LOOP
		FETCH c_empleado into v_nombre;
		EXIT WHEN c_empleado%notfound;

		dbms_output.put_line(v_nombre);
	END LOOP;

	if c_empleado%rowcount = 0 then
		dbms_output.put_line('No se encontraron datos');
	end if;

	CLOSE c_empleado;
END EJ01;
/

begin
	EJ01(0);
end;
	

-- vim:ts=2 sts=-1 sw=2
