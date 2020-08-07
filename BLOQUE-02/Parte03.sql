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
--estado=1 or codubigeo=1 order by codubigeo desc,nombre asc
/*e. Las zonas que NO cumplan: Estado=1 [Y] codubigeo=1 ordenados por
codzona de menor a mayor.*/
NOT (estado=1 and codubigeo=1) order by codzona asc

--02.08
select 
tipo,
case when codtipo=3 then 'RUC' else 'OTRO TIPO' end as TIPO_DOC,
numdoc as NUM_DOC,
razon_social as RAZON_SOCIAL,
codzona as CODZONA,
fec_inicio as FEC_INICIO
from Cliente
/*a. Tipo_cliente=’E’ [Y] codzona de valor 1,3,5 o 7 ordenados alfabéticamente
Z-A por razón_social*/
--where tipo='E' and (codzona=1 or codzona=3 or codzona=5 or codzona=7)
--where tipo='E' and codzona in (1,3,5,7)
--order by razon_social desc
/*Tipo_cliente=’E’ [Y] fec_inicio desde el ‘01/01/1998’ al ‘31/12/1998’
ordenados por fec_inicio del más reciente al más antiguo.*/
where tipo='E' and fec_inicio between '1998-01-01' and '1998-12-31'
order by fec_inicio desc

--02.10
select case when codtipo=1 then 'LE o DNI' else 'OTRO TIPO' end as TIPO_DOC,
numdoc as NUM_DOC,
nombres+' '+ape_paterno+' '+ape_materno as CLIENTE
from Cliente
where tipo='P'
--a. Nombre completo inicie en ‘A’ ('ANA JULIA MORALES','AMADOR MANRIQUE RUIZ')
--and nombres+' '+ape_paterno+' '+ape_materno like 'A%' --%:No importa en valor ni en longitud
--b. Nombre completo contiene la secuencia ‘AMA’ ('AMADOR MANRIQUE RUIZ','JUAN AMARANTO LOPEZ')
--and nombres+' '+ape_paterno+' '+ape_materno like '%AMA%'
--c. Nombre completo finaliza en 'AN'.
--and nombres+' '+ape_paterno+' '+ape_materno like '%AN'
--e. Nombre completo contenga la secuencia ‘ARI’ desde la 2° posición ('MARIANA LOPEZ CABELLO')
--and nombres+' '+ape_paterno+' '+ape_materno like '_ARI%' -- '_' No importa el valor pero longitud=cantidad '_'
--f.Nombre completo tenga como antepenúltimo carácter la ‘M’ ('NNNNNNNM__')
--and nombres+' '+ape_paterno+' '+ape_materno like '%M__'
--h.Nombre completo inicie y finalice con una vocal. --[aeiou]:a,e, i,o,u.
--and nombres+' '+ape_paterno+' '+ape_materno like '[aeiou]%[aeiou]'
--i.Nombre completo inicie y finalice con una consonante. NOTA: Informacíón SOLO debe contener consonantes y vocales --[^aeiou]=Consonante
--and nombres+' '+ape_paterno+' '+ape_materno like '[^aeiou]%[^aeiou]'
--j.Nombre inicie con una vocal y finalice con una consonante.
and nombres+' '+ape_paterno+' '+ape_materno like '[aeiou]%[^aeiou]'