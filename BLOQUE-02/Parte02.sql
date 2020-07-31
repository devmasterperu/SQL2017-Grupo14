--02.00
--a
declare @T1 int =10
declare @N  int =8
declare @razon int=5

select @T1+(@N-1)*@razon AS RESULTADO_TN

--b
DECLARE @_T1 bigint =1
DECLARE @_R bigint = 2
DECLARE @_N1 bigint =50

--- FÓRMULA: TN=L1*R ^(Q-1)----
SELECT POWER(@_R,@_N1-1) AS POTENCIA
SELECT @_T1* POWER(@_R,@_N1-1) AS RESULTADO_TN

--Elementos de la clausula SELECT
select * from Zona

select codubigeo, count(codzona) as total --(V)
from Zona --(I)
where estado=1 --(II)
group by codubigeo --(III)
having count(codzona)>=3 --(IV)
order by total asc --(VI)

--Uso alias columnas
select cod_dpto+'-'+cod_prov+'-'+cod_dto ubigeo_1, 
       cod_dpto+'-'+cod_prov+'-'+cod_dto as ubigeo_2,
	   'ubigeo_3'=cod_dpto+'-'+cod_prov+'-'+cod_dto,
	   cod_dpto+'-'+cod_prov+'-'+cod_dto as [ubigeo-4]
from   Ubigeo

--Uso alias tabla
select u.cod_dpto+'-'+u.cod_prov+'-'+u.cod_dto ubigeo_1, 
       cod_dpto+'-'+cod_prov+'-'+cod_dto as ubigeo_2,
	   'ubigeo_3'=cod_dpto+'-'+cod_prov+'-'+cod_dto,
	   cod_dpto+'-'+cod_prov+'-'+cod_dto as [ubigeo-4]
from   dbo.Ubigeo as u
--from   Ubigeo as u
--from   Ubigeo u

--Expresiones CASE

--02.01
--a.Los diferentes departamentos a nivel de ubigeo
select nombre_dpto from Ubigeo
select distinct nombre_dpto from Ubigeo

--b.Los diferentes códigos de ubigeo a nivel de zona
select codubigeo from Zona
select distinct codubigeo from Zona

--c.Las diferentes combinaciones de departamento+provincia a nivel de ubigeo
select nombre_dpto,nombre_prov from Ubigeo
select distinct nombre_dpto,nombre_prov from Ubigeo

--02.02

--ZONA|CODIGO UBIGEO|ESTADO|MENSAJE ESTADO

select nombre as ZONA,codubigeo as [CODIGO UBIGEO], 
estado as ESTADO,  
case when estado=1 then 'Zona activa'
	 when estado=0 then 'Zona inactiva'
	 else 'Sin dato' 
end as [MENSAJE ESTADO]
from Zona --Zonas
where codubigeo=1  --Con codigo de ubigeo [1]

select codplan,nombre,preciorefsol,
case when preciorefsol<=70 then 'Plan de valor bajo'
     when preciorefsol>70 and preciorefsol<100 then 'Plan de valor medio'
	 when preciorefsol>=100 then 'Plan de valor alto'
	 else 'Sin mensaje' 
end as Mensaje
from PlanInternet