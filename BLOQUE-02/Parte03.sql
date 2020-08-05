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
