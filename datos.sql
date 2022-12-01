alter session set nls_date_format = 'dd/mm/yyyy';

insert into depto values (10,'Finanzas','Valpo');
insert into depto  values (20,'Desarrollo','Stgo');
insert into depto  values (30,'Ventas','Vina');
insert into depto  values (40,'Operacion','Quilpue');


insert into empleado  values (7839, 'Karla', 'Gerente','','17/11/2011',50000,0,10,0);
insert into empleado  values (7566, 'Juan P.', 'supervisor',7839,'02/04/2011',29750,0,20,0);
insert into empleado  values (7902, 'Fabian', 'analista',7566,'03/12/2011',30000,0,20,0);
insert into empleado  values (7369, 'Juan', 'prog',7902,'17/12/2010',8000,0,20,0);
insert into empleado  values (7698, 'Blanca', 'supervisor',7839,'01/05/2011',28500,0,30,0);
insert into empleado  values (7499, 'Allen', 'vendedor',7698,'20/02/2011',16000,3000,30,0);
insert into empleado  values (7521, 'Williams', 'vendedor',7698,'22/02/2011',12500,5000,30,0);
insert into empleado  values (7654, 'Martin', 'vendedor',7698,'28/10/2011',12500,1400,30,0);
insert into empleado  values (7782, 'Carlos', 'supervisor',7839,'09/06/2011',24500,0,10,0);
insert into empleado  values (7788, 'Silvia', 'analista',7566,'09/12/2011',30000,0,20,0);
insert into empleado  values (7844, 'Tomas', 'vendedor',7698,'08/10/2011',15000,0,30,0);
insert into empleado  values (7876, 'Alvaro', 'prog',7788,'12/01/2013',11000,0,20,0);
insert into empleado  values (7900, 'Jaime', 'prog',7698,'03/12/2011',9500,0,30,0);
insert into empleado  values (7934, 'Miguel', 'prog',7782,'23/01/2012',13000,0,10,0);
insert into empleado values (7838, 'Karlo', 'analista','7839','17/11/2011',50000,0,40,5);
insert into empleado values (7565, 'Juana.', 'supervisor',7839,'02/04/2011',29750,0,40,4);
insert into empleado values (7697, 'Ana', 'supervisor',7839,'01/05/2011',45000,0,40,5);
insert into empleado values (7901, 'Cecilia', 'analista',7697,'03/12/2011',30000,0,40,4);
insert into empleado values (7368, 'Cristina', 'prog',7565,'17/12/2010',8000,0,40,1);



insert into sueldo values (1,7000,12000);
insert into sueldo values (2,12001,14000);
insert into sueldo values (3,14001,20000);
insert into sueldo values (4,20001,30000);
insert into sueldo values (5,30001,99990);


