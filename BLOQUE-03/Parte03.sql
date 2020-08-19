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
isnull(cod_dpto+cod_prov+cod_dto,'SIN DATO') as UBIGEO,
isnull(nombre_dpto,'SIN DATO') as DPTO,
isnull(nombre_prov,'SIN DATO') as PROV,
isnull(nombre_dto,'SIN DATO') as DTO
--ALTER TABLE [dbo].[Zona]  WITH NOCHECK ADD  CONSTRAINT [RefUbigeo32] FOREIGN KEY([codubigeo])
--REFERENCES [dbo].[Ubigeo] ([codubigeo])
from Zona z left join Ubigeo u on z.codubigeo=u.codubigeo
where z.estado=1--zonas en estado 'activo'
order by z.codzona desc

--03.10
--ALTER TABLE [dbo].[Contrato]  WITH NOCHECK ADD  CONSTRAINT [RefPlanInternet82] FOREIGN KEY([codplan])
--REFERENCES [dbo].[PlanInternet] ([codplan])

--LEFT JOIN
select co.codcliente as [CODIGO CLIENTE],isnull(p.nombre,'SIN DATO') as [NOMBRE PLAN],
isnull(p.preciorefsol,0.00) as [PRECIO PLAN],
co.precio as [PRECIO CONTRATO],co.fec_contrato as [FECHA CONTRATO],co.codplan,p.codplan
from Contrato co left join PlanInternet p on co.codplan=p.codplan
order by isnull(p.codplan,0)

--RIGHT JOIN
select co.codcliente as [CODIGO CLIENTE],isnull(p.nombre,'SIN DATO') as [NOMBRE PLAN],
isnull(p.preciorefsol,0.00) as [PRECIO PLAN],
co.precio as [PRECIO CONTRATO],co.fec_contrato as [FECHA CONTRATO],co.codplan,p.codplan
from PlanInternet p right join Contrato co on co.codplan=p.codplan
order by isnull(p.codplan,0)

--03.12
--ALTER TABLE [dbo].[Contrato]  WITH NOCHECK ADD  CONSTRAINT [RefCliente72] FOREIGN KEY([codcliente])
--REFERENCES [dbo].[Cliente] ([codcliente])

select  *
from 
--mostrarse los clientes independientemente de contar o no con contratos relacionados y 
--los contratos, independientemente de contar o no con clientes relacionados
Cliente c full join Contrato co on c.codcliente=co.codcliente
--mostrarse los contratos independientemente de contar con plan de internet relacionado.
left join PlanInternet p on co.codplan=p.codplan 
order by isnull(co.codcliente,0) asc