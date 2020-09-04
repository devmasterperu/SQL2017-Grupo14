--07.01
--Procedimiento_almacenado
--declare @n1 int=5
--declare @n2 int=7
create procedure usp_Polinomio(@n1 int,@n2 int)
as
begin
  select 'F(N1,N2)'=power(@n1,2)+10*@n1*@n2+power(@n2,2)
end

exec usp_Polinomio 5,7
execute usp_Polinomio 5,7
execute usp_Polinomio @n1=5,@n2=7
execute [DevWifi14Ed].dbo.usp_Polinomio @n1=5,@n2=7

--Generado por SSMS
DECLARE	@return_value int

EXEC	@return_value = [dbo].[usp_Polinomio]
		@n1 = 10,
		@n2 = 10

SELECT	'Return Value' = @return_value

GO

--FUNCION_ESCALAR

create function f_Polinomio(@n1 int,@n2 int) returns int
alter function f_Polinomio(@n1 int,@n2 int) returns int
as
begin
  return (select power(@n1,2)+10*@n1*@n2+power(@n2,2))
end

alter function f_Polinomio(@n1 int,@n2 int) returns int
as
begin
  declare @resultado int=(select power(@n1,2)+10*@n1*@n2+power(@n2,2))
  /*OTRAS_INSTRUCCIONES*/
  return @resultado
end

select dbo.f_Polinomio(5,7) as [F(N1,N2)]

--FUNCION_ESCALAR_TABLA

select codcliente,codplan,dbo.f_Polinomio(codcliente,codplan) as score
from Contrato

--07.03

create procedure USP_REPORTE_TEL(@tipo varchar(4),@mensaje varchar(1000))
as
begin
	--select * from Telefono where tipo='SMS' and estado=1
	--select * from Telefono where tipo='LLA' and estado=1
	--select * from Telefono where tipo='WSP' and estado=1
	--declare @tipo varchar(4)='LLA'
	select tipo as TIPO,numero as TELEFONO,@mensaje as MENSAJE
	from Telefono where tipo=@tipo and estado=1
end

EXECUTE USP_REPORTE_TEL @tipo= 'LLA', @mensaje= 'Hola, no
olvide realizar el pago de su servicio de Internet'

EXECUTE USP_REPORTE_TEL @tipo= 'SMS', @mensaje= 'Hola,
muchas gracias por su preferencia. Tenemos excelentes promociones para usted'

EXECUTE USP_REPORTE_TEL @tipo= 'WSP', @mensaje= 'Hola,
hasta el 15/09 recibe un 40% de descuento en tu facturación'

EXECUTE USP_REPORTE_TEL @tipo= 'WSP2', @mensaje= 'Hola,
hasta el 15/10 recibe un 40% de descuento en tu facturación'

create procedure USP_REPORTE_TEL_2(@tipo varchar(4))
as
begin
    declare @mensaje varchar(1000)='Mensaje genérico' --OBTENERLO_DESDE_TABLA
	select tipo as TIPO,numero as TELEFONO,@mensaje as MENSAJE
	from Telefono where tipo=@tipo and estado=1
end

EXECUTE USP_REPORTE_TEL_2 @tipo= 'LLA'

--07.05

--Crear tabla Configuración (Guardar parámetros)

create table dbo.Configuracion
(
codconfiguracion int identity(1,1) primary key,
variable varchar(400)  not null,
valor    varchar(1000) not null
)

insert into dbo.Configuracion(variable,valor)
values ('RAZON_SOCIAL_DEVWIFI','DEV MASTER PERÚ SAC')

insert into dbo.Configuracion(variable,valor)
values ('RUC_DEVWIFI','20602275320')

select variable,valor from dbo.Configuracion

create procedure usp_selCliente(@idcliente int) as
begin
		--declare @idcliente int=2000
		
		if exists(select numdoc from Cliente where codcliente=@idcliente)--SI EXISTE CLIENTE
		begin
		
			select 'RAZON_SOCIAL_DEVWIFI'=(select valor from Configuracion where variable='RAZON_SOCIAL_DEVWIFI'),
			       'RUC_DEVWIFI'=(select valor from Configuracion where variable='RUC_DEVWIFI'),--20602275320
				   'Consulta al:'=getdate(),
				   'Cliente:'= case when tipo='P' then concat(nombres,' ',ape_paterno,' ',ape_materno)
									when tipo='E' then razon_social
									else 'SIN DETALLE'
								end,
					'Dirección:'=direccion,
					'Zona:'=isnull(z.nombre,'SIN DETALLE')
			from    Cliente c
			left join Zona z on c.codzona=z.codzona
			where   codcliente=@idcliente

		end
		else
		begin
			
			select 'El cliente no ha sido encontrado en la Base de Datos' as mensaje
		end

end

--RAZON_SOCIAL_DEVWIFI	RUC_DEVWIFI	Consulta al:	      Cliente:	Dirección:	                Zona:
--DEV MASTER PERÚ SAC	20602275320	2020-09-03 20:43:14.370	EMPRESA 100	URB. LOS CIPRESES M-24	AMBAR-I
execute usp_selCliente @idcliente=100

--RAZON_SOCIAL_DEVWIFI	RUC_DEVWIFI	Consulta al:	        Cliente:	                Dirección:	                Zona:
--DEV MASTER PERÚ SAC	20602275320	2020-09-03 20:43:46.697	SONIA DE  LA TORRE CANALES	AV. AV. CIRCUNVALACION S\N	HUACHO-IV
execute usp_selCliente @idcliente=600

--mensaje
--El cliente no ha sido encontrado en la Base de Datos
execute usp_selCliente @idcliente=2000

--RAZON_SOCIAL_DEVWIFI	                RUC_DEVWIFI	Consulta al:	        Cliente:	                Dirección:	                Zona:
--DEV MASTER PERÚ INTERNTATIONAL EIRL 	20602275320	2020-09-03 20:45:55.297	SONIA DE  LA TORRE CANALES	AV. AV. CIRCUNVALACION S\N	HUACHO-IV
execute usp_selCliente @idcliente=600

--07.06

create procedure usp_InsUbigeo
(
@cod_dpto varchar(3),
@nom_dpto varchar(50),
@cod_prov varchar(4),
@nom_prov varchar(50),
@cod_dto  varchar(4),
@nom_dto  varchar(80)
) as
begin

	if not exists(select codubigeo from Ubigeo where cod_dpto=@cod_dpto and 
	              cod_prov=@cod_prov and cod_dto=@cod_dto)--NO EXISTA UBIGEO
	begin
		insert into Ubigeo(cod_dpto,nombre_dpto,cod_prov,nombre_prov,cod_dto,nombre_dto)
		            values(@cod_dpto,@nom_dpto,@cod_prov,@nom_prov,@cod_dto,@nom_dto)

		select 'Ubigeo insertado' as mensaje,IDENT_CURRENT('dbo.Ubigeo') as codubigeo
	end
	else --SI EXISTA UBIGEO
	begin
		select 'Ubigeo existente' as mensaje,0 as codubigeo
	end
end

execute usp_InsUbigeo @nom_prov='CORONEL PORTILLO',@cod_dto='01',@nom_dto='CALLERIA',
					  @cod_dpto='25',@nom_dpto='UCAYALI',@cod_prov='01' --1° VEZ=>OK

select * from Ubigeo where codubigeo=18

execute usp_InsUbigeo @nom_prov='CORONEL PORTILLO',@cod_dto='01',@nom_dto='CALLERIA',
					  @cod_dpto='25',@nom_dpto='UCAYALI',@cod_prov='01' --2° VEZ=>NO_OK

--07.08

create procedure usp_ActualizaClienteE(
@codcliente int, --Identificador
--Valores_cambio
@codtipo int,@numdoc varchar(16),
@razon_social varchar(250),@fecinicio date,@email varchar(320),
@direccion varchar(150),@codzona int,@estado bit)
as
begin
	if exists(select numdoc from Cliente where codcliente=@codcliente and tipo='E') --SI EXISTE CLIENTE Y ES EMPRESA.
	begin
		--begin tran
			update c
			set  c.codtipo=@codtipo,c.numdoc=@numdoc,c.razon_social=@razon_social,c.fec_inicio=@fecinicio,
				 c.email=@email,c.direccion=@direccion,c.codzona=@codzona,estado=@estado
			from Cliente c
			where c.codcliente=@codcliente
		--rollback
			select 'Cliente empresa actualizado' as mensaje,@codcliente as codcliente
	end
	else
	begin
		select 'No es posible identificar al cliente empresa a actualizar' as mensaje,@codcliente as codcliente
	end
end

select top 1 * from Cliente where tipo='E'

execute usp_ActualizaClienteE @codcliente=1,@codtipo=3,@numdoc='89918073990',@razon_social='DEV MASTER PERÚ',
@fecinicio='2017-08-05',@email='info@devmaster.pe',@direccion='AV. BRASIL 900',@codzona=11,@estado=0 --OK

select top 1 * from Cliente where tipo='P'

execute usp_ActualizaClienteE @codcliente=401,@codtipo=3,@numdoc='89918073990',@razon_social='DEV MASTER PERÚ',
@fecinicio='2017-08-05',@email='info@devmaster.pe',@direccion='AV. BRASIL 900',@codzona=11,@estado=0 --NO_OK

--07.10

create procedure usp_EliminaTelefono(@tipo varchar(4),@numero varchar(25))
as
begin
	--Validar teléfono existe por tipo y número
	if exists(select codcliente from Telefono where tipo=@tipo and numero=@numero)
	begin
		delete from Telefono
		where tipo=@tipo and numero=@numero 

		select 'Teléfono eliminado' as mensaje,@tipo as tipo,@numero as numero
	end
	else
	begin
		select 'No es posible identificar al teléfono a eliminar' as mensaje,'TTT' as tipo,
		       '999999999' as numero
	end
end

select top 100 * from Telefono
execute usp_EliminaTelefono @tipo='LLA',@numero='915703551'

select  * from Telefono where tipo='LLA' and numero='915703551' --OK

execute usp_EliminaTelefono @tipo='SMS2',@numero='915703551'