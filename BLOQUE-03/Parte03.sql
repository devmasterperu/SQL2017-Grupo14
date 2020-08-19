--03.08
select getdate()--Fecha y Hora del servidor.

select  t.tipo as TIPO,
        t.numero as NUMERO,
		case when c.tipo='E' then isnull(c.razon_social,'SIN_DETALLE')
			 when c.tipo='P' then isnull(c.nombres+' '+c.ape_paterno+' '+c.ape_materno,'SIN_DETALLE')
			 else 'SIN_DETALLE' 
		end  as CLIENTE,
		isnull(c.email,'SIN DETALLE') as EMAIL,
		convert(varchar(8),getdate(),112) as FEC_CONSULTA,
		t.codcliente,c.codcliente
from Telefono t
left join Cliente c on t.codcliente=c.codcliente
where t.estado=1--teléfonos en estado 'activo' de todos los clientes
order by c.email desc
