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