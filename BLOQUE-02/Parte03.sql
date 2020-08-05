--02.03
select cod_dpto+cod_prov+cod_dto as UBIGEO,nombre_dpto as DPTO, nombre_prov as PROV, nombre_dto as DTO, 
case when nombre_prov='Huaura' then 'Provincia de Huaura'
else 'Otra Provincia'
end as MENSAJE
from Ubigeo

--02.05
declare @Tipoc decimal (5,3) = 3.510

select nombre as [PLAN], preciorefsol as PRECIO_SOL,
cast(round (preciorefsol /@Tipoc,3)as decimal (8,3)) as PRECIO_DOL,
case when cast(round (preciorefsol /@Tipoc,3)as decimal (8,3)) >=0 and cast(round (preciorefsol /@Tipoc,3)as decimal (8,3)) <20 then '[0,20>'
     when cast(round (preciorefsol /@Tipoc,3)as decimal (8,3))>=20 and cast(round (preciorefsol /@Tipoc,3)as decimal (8,3))<27 then '[20,27>'
	 when cast(round (preciorefsol /@Tipoc,3)as decimal (8,3))>=27 then '[27, +>'
	 else 'sin rango dol'
	 end
	 as [RANGO DOL]
from PlanInternet

--02.06
select codzona as CODZONA,nombre as ZONA,codubigeo as [CODIGO UBIGEO],estado as ESTADO,
case when estado=1 then 'Zona activa'
     when estado=0 then 'Zona inactiva'
	 else 'Sin mensaje'
end as [MENSAJE ESTADO]
from Zona
where 
--a. Estado=1 [Y] codubigeo=1 ordenados por codzona de mayor a menor
--estado=1 and codubigeo=1 order by codzona desc
--b. Estado=1 [Y] codubigeo=1 ordenados por nombre alfabéticamente Z-A
--estado=1 and codubigeo=1 order by nombre desc
--c. Estado=0 [O] codubigeo=1 ordenados por estado de menor a mayor.
--estado=0 or codubigeo=1 order by estado asc
/*d. Estado=1 [O] codubigeo=1 ordenados por codubigeo de mayor a menor en
1° nivel y nombre de manera alfabética A-Z en 2° nivel.*/
estado=1 or codubigeo=1 order by codubigeo desc,nombre asc