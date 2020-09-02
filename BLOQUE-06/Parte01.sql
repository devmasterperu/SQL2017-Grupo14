--06.01

--SUBCONSULTAS_FROM

select co.codplan as CODPLAN,co.codcliente as CODCLIENTE,co.precio as PRECIO,rc.PRE_SUM,
rc.PRE_PROM,rc.PRE_TOT,rc.PRE_MIN,rc.PRE_MAX
from Contrato co
left join
(
select codplan, sum(precio) as PRE_SUM,avg(precio) as PRE_PROM,count(codcliente) as PRE_TOT,
min(precio) as PRE_MIN,max(precio) as PRE_MAX
from Contrato
group by codplan
) rc on co.codplan=rc.codplan
order by CODPLAN asc,PRECIO asc

--OVER+FUNCIONES_AGRUPAMIENTO

select co.codplan as CODPLAN,co.codcliente as CODCLIENTE,co.precio as PRECIO,
sum(precio) over(partition by codplan) as PRE_SUM,
avg(precio) over(partition by codplan) as PRE_PROM,
count(codcliente) over(partition by codplan) as PRE_TOT,
min(precio) over(partition by codplan) as PRE_MIN,
max(precio) over(partition by codplan) as PRE_MAX
from Contrato co
order by CODPLAN asc,PRECIO asc

--VISTAS
create view V_CONTRATO as
select co.codplan as CODPLAN,co.codcliente as CODCLIENTE,co.precio as PRECIO,
sum(precio) over(partition by codplan) as PRE_SUM,
avg(precio) over(partition by codplan) as PRE_PROM,
count(codcliente) over(partition by codplan) as PRE_TOT,
min(precio) over(partition by codplan) as PRE_MIN,
max(precio) over(partition by codplan) as PRE_MAX
from Contrato co

select * from V_CONTRATO
order by CODPLAN asc,PRECIO asc

--06.03

select codcliente as CODIGO,razon_social as EMPRESA,fec_inicio as FEC_INICIO,
row_number() over(order by fec_inicio asc) as RN, --APLICA TODA LA CONSULTA
rank() over(order by fec_inicio asc) as RK, --APLICA TODA LA CONSULTA
dense_rank() over(order by fec_inicio asc) as DRK, --APLICA TODA LA CONSULTA
ntile(5) over(order by fec_inicio asc) as N5 --APLICA TODA LA CONSULTA
from Cliente
where tipo='E'
order by fec_inicio asc

--FUNCION_VALOR_TABLA
create function F_CLIENTE_E() returns table as
return 
	select codcliente as CODIGO,razon_social as EMPRESA,fec_inicio as FEC_INICIO,
	row_number() over(order by fec_inicio asc) as RN, --APLICA TODA LA CONSULTA
	rank() over(order by fec_inicio asc) as RK, --APLICA TODA LA CONSULTA
	dense_rank() over(order by fec_inicio asc) as DRK, --APLICA TODA LA CONSULTA
	ntile(5) over(order by fec_inicio asc) as N5 --APLICA TODA LA CONSULTA
	from Cliente
	where tipo='E'

select * from F_CLIENTE_E()
order by fec_inicio asc

--06.05
--TABLAS_DERIVADAS
select c.codcliente as CODIGO,
concat(c.nombres,' ',c.ape_paterno,' ',c.ape_materno) as CLIENTE, 
codzona as ZONA,
isnull(rt.total,0) as N_TEL,
row_number() over(partition by codzona order by rt.total asc) as R1,
rank() over(partition by codzona order by rt.total asc) as R2,
dense_rank() over(partition by codzona order by rt.total asc) as R3,
ntile(4) over(partition by codzona order by rt.total asc) as R4
from Cliente c
left join (
	select codcliente,count(numero) as total
	from Telefono
	group by codcliente
) rt on c.codcliente=rt.codcliente
where tipo='P'
order by codzona,rt.total asc

--CTES
WITH CTE_RT AS
(
	select codcliente,count(numero) as total
	from Telefono
	group by codcliente
) 
select c.codcliente as CODIGO,
concat(c.nombres,' ',c.ape_paterno,' ',c.ape_materno) as CLIENTE, 
codzona as ZONA,
isnull(rt.total,0) as N_TEL,
row_number() over(partition by codzona order by rt.total asc) as R1,
rank() over(partition by codzona order by rt.total asc) as R2,
dense_rank() over(partition by codzona order by rt.total asc) as R3,
ntile(4) over(partition by codzona order by rt.total asc) as R4
from Cliente c
left join CTE_RT rt on c.codcliente=rt.codcliente
where tipo='P'
order by codzona,rt.total asc