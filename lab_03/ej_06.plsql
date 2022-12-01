SET SERVEROUTPUT ON;

/*
 * Ejercicio 06
 *
 * Implemente la función recursiva de la sucesión de Fibonacci
 */

create or replace function fibonacci(p_num number)
return number as
	ex_param_error exception;
begin
	if p_num = 0 then
		return 0;
	elsif p_num = 1 then
		return 1;
	elsif p_num > 0 then
		return fibonacci(p_num - 2) + fibonacci(p_num - 1);
	else
		return -1;
	end if;
end fibonacci;
/

begin
	for v_i in 1..6
	loop
		dbms_output.put_line(fibonacci(v_i));
	end loop;
end;

-- vim:ts=2 sts=-1 sw=2
