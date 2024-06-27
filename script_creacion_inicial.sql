USE GD1C2024
GO

/*
Eliminar datos existentes
*/
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID(N'[EL_DROPEO].[CREAR_TABLAS]'))
    DROP PROCEDURE EL_DROPEO.CREAR_TABLAS
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID(N'[EL_DROPEO].[MIGRACION]'))
    DROP PROCEDURE EL_DROPEO.MIGRACION
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Envios') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Envios
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Estados_Envio') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Estados_Envio
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Promocion_Item') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Promocion_Item
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Items') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Items
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Promocion_Producto') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Promocion_Producto
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Regla') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Regla
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Promocion') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Promocion
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Producto') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Producto
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Sub_Categorias') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Sub_Categorias
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Categorias') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Categorias
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Marcas') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Marcas
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Descuentos_Pagos') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Descuentos_Pagos
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Descuentos') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Descuentos
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Pagos') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Pagos
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Detalles') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Detalles
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Medio_De_Pago') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Medio_De_Pago
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Venta') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Venta
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Empleados') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Empleados
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Comprobantes') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Comprobantes
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Clientes') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Clientes
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Cajas') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Cajas
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Tipo_Caja') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Tipo_Caja
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Sucursal') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Sucursal
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Supermercado') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Supermercado
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Ubicacion') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Ubicacion
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Localidades') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Localidades
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Provincia') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Provincia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Condiciones_Fiscales') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Condiciones_Fiscales
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'EL_DROPEO')
    DROP SCHEMA EL_DROPEO
GO

/*
Crear schema y tablas
*/
CREATE SCHEMA EL_DROPEO
GO

CREATE PROCEDURE EL_DROPEO.CREAR_TABLAS AS BEGIN

/*
 Creación de tablas
*/

CREATE TABLE EL_DROPEO.Provincia(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Localidades(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	provincia_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Provincia
)

CREATE TABLE EL_DROPEO.Ubicacion(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	calle NVARCHAR(255) NOT NULL,
	altura INT NOT NULL,
	localidad_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Localidades
)

CREATE TABLE EL_DROPEO.Condiciones_Fiscales(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Supermercado(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	razon_social NVARCHAR(255) NOT NULL,
	cuit NVARCHAR(255) NOT NULL UNIQUE,
	iibb INT NOT NULL,
	ubicacion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ubicacion,
	fecha_inicio DATETIME NOT NULL,
	condicion_fiscal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Condiciones_Fiscales
)

CREATE TABLE EL_DROPEO.Sucursal(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	ubicacion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ubicacion,
	supermercado_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Supermercado
)

CREATE TABLE EL_DROPEO.Tipo_Caja(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
)

CREATE TABLE EL_DROPEO.Cajas(
	numero INT NOT NULL,
	tipo_caja_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Tipo_Caja,
	sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sucursal,
	PRIMARY KEY(numero, sucursal_id)
)

CREATE TABLE EL_DROPEO.Clientes(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,	
	apellido NVARCHAR(255) NOT NULL,
	dni INT NOT NULL UNIQUE,
	fecha_registro DATETIME,
	telefono INT,
	mail NVARCHAR(255),
	fecha_nacimiento DATE,
	ubicacion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ubicacion
)

CREATE TABLE EL_DROPEO.Comprobantes(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_comprobante NVARCHAR(255) NOT NULL,
)

CREATE TABLE EL_DROPEO.Empleados(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255),
	apellido NVARCHAR(255),
	dni INT NOT NULL UNIQUE,
	fecha_registro DATETIME,
	telefono INT,
	mail NVARCHAR(255),
	fecha_nacimiento DATE,
    sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sucursal
)

CREATE TABLE EL_DROPEO.Venta(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	numero_ticket INT NOT NULL,
	fecha_hora DATETIME NOT NULL,
	comprobante_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Comprobantes,
	empleado_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Empleados,
	caja_numero INT NOT NULL,
	caja_sucursal_id INT NOT NULL,
	FOREIGN KEY (caja_numero, caja_sucursal_id) REFERENCES EL_DROPEO.Cajas(numero, sucursal_id)
)


CREATE TABLE EL_DROPEO.Medio_De_Pago(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	tipo_pago NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Detalles(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cliente_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Clientes,
	numero_tarjeta NVARCHAR(255),
	vencimiento_tarjeta DATE,
	cuotas INT
)

CREATE TABLE EL_DROPEO.Pagos(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha DATETIME NOT NULL,
	importe DECIMAL(18, 2) NOT NULL,
	venta_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Venta,
	medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Medio_De_Pago,
	detalle_id INT FOREIGN KEY REFERENCES EL_DROPEO.Detalles
    -- descuento_aplicado DECIMAL(18, 2)
)

CREATE TABLE EL_DROPEO.Descuentos(
	codigo INT NOT NULL PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	monto DECIMAL(18, 2) NOT NULL,
	tope DECIMAL(18, 2) NOT NULL,
	medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Medio_De_Pago
)

CREATE TABLE EL_DROPEO.Descuentos_Pagos(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    descuento_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Descuentos,
    pago_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Pagos,
    descuento_aplicado DECIMAL(18, 2) NOT NULL
)

CREATE TABLE EL_DROPEO.Marcas(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Categorias(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Sub_Categorias(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Categorias,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Producto(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	descripcion NVARCHAR(255) NOT NULL,
	precio DECIMAL(18, 2) NOT NULL,
	marca_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Marcas,
	sub_categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sub_Categorias
)

CREATE TABLE EL_DROPEO.Items(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Venta,
	producto_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Producto,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(18, 2) NOT NULL
)

--INSERT INTO EL_DROPEO.Items (venta_id, producto_id, cantidad, precio_unitario)
--SELECT DISTINCT
--    V.id AS venta_id,
--    P.id AS producto_id,
--    TICKET_DET_CANTIDAD,
--    TICKET_DET_PRECIO
--FROM gd_esquema.Maestra
--LEFT JOIN EL_DROPEO.Venta V ON V.numero_ticket = TICKET_NUMERO
--LEFT JOIN EL_DROPEO.Marcas M ON M.id = P.marca_id
--LEFT JOIN (
--    SELECT id, marca_id, sub_categoria_id, nombre
--    FROM EL_DROPEO.Producto Product
--    LEFT JOIN EL_DROPEO.Marcas M ON M.id = Product.marca_id
--    LEFT JOIN EL_DROPEO.Sub_Categoria S ON S.id = Product.sub_categoria_id
--) P ON PRODUCTO_NOMBRE = P.nombre AND PRODUCTO_MARCA = M.nombre AND PRODUCTO_SUB_CATEGORIA = S.nombre
--WHERE TICKET_DET_CANTIDAD IS NOT NULL AND TICKET_DET_PRECIO IS NOT NULL

CREATE TABLE EL_DROPEO.Promocion(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
)

CREATE TABLE EL_DROPEO.Promocion_Item(
    promocion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Promocion,
    item_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Items,
    promocion_aplicada_descuento DECIMAL(18, 2) NOT NULL,
    PRIMARY KEY(promocion_id, item_id)
)

CREATE TABLE EL_DROPEO.Regla(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	cantidad_aplicable_descuento DECIMAL(18, 2) NOT NULL,
	cantidad_aplicable_regla INT NOT NULL,
	cantidad_maxima INT NOT NULL,
	misma_marca BIT NOT NULL,
	mismo_producto BIT NOT NULL,
	promocion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Promocion
)

CREATE TABLE EL_DROPEO.Promocion_Producto(
	promocion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Promocion,
	producto_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Producto,
	PRIMARY KEY(promocion_id, producto_id)
)

CREATE TABLE EL_DROPEO.Estados_Envio(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Envios(
	costo DECIMAL(18, 2) NOT NULL,
	fecha_programada DATETIME NOT NULL,
	hora_inicio DECIMAL(18, 2) NOT NULL,
	hora_fin DECIMAL(18, 2) NOT NULL,
	fecha_entrega DATETIME,
	estado_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Estados_Envio,
	venta_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Venta
    
)

END

GO

CREATE PROCEDURE EL_DROPEO.MIGRACION AS
BEGIN

INSERT INTO EL_DROPEO.Provincia (nombre)
SELECT nombre
FROM (
    SELECT CLIENTE_PROVINCIA AS nombre FROM gd_esquema.Maestra
    UNION
    SELECT SUCURSAL_PROVINCIA AS nombre FROM gd_esquema.Maestra
    UNION
    SELECT SUPER_PROVINCIA AS nombre FROM gd_esquema.Maestra
) provincias
WHERE nombre IS NOT NULL

INSERT INTO EL_DROPEO.Localidades (nombre, provincia_id)
SELECT localidades.nombre, p.id
FROM (
    SELECT CLIENTE_LOCALIDAD AS nombre, CLIENTE_PROVINCIA AS provincia FROM gd_esquema.Maestra WHERE CLIENTE_LOCALIDAD IS NOT NULL
    UNION
    SELECT SUCURSAL_LOCALIDAD AS nombre, SUCURSAL_PROVINCIA AS provincia FROM gd_esquema.Maestra WHERE SUCURSAL_LOCALIDAD IS NOT NULL
    UNION
    SELECT SUPER_LOCALIDAD AS nombre, SUPER_PROVINCIA AS provincia FROM gd_esquema.Maestra WHERE SUPER_LOCALIDAD IS NOT NULL
) localidades
INNER JOIN EL_DROPEO.Provincia p ON localidades.provincia = p.nombre;

INSERT INTO EL_DROPEO.Ubicacion (calle, altura, localidad_id)
SELECT 
    LEFT(direccion, LEN(direccion) - CHARINDEX(' ', REVERSE(direccion))) AS calle,
    CAST(RIGHT(direccion, CHARINDEX(' ', REVERSE(direccion)) - 1) AS INT) AS altura,
    l.id AS localidad_id
FROM (
    SELECT CLIENTE_DOMICILIO AS direccion, CLIENTE_LOCALIDAD AS localidad FROM gd_esquema.Maestra WHERE CLIENTE_DOMICILIO IS NOT NULL
    UNION
    SELECT SUCURSAL_DIRECCION AS direccion, SUCURSAL_LOCALIDAD AS localidad FROM gd_esquema.Maestra WHERE SUCURSAL_DIRECCION IS NOT NULL
    UNION
    SELECT SUPER_DOMICILIO AS direccion, SUPER_LOCALIDAD AS localidad FROM gd_esquema.Maestra WHERE SUPER_DOMICILIO IS NOT NULL
) direcciones
INNER JOIN EL_DROPEO.Localidades l ON direcciones.localidad = l.nombre;

INSERT INTO EL_DROPEO.Condiciones_Fiscales (descripcion)
SELECT DISTINCT SUPER_CONDICION_FISCAL FROM gd_esquema.Maestra
WHERE SUPER_CONDICION_FISCAL IS NOT NULL

INSERT INTO EL_DROPEO.Supermercado (nombre, razon_social, cuit, iibb, ubicacion_id, fecha_inicio, condicion_fiscal_id)
SELECT 
    SUPER_NOMBRE,
    SUPER_RAZON_SOC,
    SUPER_CUIT,
    SUPER_IIBB,
    ubicacion_id,
    fecha_inicio,
    condicion_fiscal_id
FROM (
    SELECT DISTINCT
        SUPER_NOMBRE,
        SUPER_RAZON_SOC,
        SUPER_CUIT,
        CAST(SUBSTRING(SUPER_IIBB, PATINDEX('%[0-9]%', SUPER_IIBB), LEN(SUPER_IIBB)) AS BIGINT) AS SUPER_IIBB,
        u.id AS ubicacion_id,
        SUPER_FECHA_INI_ACTIVIDAD AS fecha_inicio,
        cf.id AS condicion_fiscal_id,
		SUPER_DOMICILIO
    FROM gd_esquema.Maestra m
    INNER JOIN EL_DROPEO.Ubicacion u ON m.SUPER_DOMICILIO = CONCAT(u.calle, ' ', u.altura) AND m.SUPER_LOCALIDAD = (SELECT nombre FROM EL_DROPEO.Localidades WHERE id = u.localidad_id)
    INNER JOIN EL_DROPEO.Condiciones_Fiscales cf ON m.SUPER_CONDICION_FISCAL = cf.descripcion
) as supermercados

INSERT INTO EL_DROPEO.Sucursal (nombre, ubicacion_id, supermercado_id)
SELECT 
    sucursales.SUCURSAL_NOMBRE AS nombre,
    u.id AS ubicacion_id,
    s.id AS supermercado_id
FROM (
    SELECT DISTINCT
        SUCURSAL_NOMBRE,
        SUCURSAL_DIRECCION AS direccion,
        SUCURSAL_LOCALIDAD AS localidad,
        SUCURSAL_PROVINCIA AS provincia,
        SUPER_CUIT
    FROM gd_esquema.Maestra
    WHERE SUCURSAL_DIRECCION IS NOT NULL
) sucursales
INNER JOIN EL_DROPEO.Ubicacion u ON sucursales.direccion = CONCAT(u.calle, ' ', u.altura) AND sucursales.localidad = (SELECT nombre FROM EL_DROPEO.Localidades WHERE id = u.localidad_id)
INNER JOIN EL_DROPEO.Localidades l ON sucursales.localidad = l.nombre AND sucursales.provincia = (SELECT nombre FROM EL_DROPEO.Provincia WHERE id = l.provincia_id)
INNER JOIN EL_DROPEO.Supermercado s ON sucursales.SUPER_CUIT = s.cuit;

INSERT INTO EL_DROPEO.Tipo_Caja (descripcion)
SELECT DISTINCT SUBSTRING(CAJA_TIPO, CHARINDEX(' ', CAJA_TIPO, CHARINDEX(' ', CAJA_TIPO) + 1) + 1, LEN(CAJA_TIPO))
FROM gd_esquema.Maestra
WHERE CAJA_TIPO IS NOT NULL;

INSERT INTO EL_DROPEO.Cajas (numero, tipo_caja_id, sucursal_id)
SELECT 
	CAJA_NUMERO,
	tc.id AS tipo_caja_id,
	s.id AS sucursal_id
FROM (
    SELECT DISTINCT
		CAJA_NUMERO,
        SUCURSAL_NOMBRE,
        CAJA_TIPO
    FROM gd_esquema.Maestra
    WHERE CAJA_TIPO IS NOT NULL
) cajas
INNER JOIN EL_DROPEO.Sucursal s ON cajas.SUCURSAL_NOMBRE = s.nombre
INNER JOIN EL_DROPEO.Tipo_Caja tc ON cajas.CAJA_TIPO LIKE '%' + tc.descripcion

INSERT INTO EL_DROPEO.Empleados (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento, sucursal_id)
SELECT DISTINCT
    EMPLEADO_NOMBRE,
    EMPLEADO_APELLIDO,
    EMPLEADO_DNI,
    EMPLEADO_FECHA_REGISTRO AS fecha_registro,
    EMPLEADO_TELEFONO,
    EMPLEADO_MAIL,
    EMPLEADO_FECHA_NACIMIENTO AS fecha_nacimiento,
    s.id AS sucursal_id
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Sucursal s ON SUCURSAL_NOMBRE = s.nombre
WHERE EMPLEADO_NOMBRE IS NOT NULL

INSERT INTO EL_DROPEO.Clientes (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento, ubicacion_id)
SELECT
    CLIENTE_NOMBRE,
    CLIENTE_APELLIDO,
    CLIENTE_DNI,
    fecha_registro,
    CLIENTE_TELEFONO,
    CLIENTE_MAIL,
    fecha_nacimiento,
    ubicacion_id
FROM (
    SELECT DISTINCT
        CLIENTE_NOMBRE,
        CLIENTE_APELLIDO,
        CLIENTE_DNI,
        CLIENTE_FECHA_REGISTRO AS fecha_registro,
        CLIENTE_TELEFONO,
        CLIENTE_MAIL,
        CLIENTE_FECHA_NACIMIENTO AS fecha_nacimiento,
        u.id AS ubicacion_id,
        ROW_NUMBER() OVER (PARTITION BY CLIENTE_DNI ORDER BY CLIENTE_FECHA_REGISTRO DESC) AS rn
    FROM gd_esquema.Maestra m
    INNER JOIN EL_DROPEO.Ubicacion u ON CLIENTE_DOMICILIO = CONCAT(u.calle, ' ', u.altura) AND CLIENTE_LOCALIDAD = (SELECT nombre FROM EL_DROPEO.Localidades WHERE id = u.localidad_id)
) as clientes
WHERE rn = 1

INSERT INTO EL_DROPEO.Marcas(nombre)
SELECT DISTINCT PRODUCTO_MARCA
FROM gd_esquema.Maestra
WHERE PRODUCTO_MARCA IS NOT NULL

INSERT INTO EL_DROPEO.Categorias(nombre)
SELECT DISTINCT PRODUCTO_CATEGORIA
FROM gd_esquema.Maestra
WHERE PRODUCTO_CATEGORIA IS NOT NULL

INSERT INTO EL_DROPEO.Sub_Categorias(nombre, categoria_id)
SELECT DISTINCT PRODUCTO_SUB_CATEGORIA, C.id
FROM gd_esquema.Maestra
LEFT JOIN EL_DROPEO.Categorias C ON C.nombre = PRODUCTO_CATEGORIA
WHERE PRODUCTO_CATEGORIA IS NOT NULL AND PRODUCTO_SUB_CATEGORIA IS NOT NULL

INSERT INTO EL_DROPEO.Producto(nombre, descripcion, precio, marca_id, sub_categoria_id) --Typo
SELECT DISTINCT PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO, M.id, cs.id
FROM (
	SELECT DISTINCT PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA
	FROM gd_esquema.Maestra) as productos
LEFT JOIN EL_DROPEO.Marcas M ON M.nombre = PRODUCTO_MARCA
LEFT JOIN (
	SELECT S.nombre as nombre_subcategoria, categoria_id, C.nombre as nombre_categoria, s.id 
	FROM EL_DROPEO.Sub_Categorias S
	LEFT JOIN EL_DROPEO.Categorias C ON categoria_id = C.id
) cs ON PRODUCTO_CATEGORIA = cs.nombre_categoria AND PRODUCTO_SUB_CATEGORIA = cs.nombre_subcategoria
WHERE PRODUCTO_NOMBRE IS NOT NULL AND PRODUCTO_DESCRIPCION IS NOT NULL AND PRODUCTO_PRECIO IS NOT NULL

SET IDENTITY_INSERT EL_DROPEO.Promocion ON
INSERT INTO EL_DROPEO.Promocion(id, descripcion, fecha_inicio, fecha_fin)
SELECT DISTINCT PROMO_CODIGO, PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN
FROM gd_esquema.Maestra
WHERE PROMO_CODIGO IS NOT NULL
DBCC checkident ('EL_DROPEO.Promocion', reseed, 131)
SET IDENTITY_INSERT EL_DROPEO.Promocion OFF

INSERT INTO EL_DROPEO.Regla(descripcion, cantidad_aplicable_descuento, cantidad_aplicable_regla, cantidad_maxima, misma_marca, mismo_producto, promocion_id)
SELECT DISTINCT REGLA_DESCRIPCION, REGLA_CANT_APLICA_DESCUENTO, REGLA_CANT_APLICABLE_REGLA, REGLA_CANT_MAX_PROD, REGLA_APLICA_MISMA_MARCA, REGLA_APLICA_MISMO_PROD, P.id
FROM gd_esquema.Maestra
LEFT JOIN EL_DROPEO.Promocion P on P.id = PROMO_CODIGO
WHERE REGLA_DESCRIPCION IS NOT NULL

INSERT INTO EL_DROPEO.Promocion_Producto(producto_id, promocion_id)
SELECT DISTINCT P.id, Promo.id
FROM EL_DROPEO.Producto P
LEFT JOIN EL_DROPEO.Marcas M ON M.id = P.marca_id
LEFT JOIN EL_DROPEO.Sub_Categorias S ON S.id = P.sub_categoria_id
LEFT JOIN EL_DROPEO.Categorias C ON C.id = S.categoria_id
LEFT JOIN gd_esquema.Maestra Maestra ON Maestra.PRODUCTO_NOMBRE = P.nombre AND Maestra.PRODUCTO_MARCA = M.nombre AND PRODUCTO_SUB_CATEGORIA = s.nombre AND PRODUCTO_CATEGORIA = c.nombre
LEFT JOIN EL_DROPEO.Promocion Promo ON Maestra.PROMO_CODIGO = Promo.id
WHERE Maestra.PROMO_CODIGO IS NOT NULL AND Maestra.PRODUCTO_NOMBRE IS NOT NULL

INSERT INTO EL_DROPEO.Medio_De_Pago(descripcion, tipo_pago)
SELECT DISTINCT PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO
FROM gd_esquema.Maestra
WHERE PAGO_MEDIO_PAGO IS NOT NULL AND PAGO_TIPO_MEDIO_PAGO IS NOT NULL

INSERT INTO EL_DROPEO.Descuentos(codigo, descripcion, fecha_inicio, fecha_fin, monto, tope, medio_de_pago_id)
SELECT DISTINCT DESCUENTO_CODIGO, DESCUENTO_DESCRIPCION, DESCUENTO_FECHA_INICIO, DESCUENTO_FECHA_FIN, DESCUENTO_PORCENTAJE_DESC, DESCUENTO_TOPE, M.id
FROM gd_esquema.Maestra
LEFT JOIN EL_DROPEO.Medio_De_Pago M ON M.descripcion = PAGO_MEDIO_PAGO AND M.tipo_pago = PAGO_TIPO_MEDIO_PAGO
WHERE DESCUENTO_CODIGO IS NOT NULL


INSERT INTO EL_DROPEO.Comprobantes (tipo_comprobante)
SELECT DISTINCT TICKET_TIPO_COMPROBANTE 
FROM gd_esquema.Maestra;

INSERT INTO EL_DROPEO.Venta (numero_ticket, fecha_hora, comprobante_id, empleado_id, caja_numero, caja_sucursal_id)
SELECT DISTINCT
    TICKET_NUMERO,
    TICKET_FECHA_HORA,
    Co.id AS comprobante_id,
    E.id AS empleado_id,
    cs.numero AS caja_numero,
    cs.id AS caja_sucursal_id
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Comprobantes Co ON Co.tipo_comprobante = TICKET_TIPO_COMPROBANTE
INNER JOIN EL_DROPEO.Empleados E ON E.dni = EMPLEADO_DNI
INNER JOIN (
	SELECT DISTINCT cajas.numero, sucursal.nombre, sucursal.id FROM EL_DROPEO.Cajas
	INNER JOIN EL_DROPEO.Sucursal sucursal ON sucursal.id = cajas.sucursal_id
) cs ON cs.numero = CAJA_NUMERO AND cs.nombre = SUCURSAL_NOMBRE
WHERE TICKET_FECHA_HORA IS NOT NULL AND TICKET_TIPO_COMPROBANTE IS NOT NULL AND EMPLEADO_DNI IS NOT NULL AND CAJA_NUMERO IS NOT NULL

--INSERT INTO EL_DROPEO.Detalles (cliente_id, numero_tarjeta, vencimiento_tarjeta, cuotas) va este pero no inserta nada pq no hay pagos con tarjeta
--SELECT DISTINCT
--    C.id AS cliente_id,
--    PAGO_TARJETA_NRO,
--    PAGO_TARJETA_FECHA_VENC,
--    PAGO_TARJETA_CUOTAS
--FROM gd_esquema.Maestra
--INNER JOIN EL_DROPEO.Clientes C ON C.dni = CLIENTE_DNI
--WHERE PAGO_TARJETA_NRO IS NOT NULL AND PAGO_TARJETA_FECHA_VENC IS NOT NULL AND PAGO_TARJETA_CUOTAS IS NOT NULL

INSERT INTO EL_DROPEO.Detalles (cliente_id, numero_tarjeta, vencimiento_tarjeta, cuotas)
SELECT DISTINCT
    C.id AS cliente_id,
    PAGO_TARJETA_NRO,
    PAGO_TARJETA_FECHA_VENC,
    PAGO_TARJETA_CUOTAS
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Clientes C ON C.dni = CLIENTE_DNI
WHERE CLIENTE_DNI IS NOT NULL

INSERT INTO EL_DROPEO.Pagos (fecha, medio_de_pago_id, detalle_id, importe, venta_id)
SELECT DISTINCT
    PAGO_FECHA,
    MP.id AS medio_de_pago_id,
    D.id AS detalle_id,
    PAGO_IMPORTE,
    V.id AS venta_id
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Medio_De_Pago MP ON MP.descripcion = PAGO_MEDIO_PAGO
LEFT JOIN EL_DROPEO.Detalles D ON D.numero_tarjeta = PAGO_TARJETA_NRO
INNER JOIN EL_DROPEO.Sucursal S ON S.nombre = SUCURSAL_NOMBRE
INNER JOIN EL_DROPEO.Venta V ON V.numero_ticket = TICKET_NUMERO AND S.id = V.caja_sucursal_id
WHERE PAGO_FECHA IS NOT NULL AND PAGO_MEDIO_PAGO IS NOT NULL AND PAGO_TARJETA_NRO IS NOT NULL AND PAGO_IMPORTE IS NOT NULL AND TICKET_FECHA_HORA IS NOT NULL

INSERT INTO EL_DROPEO.Estados_Envio (descripcion)
SELECT DISTINCT ENVIO_ESTADO
FROM gd_esquema.Maestra
WHERE ENVIO_ESTADO IS NOT NULL	

INSERT INTO EL_DROPEO.Envios (costo, fecha_programada, hora_inicio, hora_fin, fecha_entrega, estado_id, venta_id)
SELECT DISTINCT
    ENVIO_COSTO,
    ENVIO_FECHA_PROGRAMADA,
    ENVIO_HORA_INICIO,
    ENVIO_HORA_FIN,
    ENVIO_FECHA_ENTREGA,
    EE.id AS estado_id,
    V.id AS venta_id
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Estados_Envio EE ON EE.descripcion = ENVIO_ESTADO
INNER JOIN EL_DROPEO.Sucursal S ON S.nombre = SUCURSAL_NOMBRE
INNER JOIN EL_DROPEO.Venta V ON V.numero_ticket = TICKET_NUMERO AND V.caja_sucursal_id = S.id
WHERE ENVIO_COSTO IS NOT NULL AND ENVIO_FECHA_PROGRAMADA IS NOT NULL AND ENVIO_HORA_INICIO IS NOT NULL AND ENVIO_HORA_FIN IS NOT NULL AND TICKET_NUMERO IS NOT NULL

INSERT INTO EL_DROPEO.Descuentos_Pagos (descuento_id, pago_id, descuento_aplicado)
SELECT DISTINCT
    DESCUENTO_CODIGO,
    P.id AS pago_id,
	PAGO_DESCUENTO_APLICADO
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Venta V ON V.numero_ticket = TICKET_NUMERO
INNER JOIN EL_DROPEO.Pagos P ON P.venta_id = V.id
WHERE DESCUENTO_CODIGO IS NOT NULL;

INSERT INTO EL_DROPEO.Items (venta_id, producto_id, cantidad, precio_unitario)
SELECT DISTINCT
    V.venta_id,
    P.product_id AS producto_id,
    SUM(TICKET_DET_CANTIDAD) AS cantidad,
    TICKET_DET_PRECIO
FROM gd_esquema.Maestra M
LEFT JOIN (
    SELECT DISTINCT venta.id as venta_id, venta.numero_ticket, s.nombre as nombre_sucursal
    FROM EL_DROPEO.Venta venta
    LEFT JOIN EL_DROPEO.Sucursal s ON s.id = venta.caja_sucursal_id
) V ON V.numero_ticket = TICKET_NUMERO AND nombre_sucursal = SUCURSAL_NOMBRE
LEFT JOIN (
    SELECT distinct product.id as product_id, marca_id, sub_categoria_id, product.nombre as producto_nombre, M.nombre as marca_nombre, S.nombre as subcategoria_nombre, C.nombre as categoria_nombre
    FROM EL_DROPEO.Producto Product
    LEFT JOIN EL_DROPEO.Marcas M ON M.id = Product.marca_id
    LEFT JOIN EL_DROPEO.Sub_Categorias S ON S.id = Product.sub_categoria_id
	LEFT JOIN EL_DROPEO.Categorias C ON C.id = S.categoria_id
) P ON M.PRODUCTO_NOMBRE = P.producto_nombre AND PRODUCTO_MARCA = P.marca_nombre AND PRODUCTO_SUB_CATEGORIA = P.subcategoria_nombre AND PRODUCTO_CATEGORIA =  P.categoria_nombre
WHERE TICKET_DET_CANTIDAD IS NOT NULL AND TICKET_DET_PRECIO IS NOT NULL
GROUP BY V.venta_id, P.product_id, TICKET_DET_PRECIO;

INSERT INTO EL_DROPEO.Promocion_Item (promocion_id, item_id, promocion_aplicada_descuento)
SELECT DISTINCT
    M.PROMO_CODIGO,
    I.id AS item_id,
    SUM(M.PROMO_APLICADA_DESCUENTO)
FROM gd_esquema.Maestra M
LEFT JOIN (
    SELECT DISTINCT venta.id as venta_id, venta.numero_ticket, s.nombre as nombre_sucursal
    FROM EL_DROPEO.Venta venta
    LEFT JOIN EL_DROPEO.Sucursal s ON s.id = venta.caja_sucursal_id
) V ON V.numero_ticket = TICKET_NUMERO AND nombre_sucursal = SUCURSAL_NOMBRE
LEFT JOIN (
    SELECT distinct product.id as product_id, marca_id, sub_categoria_id, product.nombre as producto_nombre, M.nombre as marca_nombre, S.nombre as subcategoria_nombre, C.nombre as categoria_nombre
    FROM EL_DROPEO.Producto Product
    LEFT JOIN EL_DROPEO.Marcas M ON M.id = Product.marca_id
    LEFT JOIN EL_DROPEO.Sub_Categorias S ON S.id = Product.sub_categoria_id
	LEFT JOIN EL_DROPEO.Categorias C ON C.id = S.categoria_id
) P ON M.PRODUCTO_NOMBRE = P.producto_nombre AND PRODUCTO_MARCA = P.marca_nombre AND PRODUCTO_SUB_CATEGORIA = P.subcategoria_nombre AND PRODUCTO_CATEGORIA =  P.categoria_nombre
LEFT JOIN EL_DROPEO.Items I on I.venta_id = V.venta_id and I.producto_id = P.product_id
WHERE M.PROMO_CODIGO IS NOT NULL
GROUP BY I.id, M.PROMO_CODIGO


END
GO

-- Fin migración

EXEC EL_DROPEO.CREAR_TABLAS
GO
EXEC EL_DROPEO.MIGRACION
GO
