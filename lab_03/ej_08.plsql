SET SERVEROUTPUT ON;

/* 
 * EJERCICIO 08
 *
 * Procedimiento insertar_depto: Permite insertar un departamento nuevo. El 
 * procedimiento 
 * 
 * recibe
 * 
 *   el nombre y
 *   la ubicación del nuevo departamento.
 *   
 * - Creará el nuevo departamento comprobando que el nombre no se duplique, la 
 * ubicación será pasada a una función llamada codigo_depto (de la siguiente 
 * pregunta), la cual retornará el código de departamento al procedimiento. 
 * 
 * - Enviar un mensaje confirmando la inserción o bien enviando una excepción 
 * si el nombre está duplicado. 
 */

CREATE or REPLACE PROCEDURE insertar_depto(
	p_nombre depto.nom_depto%type,
	p_ubicacion depto.ubicacion%type
)
AS
	v_found_name depto.nom_depto%type;
	v_new_code depto.cod_depto%type;
	ex_depto_duplicated EXCEPTION;
BEGIN

	IF check_dep_exist(p_nombre) = 1 THEN
		-- departamento ya existe 
		RAISE ex_depto_duplicated;
	ELSE
		-- departamento no existe
		v_new_code := codigo_depto(p_ubicacion);

		insert into depto(cod_depto, nom_depto, ubicacion)
		values (v_new_code, p_nombre, p_ubicacion);
		dbms_output.put_line('Nuevo departamento ingresado');
	END if;
EXCEPTION
	when ex_depto_duplicated then
		dbms_output.put_line('ERROR: Ya existe un departamento con ese nombre.');
END insertar_depto;
/

/*
 * Retorna 1 si existe un departamento con el nombre indicado
 * Retorna 0 si no existe un departamento con ese nombre
 */
CREATE or REPLACE function check_dep_exist(
	p_dep_name depto.nom_depto%type
)
return number
AS
	v_count number;
BEGIN
	SELECT count(*) into v_count
	FROM depto
	WHERE depto.nom_depto = p_dep_name;

	IF v_count = 0 THEN
		-- no existe
		RETURN 0;
	ELSE
		RETURN 1;
	END IF;
END check_dep_exist;
/

BEGIN
	insertar_depto('Finanzas', 'Stgo');
END;

-- vim:ts=2 sts=-1 sw=2
