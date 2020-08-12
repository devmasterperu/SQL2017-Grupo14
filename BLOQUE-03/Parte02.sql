
--03.02

select concat('Z',z.codzona) as CODZONA,z.nombre as ZONA,z.estado as ESTADO,
concat(u.cod_dpto,u.cod_prov,u.cod_dto) as UBIGEO,
'La Zona '+z.nombre+' del ubigeo '+concat(u.cod_dpto,u.cod_prov,u.cod_dto)+' se encuentra '+
case when estado=1 then 'ACTIVA' 
     when estado=0 then 'INACTIVA'
	 else 'ESTADO DESCONOCIDO'
end as MENSAJE
from Zona as z
inner join Ubigeo as u on z.codubigeo=u.codubigeo

--03.04

select top(100) t.desc_corta as TIPO_DOC,c.numdoc as NUM_DOC,
nombres+' '+ape_paterno+' '+ape_materno as [NOMBRE COMPLETO],
c.fec_nacimiento as FECHA_NAC,c.direccion as DIRECCION,
z.nombre as ZONA
from Cliente as c
inner join TipoDocumento as t on c.codtipo=t.codtipo
inner join Zona as z on c.codzona=z.codzona
where tipo='P' and c.estado=1
order by nombres+' '+ape_paterno+' '+ape_materno asc

--03.06

select t.tipo as TIPO,t.numero as NUMERO,t.codcliente as COD_CLIENTE,c.razon_social as EMPRESA,
z.nombre as ZONA
from Telefono t 
inner join Cliente c on t.codcliente=c.codcliente
inner join Zona z on c.codzona=z.codzona
where t.estado=1 and c.tipo='E'--teléfonos en estado 'activo' de los clientes empresa
order by c.codcliente asc

