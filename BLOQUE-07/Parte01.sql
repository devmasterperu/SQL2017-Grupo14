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