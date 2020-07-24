USE master --Usar la BD master (BD del Sistema)
go

-- select db_id('DevWifi14Ed') --Devuelve id de una BD

if db_id('DevWifi14Ed') is not null --Si existe una BD con nombre "DevWifi14Ed"
begin
	drop database DevWifi14Ed --Eliminar la BD con nombre "DevWifi14Ed"
end

create database DevWifi14Ed --Crear la BD con nombre "DevWifi14Ed" 
go

use DevWifi14Ed --Usar la BD con nombre "DevWifi14Ed" 
go

/*
 * ER/Studio 8.0 SQL Code Generation
 * Company :      DEV MASTER PERU
 * Project :      DEVWIFI_MODELO.DM1
 * Author :       gmanriquev
 *
 * Date Created : Thursday, July 23, 2020 21:14:57
 * Target DBMS : Microsoft SQL Server 2008
 */

/* 
 * TABLE: Cliente 
 */

CREATE TABLE Cliente(
    codcliente        int             IDENTITY(1,1),
    tipo              char(1)         NOT NULL,
    codtipo           int             NOT NULL,
    numdoc            varchar(16)     NOT NULL,
    direccion         varchar(150)    NOT NULL,
    codzona           int             NOT NULL,
    nombres           varchar(100)    NULL,
    ape_paterno       varchar(50)     NULL,
    ape_materno       varchar(50)     NULL,
    fec_nacimiento    date            NULL,
    sexo              char(1)         NULL,
    email             varchar(320)    NULL,
    razon_social      varchar(250)    NULL,
    fec_inicio        date            NULL,
    estado            bit             NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (codcliente)
)
go



IF OBJECT_ID('Cliente') IS NOT NULL
    PRINT '<<< CREATED TABLE Cliente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Cliente >>>'
go

/* 
 * TABLE: Contrato 
 */

CREATE TABLE Contrato(
    codcliente           int               NOT NULL,
    codplan              int               NOT NULL,
    fec_contrato         datetime          NOT NULL,
    fec_baja             datetime          NULL,
    periodo              char(1)           NOT NULL,
    precio               decimal(8, 2)     NOT NULL,
    ip_router            varchar(15)       NULL,
    ssis_red_wifi        varchar(50)       NULL,
    contrasena           varbinary(256)    NULL,
    fechora_registro     datetime          NOT NULL,
    fechora_actualiza    datetime          NULL,
    estado               char(1)           NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (codcliente, codplan)
)
go



IF OBJECT_ID('Contrato') IS NOT NULL
    PRINT '<<< CREATED TABLE Contrato >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Contrato >>>'
go

/* 
 * TABLE: PlanInternet 
 */

CREATE TABLE PlanInternet(
    codplan         int              IDENTITY(1,1),
    nombre          varchar(50)      NOT NULL,
    preciorefsol    decimal(8, 2)    NOT NULL,
    descripcion     varchar(100)     NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (codplan)
)
go



IF OBJECT_ID('PlanInternet') IS NOT NULL
    PRINT '<<< CREATED TABLE PlanInternet >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PlanInternet >>>'
go

/* 
 * TABLE: Telefono 
 */

CREATE TABLE Telefono(
    tipo          varchar(4)     NOT NULL,
    numero        varchar(25)    NOT NULL,
    estado        bit            NOT NULL,
    codcliente    int            NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (tipo, numero)
)
go



IF OBJECT_ID('Telefono') IS NOT NULL
    PRINT '<<< CREATED TABLE Telefono >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Telefono >>>'
go

/* 
 * TABLE: TipoDocumento 
 */

CREATE TABLE TipoDocumento(
    codtipo       int            IDENTITY(1,1),
    tipo_sunat    char(2)        NOT NULL,
    desc_larga    varchar(50)    NOT NULL,
    desc_corta    varchar(20)    NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (codtipo)
)
go



IF OBJECT_ID('TipoDocumento') IS NOT NULL
    PRINT '<<< CREATED TABLE TipoDocumento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TipoDocumento >>>'
go

/* 
 * TABLE: Ubigeo 
 */

CREATE TABLE Ubigeo(
    codubigeo      int            IDENTITY(1,1),
    cod_dpto       varchar(3)     NOT NULL,
    nombre_dpto    varchar(50)    NOT NULL,
    cod_prov       varchar(4)     NOT NULL,
    nombre_prov    varchar(50)    NOT NULL,
    cod_dto        varchar(4)     NOT NULL,
    nombre_dto     varchar(80)    NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (codubigeo)
)
go



IF OBJECT_ID('Ubigeo') IS NOT NULL
    PRINT '<<< CREATED TABLE Ubigeo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Ubigeo >>>'
go

/* 
 * TABLE: Zona 
 */

CREATE TABLE Zona(
    codzona      int            IDENTITY(1,1),
    codubigeo    int            NOT NULL,
    nombre       varchar(50)    NOT NULL,
    estado       bit            NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (codzona)
)
go



IF OBJECT_ID('Zona') IS NOT NULL
    PRINT '<<< CREATED TABLE Zona >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Zona >>>'
go

/* 
 * TABLE: Cliente 
 */

ALTER TABLE Cliente ADD CONSTRAINT RefZona42 
    FOREIGN KEY (codzona)
    REFERENCES Zona(codzona)
go

ALTER TABLE Cliente ADD CONSTRAINT RefTipoDocumento52 
    FOREIGN KEY (codtipo)
    REFERENCES TipoDocumento(codtipo)
go


/* 
 * TABLE: Contrato 
 */

ALTER TABLE Contrato ADD CONSTRAINT RefCliente72 
    FOREIGN KEY (codcliente)
    REFERENCES Cliente(codcliente)
go

ALTER TABLE Contrato ADD CONSTRAINT RefPlanInternet82 
    FOREIGN KEY (codplan)
    REFERENCES PlanInternet(codplan)
go


/* 
 * TABLE: Telefono 
 */

ALTER TABLE Telefono ADD CONSTRAINT RefCliente62 
    FOREIGN KEY (codcliente)
    REFERENCES Cliente(codcliente)
go


/* 
 * TABLE: Zona 
 */

ALTER TABLE Zona ADD CONSTRAINT RefUbigeo32 
    FOREIGN KEY (codubigeo)
    REFERENCES Ubigeo(codubigeo)
go


