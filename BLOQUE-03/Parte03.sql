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

--03.09
--Identificar tablas: Zona, Ubigeo
--Identificar campo de cruce: codubigeo
--Identiticar tipo de join: LEFT JOIN
--Dar formato a las columnas

select z.nombre as ZONA,isnull(u.codubigeo,0) as CODUBIGEO,
isnull(cod_dpto+cod_prov+cod_dpto,'SIN DATO') as UBIGEO,
isnull(nombre_dpto,'SIN DATO') as DPTO,
isnull(nombre_prov,'SIN DATO') as PROV,
isnull(nombre_dto,'SIN DATO') as DTO
from Zona z left join Ubigeo u on z.codubigeo=u.codubigeo
where z.estado=1--zonas en estado 'activo'
order by z.codzona desc
