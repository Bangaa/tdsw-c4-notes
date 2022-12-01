
CREATE VIEW depto_cant_Emp as
SELECT depto.cod_Depto , depto.nom_depto, depto.ubicacion, COUNT(cod_Emp)  total_emp
FROM empleado, depto
WHERE empleado.cod_Depto = depto.cod_Depto
GROUP BY depto.cod_Depto , depto.nom_depto, depto.ubicacion;

-- vim:ts=2 sts=-1 sw=2
