--Carga Planes de Internet

insert into PlanInternet(nombre,preciorefsol,descripcion) values ('PLAN TOTAL I',50,'Plan anterior ESTANDAR I')
go
insert into PlanInternet(nombre,preciorefsol,descripcion) values ('PLAN TOTAL II',60,'Plan anterior ESTANDAR II')
go
insert into PlanInternet(nombre,preciorefsol,descripcion) values ('GOLD I',70,'Plan nuevo')
go
insert into PlanInternet(nombre,preciorefsol,descripcion) values ('GOLD II',90,'Plan nuevo')
go
insert into PlanInternet(nombre,preciorefsol,descripcion) values ('GOLD III',100,'Plan nuevo')
go

select * from PlanInternet