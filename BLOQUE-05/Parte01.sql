--05.01

/*UTILIZANDO 4 CONSULTAS*/

--El total de contratos
select count(codcliente) from Contrato

--El total de contratos pertenecientes a clientes persona
select count(co.codcliente) from Contrato co
left join Cliente c on co.codcliente=c.codcliente
where c.tipo='P'

--El total de contratos pertenecientes a clientes empresa
select count(co.codcliente) from Contrato co
left join Cliente c on co.codcliente=c.codcliente
where c.tipo='E'

--El total de contratos pertenecientes a clientes de tipo desconocido
select count(co.codcliente) from Contrato co
left join Cliente c on co.codcliente=c.codcliente
where c.tipo is null

/*UTILIZANDO 1 CONSULTA*/

--CONSULTA_PADRE
select count(codcliente) as TOT_C,
       --CONSULTA_HIJA
       (select count(co.codcliente) 
	    from Contrato co left join Cliente c on co.codcliente=c.codcliente
		where c.tipo='P') as TOT_C_P,
		--CONSULTA_HIJA
		(select count(co.codcliente) 
		from Contrato co left join Cliente c on co.codcliente=c.codcliente
		where c.tipo='E') as TOT_C_E,
		--CONSULTA_HIJA
		(select count(co.codcliente) from Contrato co
		left join Cliente c on co.codcliente=c.codcliente
		where c.tipo is null) as TOT_C_O
from   Contrato

--05.03
select count(codcliente) from Contrato where codplan=1 --Cuantos contratos son del plan 1
select count(codcliente) from Contrato where codplan=2 --Cuantos contratos son del plan 2
select count(codcliente) from Contrato where codplan=3 --Cuantos contratos son del plan 3
select count(codcliente) from Contrato where codplan=13 --Cuantos contratos son del plan 13

--CONSULTA_PADRE
select replace(upper(nombre),' ','_') as [PLAN],--replace(expresión,valor_buscado,valor_mostrar)
(select count(codcliente) from Contrato co where co.codplan=p.codplan) as [TOTAL],--Cuantos contratos son plan 1 (HIJA)
case when (select count(codcliente) from Contrato co where co.codplan=p.codplan) between 0 and 99
	 then 'Plan de baja demanda.'
	 when (select count(codcliente) from Contrato co where co.codplan=p.codplan) between 100 and 199
	 then 'Plan de mediana demanda.'
	 when (select count(codcliente) from Contrato co where co.codplan=p.codplan)>=200
	 then 'Plan de alta demanda.'
	 else 'Sin mensaje'
end as MENSAJE
from PlanInternet p
order by [TOTAL] asc

--05.05
select 15/121 --0
select 15*1.00/121 --0.123966
select round(15*1.00/121,2) --0.120000
select cast(round(15*1.00/121,2) as decimal(5,2)) --0.12 (Redondear al centésimo y convertir a decimal(5,2))

--CONSULTA_PADRE
select 
replace(upper(nombre),' ','_') as [PLAN],--replace(expresión,valor_buscado,valor_mostrar)
--CONSULTA_HIJA
(select count(codcliente) from Contrato co where co.codplan=p.codplan) as [TOTAL-P],--Cuantos contratos son de cada plan (HIJA)
--CONSULTA_HIJA
(select count(codcliente) from Contrato) as [TOTAL],
--CONSULTA_HIJA
cast(round((select count(codcliente) from Contrato co where co.codplan=p.codplan)*100.00/
	       (select count(codcliente) from Contrato),2)
as decimal(5,2)) as PORCENTAJE
from PlanInternet p
order by PORCENTAJE desc