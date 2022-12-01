create table depto
(cod_depto int not null,
nom_depto char(10) not null,
ubicacion char(10) not null);

alter table depto
add (constraint pk_depto primary key (cod_depto));

create table sueldo
(grado   int not null,
sueldo_minimo int not null,
sueldo_maximo int not null);

alter table sueldo
add (constraint pk_sueldo primary key (grado));

create table empleado
(cod_emp int not null,
nom_emp char(15) not null,
empleo   char(20) not null,
cod_supervisor int null,
fecha_ingreso date not null,
salario_sem int not null,
comision int null,
cod_depto int not null,
grado int null);

alter table empleado
add (constraint pk_empleado primary key (cod_emp))
add (constraint fk_empleado_depto foreign key(cod_depto) references depto(cod_depto))
add (constraint fk_empleado_supervisor foreign key(cod_supervisor) references empleado(cod_emp)) ;

