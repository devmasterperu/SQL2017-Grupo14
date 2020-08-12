
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