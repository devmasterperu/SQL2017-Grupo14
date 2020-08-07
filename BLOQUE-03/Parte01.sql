--BLOQUE 03

--03.01.a
--LADO_IZQUIERDO
select codcliente from Cliente --1000
--LADO_DERECHO
select codplan from PlanInternet --5
--COMBINACIONES_POSIBLES
select codcliente,codplan from Cliente cross join PlanInternet --5000

--03.01.b
--LADO_IZQUIERDO
select codcliente from Cliente where tipo='E'--400
--LADO_DERECHO
select codplan from PlanInternet --5
--COMBINACIONES_POSIBLES
select codcliente,codplan
from Cliente cross join PlanInternet
where tipo='E'--2000

--03.02

select * from Zona
select * from Ubigeo