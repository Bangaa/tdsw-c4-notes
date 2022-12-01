set serveroutput on;
set verify off;


/* 
 * EJERCICIO 09
 *
 * Escriba un trigger que valide el ingreso del empleado, considerando lo 
 * siguiente:
 * 
 * [x] El empleo debe ser: ‘analista’, ‘prog’, ‘vendedor’ o ‘supervisor’, sino 
 * no se permite el ingreso
 * [x] El empleo no puede ser ‘Gerente’ (ya existe un Gerente en la 
 * organización)
 * [x] La fecha de ingreso a la organización no puede ser mayor a la fecha 
 * actual 
 * [x] Si no tiene un supervisor asignado, es decir el campo cod_supervisor es 
 * nulo, se le asignará como código de supervisor el del ‘Gerente’ (no puede 
 * asignar directamente el código, debe obtenerlo)
 * [x] Si tiene un supervisor asignado, debe validar que el salario semanal del 
 * empleado no es mayor al del supervisor. Si el salario semanal del empleado 
 * es mayor al del supervisor, entonces debe asignarse al empleado, un 
 * salario_semanal igual al promedio del salario semanal de todos los empleados 
 * del departamento al cual pertenece el empleado
 * [x] Si la comisión es nula o es cero o es mayor a la comisión más baja de 
 * los empleados, se asignará la comisión más baja de los empleados
 * [x] Si el grado es nulo o es cero o es distinto al grado que le corresponde 
 * según el salario semanal y los tramos definidos en la tabla sueldo, se le 
 * asignará el grado que efectivamente le corresponda */

CREATE OR REPLACE TRIGGER tr_validate_new_emp
BEFORE INSERT ON empleado
FOR EACH ROW
DECLARE
	ex_not_valid EXCEPTION;
	v_gerente_id empleado.cod_emp%type;
	v_sueldo_max empleado.salario_sem%type;
	v_avg_salario empleado.salario_sem%type;
	v_min_comision empleado.comision%type;
BEGIN
	if :new.empleo = 'analista'
			or :new.empleo = 'prog'
			or :new.empleo = 'vendedor'
			or :new.empleo = 'supervisor' then
		-- ok
		if :new.fecha_ingreso > sysdate then
			-- no valido
			-- raise
			dbms_output.put_line('La fecha de ingreso no puede ser mayor a la actual');
			raise ex_not_valid;
		end if;

		if :new.cod_supervisor is null then
			-- asignar como supervisor al gerente
			select cod_emp
			into v_gerente_id
			from empleado
			where empleo = 'Gerente';
			:new.cod_supervisor := v_gerente_id;
		else
			-- comprobar que no gane mas que el supervisor
			select salario_sem
			into v_sueldo_max
			from empleado
			where cod_emp = :new.cod_supervisor;

			if :new.salario_sem > v_sueldo_max then
				-- no puede tener mayor sueldo que el supervisor
				-- asignar promedio de los sueldos de los empleados del mismo depto
				select avg(salario_sem)
				into :new.salario_sem
				from empleado
				where empleado.cod_depto = :new.cod_depto;
			end if;
		end if;

		select min(comision)
		into v_min_comision
		from empleado;

		if :new.comision is null
				or :new.comision = 0
				or :new.comision > v_min_comision then
			:new.comision := v_min_comision;
		end if;

		:new.grado := get_grado(:new.salario_sem);
	else
		-- no valido
		-- raise
		dbms_output.put_line('El empleo no es valido');
		raise ex_not_valid;
	end if;
EXCEPTION
	-- los datos del empleado no son validos
	when ex_not_valid then
		dbms_output.put_line('ERROR: No se pudo ingresar al empleado.');
END tr_validate_new_emp;
/

CREATE OR REPLACE FUNCTION get_grado(p_sueldo empleado.salario_sem%type)
RETURN empleado.grado%type
AS
	v_grado sueldo.grado%type;
BEGIN
	select grado into v_grado
	from sueldo
	where sueldo_minimo <= p_sueldo
	and sueldo_maximo >= p_sueldo;

	RETURN v_grado;
END get_grado;

-- vim:ts=2 sw=2 sts=-1
