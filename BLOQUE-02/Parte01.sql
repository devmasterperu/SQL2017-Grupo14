--BLOQUE_02

declare @num1 int=10 --Declarar variable @num1 del tipo entero y valor 10
declare @num2 int=5

select @num1+@num2 as SUMA,
       @num1-@num2 as RESTA,
	   @num1*@num2 as MULTIPLICA,
	   @num1/@num2 as DIVISION,
	   @num1%@num2 as MODULO,
	   power(@num1,@num2) as POTENCIA

declare @texto1 varchar(10)='DEV'
declare @texto2 varchar(10)='MASTER'

select @texto1+' '+@texto2 as TEXTO