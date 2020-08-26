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