--ALTER TABLE [dbo].[Zona] NOCHECK CONSTRAINT [RefUbigeo32]
--GO
insert into Zona(nombre,estado,codubigeo) values ('CAJATAMBO-A',1,18)
go
insert into Zona(nombre,estado,codubigeo) values ('CAJATAMBO-B',1,18)
go
insert into Zona(nombre,estado,codubigeo) values ('CAJATAMBO-C',1,18)
go
insert into Zona(nombre,estado,codubigeo) values ('COPA ZA',1,19)
go
insert into Zona(nombre,estado,codubigeo) values ('COPA ZB',0,19)
go
insert into Zona(nombre,estado,codubigeo) values ('COPA ZC',1,19)
go
insert into Zona(nombre,estado,codubigeo) values ('GORGOR ZA',1,20)
go
insert into Zona(nombre,estado,codubigeo) values ('GORGOR ZB',1,20)
go
insert into Zona(nombre,estado,codubigeo) values ('GORGOR ZC',1,20)
go
insert into Zona(nombre,estado,codubigeo) values ('GORGOR ZD',1,20)
go
insert into Zona(nombre,estado,codubigeo) values ('GORGOR ZE',1,20)
go

select * from Zona