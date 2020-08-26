--04.01
select * from PlanInternet
--a. 
insert into PlanInternet values ('GOLD IV',110.00,'Solicitado por comité junio 2020.')

--b. SSMS
--c. 
insert into PlanInternet values 
('PREMIUM II',140.00,'Solicitado por comité junio 2020.'),
('PREMIUM III',160.00,'Solicitado por comité junio 2020.'),
('PREMIUM IV',180.00,'Solicitado por comité junio 2020.')

begin tran --IMPORTANTE
delete from PlanInternet where codplan in (11,12,13)
rollback   --SIEMPRE_USAR

DBCC CHECKIDENT('PlanInternet',RESEED,7) --RESETEAR VALOR AUTOGENERADO 7

insert into PlanInternet values 
('PREMIUM II',140.00,'Solicitado por comité junio 2020.'),
('PREMIUM III',160.00,'Solicitado por comité junio 2020.'),
('PREMIUM IV',180.00,'Solicitado por comité junio 2020.')

--d.

insert into PlanInternet(descripcion,preciorefsol,nombre) values ('Solicitado por comité junio 2020.',190.00,'STAR I')

--e. 

--Agregar a los planes la columna fechoraregistro con valor predeterminado de Fecha y hora actual 
alter table PlanInternet add fechoraregistro datetime default getdate()

begin tran --IMPORTANTE
delete from PlanInternet where codplan in (13)
rollback   --SIEMPRE_USAR

DBCC CHECKIDENT('PlanInternet',RESEED,11) --RESETEAR VALOR AUTOGENERADO 11

insert into PlanInternet(descripcion,preciorefsol,nombre) values ('Solicitado por comité junio 2020.',200.00,'STAR II')

select * from PlanInternet

--f
alter table PlanInternet add estado bit default 0

insert into PlanInternet(descripcion,preciorefsol,nombre,fechoraregistro) 
values ('Solicitado por comité junio 2020.',210.00,'STAR III','2020-08-20 19:37:00.000')

select * from PlanInternet

--04.02.a

select * from Zona_Carga
select * from Ubigeo

begin tran --IMPORTANTE
delete from Zona where codzona>=1012
rollback   --SIEMPRE_USAR

DBCC CHECKIDENT('Zona',RESEED,22) --RESETEAR VALOR AUTOGENERADO 22

insert into Zona(codubigeo,nombre,estado)
select u.codubigeo as codubigeo,nombre,1 as estado
from Zona_Carga zc inner join Ubigeo u 
on RTRIM(LTRIM(UPPER(zc.departamento)))=RTRIM(LTRIM(UPPER(u.nombre_dpto))) and 
   RTRIM(LTRIM(UPPER(zc.provincia)))=RTRIM(LTRIM(UPPER(u.nombre_prov))) and
   RTRIM(LTRIM(UPPER(zc.distrito)))=RTRIM(LTRIM(UPPER(u.nombre_dto)))
where estado='ACTIVO'

--04.02.b

--create procedure InsZona
alter procedure InsZona
as
select u.codubigeo as codubigeo,nombre,0 as estado
from Zona_Carga zc inner join Ubigeo u 
on RTRIM(LTRIM(UPPER(zc.departamento)))=RTRIM(LTRIM(UPPER(u.nombre_dpto))) and 
   RTRIM(LTRIM(UPPER(zc.provincia)))=RTRIM(LTRIM(UPPER(u.nombre_prov))) and
   RTRIM(LTRIM(UPPER(zc.distrito)))=RTRIM(LTRIM(UPPER(u.nombre_dto)))
where estado='INACTIVO'

begin tran --IMPORTANTE
delete from Zona where codzona>=29
rollback   --SIEMPRE_USAR

DBCC CHECKIDENT('Zona',RESEED,28) --RESETEAR VALOR AUTOGENERADO 28

insert into Zona(codubigeo,nombre,estado) --Inserte desde 29 hacia adelante
execute InsZona

select * from Zona

--04.02.c (TAREA)

--04.03
SET IDENTITY_INSERT dbo.Zona ON; --HABILITA INSERTAR VALORES EN COLUMNAS IDENTITY

insert into Zona(codzona,codubigeo,nombre,estado) values (12,18,'CAJATAMBO-A',1)
go
insert into Zona(codzona,codubigeo,nombre,estado) values (13,18,'CAJATAMBO-B',1)
go
insert into Zona(codzona,codubigeo,nombre,estado) values (14,18,'CAJATAMBO-C',1)
go

SET IDENTITY_INSERT dbo.Zona OFF;--DESHABILITA INSERTAR VALORES EN COLUMNAS IDENTITY

select * from Zona

--04.05
begin tran--COLOCAR_SIEMPRE
	delete from Telefono
	where codcliente=18 and tipo<>'LLA'--teléfonos del cliente codcliente=18 y que no sean del tipo ‘LLAMADA’
rollback --COLOCAR_SIEMPRE

select * from Telefono
where tipo<>'LLA'

--04.07

select c.tipo,c.estado,u.cod_dpto,u.cod_prov,u.cod_dto from Contrato co
inner join Cliente c on co.codcliente=c.codcliente
inner join Zona z on c.codzona=z.codzona
inner join Ubigeo u on z.codubigeo=u.codubigeo
where c.tipo='P' and c.estado=0 and u.cod_dpto='15' and u.cod_prov='08' and u.cod_dto='01'

begin tran
	delete co
	from Contrato co
	inner join Cliente c on co.codcliente=c.codcliente
	inner join Zona z on c.codzona=z.codzona
	inner join Ubigeo u on z.codubigeo=u.codubigeo
	where c.tipo='P' and c.estado=0 and u.cod_dpto='15' and u.cod_prov='08' and u.cod_dto='01'
rollback

--04.09
begin tran
update cli
set    cli.numdoc='46173385',
       cli.nombres='DOMITILA CAMILA',
	   cli.ape_paterno='LOPEZ',
	   cli.ape_materno='MORALES',
	   cli.fec_nacimiento='1980-01-09',
	   cli.sexo='F',
	   cli.email='DOMITILA_LOPEZ@GMAIL.COM',
	   cli.direccion='URB. LOS CIPRESES M-24'
from Cliente cli 
where codcliente=500
rollback

select * from Cliente

--04.11
--Crear columna nuevo_precio
alter table Contrato add nuevo_precio decimal(8,2) null

select top 1000 codcliente,codplan,precio,nuevo_precio,periodo from Contrato

select top 1 codplan,nombre,preciorefsol from PlanInternet

--Calcular columna nuevo_precio
select * from PlanInternet

/*
	update co
	set  co.nuevo_precio=0.95*p.preciorefsol --5% descuento sobre precio referencial del plan cto.			 
	from Contrato co inner join
	PlanInternet p on co.codplan=p.codplan
	where co.codplan in (1,2,3,4,5,8) and co.periodo='Q'

	update co
	set  co.nuevo_precio=0.90*p.preciorefsol --5% descuento sobre precio referencial del plan cto.			 
	from Contrato co inner join
	PlanInternet p on co.codplan=p.codplan
	where co.codplan in (1,2,3,4,5,8) and co.periodo='M'

	update co
	set  co.nuevo_precio=0.95*p.preciorefsol --5% descuento sobre precio referencial del plan cto.			 
	from Contrato co inner join
	PlanInternet p on co.codplan=p.codplan
	where co.codplan in (1,2,3,4,5,8) and co.periodo='Q'
*/

begin tran
	update co
	set  co.nuevo_precio=case when co.codplan in (1,2,3,4,5,8) and co.periodo='Q'
	                          then 0.95*p.preciorefsol --5% descuento sobre precio referencial del plan cto.
							  when co.codplan in (1,2,3,4,5,8) and co.periodo='M'
							  then 0.90*p.preciorefsol --10% descuento sobre precio referencial del plan cto.
							  else 0.98*p.preciorefsol --2% descuento sobre precio referencial del plan cto.
						  end
	from Contrato co inner join
	PlanInternet p on co.codplan=p.codplan
rollback

select top 1000 codcliente,codplan,precio,nuevo_precio,periodo from Contrato

--Quiénes son los clientes a los cuales no les conviene este nuevo precio

select codcliente,codplan,precio,nuevo_precio from Contrato
where nuevo_precio>precio

--Quiénes son los clientes detectados con un diferencial de S/50.00 a más entre el nuevo precio y el precio actual

select codcliente,codplan,nuevo_precio,precio,nuevo_precio-precio as diferencial from Contrato
where nuevo_precio-precio>=50

