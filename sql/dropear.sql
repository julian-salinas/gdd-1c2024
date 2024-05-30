USE GD1C2024
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID(N'[EL_DROPEO].[MIGRACION]'))
DROP PROCEDURE EL_DROPEO.MIGRACION
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID(N'[EL_DROPEO].[MIGRACION]'))
DROP PROCEDURE EL_DROPEO.MIGRAR_SUPERMERCADOS
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'EL_DROPEO')
DROP SCHEMA EL_DROPEO
GO

-- DROP TABLAS

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Provincia') AND type in (N'U'))
DROP TABLE EL_DROPEO.Provincia
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Localidad') AND type in (N'U'))
DROP TABLE EL_DROPEO.Localidad
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Ubicacion') AND type in (N'U'))
DROP TABLE EL_DROPEO.Ubicacion
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Supermercado') AND type in (N'U'))
DROP TABLE EL_DROPEO.Supermercado
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Sucursal') AND type in (N'U'))
DROP TABLE EL_DROPEO.Sucursal
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Tipo_Caja') AND type in (N'U'))
DROP TABLE EL_DROPEO.Tipo_Caja
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Caja') AND type in (N'U'))
DROP TABLE EL_DROPEO.Caja
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Cliente') AND type in (N'U'))
DROP TABLE EL_DROPEO.Cliente
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Comprobante') AND type in (N'U'))
DROP TABLE EL_DROPEO.Comprobante
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Empleado') AND type in (N'U'))
DROP TABLE EL_DROPEO.Empleado
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Ventas') AND type in (N'U'))
DROP TABLE EL_DROPEO.Ventas
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Medio_De_Pago') AND type in (N'U'))
DROP TABLE EL_DROPEO.Medio_De_Pago
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Detalle') AND type in (N'U'))
DROP TABLE EL_DROPEO.Detalle
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Pagos') AND type in (N'U'))
DROP TABLE EL_DROPEO.Pagos
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Descuentos') AND type in (N'U'))
DROP TABLE EL_DROPEO.Descuentos
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Marca') AND type in (N'U'))
DROP TABLE EL_DROPEO.Marca
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Categoria') AND type in (N'U'))
DROP TABLE EL_DROPEO.Categoria
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Sub_Categoria') AND type in (N'U'))
DROP TABLE EL_DROPEO.Sub_Categoria
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Producto') AND type in (N'U'))
DROP TABLE EL_DROPEO.Producto
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Item') AND type in (N'U'))
DROP TABLE EL_DROPEO.Item
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Promocion') AND type in (N'U'))
DROP TABLE EL_DROPEO.Promocion
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Regla') AND type in (N'U'))
DROP TABLE EL_DROPEO.Regla
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Promocion_Producto') AND type in (N'U'))
DROP TABLE EL_DROPEO.Promocion_Producto
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Condicion_Fiscal') AND type in (N'U'))
DROP TABLE EL_DROPEO.Condicion_Fiscal
GO

EXEC EL_DROPEO.CREAR_TABLAS
GO