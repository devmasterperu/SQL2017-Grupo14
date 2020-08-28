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
select replace(upper(nombre),' ','_') as [PLAN],--replace(expresi�n,valor_buscado,valor_mostrar)
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
select cast(round(15*1.00/121,2) as decimal(5,2)) --0.12 (Redondear al cent�simo y convertir a decimal(5,2))

--CONSULTA_PADRE
select 
replace(upper(nombre),' ','_') as [PLAN],--replace(expresi�n,valor_buscado,valor_mostrar)
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

--05.07

--SUBCONSULTAS_SELECT:

--CONSULTA_PADRE
select 
replace(upper(nombre),' ','_') as [PLAN],--replace(expresi�n,valor_buscado,valor_mostrar)
--CONSULTA_HIJA
isnull((select count(codcliente) from Contrato co where co.codplan=p.codplan),0) as [CO-TOTAL],--Cuantos contratos x plan
--CONSULTA_HIJA
isnull((select avg(precio) from Contrato co where co.codplan=p.codplan),0) as [CO-PROM],--Monto promedio de precios x plan
--CONSULTA_HIJA
isnull((select min(fec_contrato) from Contrato co where co.codplan=p.codplan),'9999-12-31') as [CO-ANTIGUO],--Fecha contrato m�s antigua x plan
--CONSULTA_HIJA
isnull((select max(fec_contrato) from Contrato co where co.codplan=p.codplan),'9999-12-31') as [CO-RECIENTE]--Fecha contrato m�s reciente x plan
from PlanInternet p
order by [CO-TOTAL] desc

--SUBCONSULTAS_FROM:

select 
replace(upper(nombre),' ','_') as [PLAN],--replace(expresi�n,valor_buscado,valor_mostrar)
--CONSULTA_HIJA
isnull(rp.total,0) as [CO-TOTAL],--Cuantos contratos x plan
--CONSULTA_HIJA
isnull(rp.promedio,0) as [CO-PROM],--Monto promedio de precios x plan
--CONSULTA_HIJA
isnull(rp.minimo,'9999-12-31') as [CO-ANTIGUO],--Fecha contrato m�s antigua x plan
--CONSULTA_HIJA
isnull(rp.maximo,'9999-12-31') as [CO-RECIENTE]--Fecha contrato m�s reciente x plan
from PlanInternet p 
left join
(
select codplan,count(codcliente) as total,avg(precio) as promedio,min(fec_contrato) as minimo,max(fec_contrato) as maximo
from Contrato
group by codplan
) rp on p.codplan= rp.codplan
order by [CO-TOTAL] desc

--CTES
WITH CTE_RP AS --CTE_NAME
(	--INNER_QUERY
	select codplan,count(codcliente) as total,avg(precio) as promedio,min(fec_contrato) as minimo,max(fec_contrato) as maximo
	from Contrato
	group by codplan
)   --OUTER_QUERY
select 
replace(upper(nombre),' ','_') as [PLAN],--replace(expresi�n,valor_buscado,valor_mostrar)
--CONSULTA_HIJA
isnull(rp.total,0) as [CO-TOTAL],--Cuantos contratos x plan
--CONSULTA_HIJA
isnull(rp.promedio,0) as [CO-PROM],--Monto promedio de precios x plan
--CONSULTA_HIJA
isnull(rp.minimo,'9999-12-31') as [CO-ANTIGUO],--Fecha contrato m�s antigua x plan
--CONSULTA_HIJA
isnull(rp.maximo,'9999-12-31') as [CO-RECIENTE]--Fecha contrato m�s reciente x plan
from PlanInternet as p 
left join CTE_RP  as rp on p.codplan= rp.codplan
order by [CO-TOTAL] desc

--05.09

select c.codcliente as [COD-CODCLIENTE],
concat(nombres,' ',ape_paterno,' ',ape_materno) as [CLIENTE],
isnull(rt.total,0) as [TOT-TE],
isnull(rc.total,0) as [TOT-CO]
from Cliente c
left join
(
	select codcliente,count(numero) as total
	from Telefono
	where estado=1
	group by codcliente
) rt on c.codcliente=rt.codcliente
left join 
(
	select codcliente,count(codplan) as total
	from Contrato
	where estado=1
	group by codcliente
) rc on c.codcliente=rc.codcliente
where tipo='P'
order by [TOT-TE] asc,[TOT-CO]
