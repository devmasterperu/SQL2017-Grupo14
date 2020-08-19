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

insert into PlanInternet(descripcion,preciorefsol,nombre) values ('Solicitado por comité junio 2020.',200.00,'STAR II')

select * from PlanInternet