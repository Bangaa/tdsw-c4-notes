SET SERVEROUTPUT ON;
/* 
 * EJERCICIO 09
 * 
 * Función codigo_depto.
 * Recibe la ubicación y 
 * 
 * si es que la ubicación no existe en la tabla:
 * le asignará como número de departamento la decena siguiente al último número 
 * de departamento utilizado, 
 * 
 * Si la ubicación se repite:
 * le asignará como número de departamento un número más al último código de 
 * departamento que ya tiene esa ubicación, para ir ordenando los códigos, 
 * según la ubicación
 *
 */

CREATE or REPLACE function codigo_depto(
	p_ubicacion depto.ubicacion%type
)
RETURN depto.cod_depto%type
AS
	v_found_cod depto.cod_depto%type;
	v_max_cod depto.cod_depto%type;
BEGIN
	SELECT max(cod_depto) into v_found_cod
	FROM depto
	WHERE ubicacion = p_ubicacion;


	IF v_found_cod IS null THEN
		-- ubicacion no encontrada
		SELECT max(cod_depto) into v_found_cod
		FROM depto;
		return v_found_cod + 10;
	ELSE
		-- ubicacion repetida
		return v_found_cod + 1;
	END if;
END codigo_depto;
/

DECLARE
	v_cod depto.cod_depto%type;
BEGIN
	v_cod := codigo_depto('Valpo');
	dbms_output.put_line('Codigo: ' || v_cod);
END;
-- vim:ts=2 sts=-1 sw=2
