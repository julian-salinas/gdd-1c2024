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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Item') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Item
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Sub_Categoria') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Sub_Categoria
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Categoria') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Categoria
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Marca') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Marca
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Descuentos') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Descuentos
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Pagos') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Pagos
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Detalle') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Detalle
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Medio_De_Pago') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Medio_De_Pago
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Venta') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Venta
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Empleado') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Empleado
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Comprobante') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Comprobante
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Cliente') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Cliente
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Caja') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Caja
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Localidad') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Localidad
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Provincia') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Provincia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Condicion_Fiscal') AND type in (N'U'))
    DROP TABLE EL_DROPEO.Condicion_Fiscal
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

CREATE TABLE EL_DROPEO.Localidad(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	provincia_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Provincia
)

CREATE TABLE EL_DROPEO.Ubicacion(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	calle NVARCHAR(255) NOT NULL,
	altura INT NOT NULL,
	localidad_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Localidad
)

CREATE TABLE EL_DROPEO.Condicion_Fiscal(
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
	condicion_fiscal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Condicion_Fiscal
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

CREATE TABLE EL_DROPEO.Caja(
	numero INT NOT NULL,
	tipo_caja_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Tipo_Caja,
	sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sucursal,
	PRIMARY KEY(numero, sucursal_id)
)

CREATE TABLE EL_DROPEO.Cliente(
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

CREATE TABLE EL_DROPEO.Comprobante(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_comprobante NVARCHAR(255) NOT NULL,
)

CREATE TABLE EL_DROPEO.Empleado(
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
	comprobante_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Comprobante,
	empleado_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Empleado,
	caja_numero INT NOT NULL,
	caja_sucursal_id INT NOT NULL,
	FOREIGN KEY (caja_numero, caja_sucursal_id) REFERENCES EL_DROPEO.Caja(numero, sucursal_id)
)


CREATE TABLE EL_DROPEO.Medio_De_Pago(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	tipo_pago NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Detalle(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cliente_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Cliente,
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
	detalle_id INT FOREIGN KEY REFERENCES EL_DROPEO.Detalle
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

CREATE TABLE EL_DROPEO.Marca(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Categoria(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Sub_Categoria(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Categoria,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Producto(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	descripcion NVARCHAR(255) NOT NULL,
	precio DECIMAL(18, 2) NOT NULL,
	marca_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Marca,
	sub_categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sub_Categoria
)

CREATE TABLE EL_DROPEO.Item(
	venta_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Venta,
	producto_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Producto,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(18, 2) NOT NULL,
	PRIMARY KEY(venta_id, producto_id)
)

CREATE TABLE EL_DROPEO.Promocion(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
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

INSERT INTO EL_DROPEO.Localidad (nombre, provincia_id)
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
INNER JOIN EL_DROPEO.Localidad l ON direcciones.localidad = l.nombre;

INSERT INTO EL_DROPEO.Condicion_Fiscal (descripcion)
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
    INNER JOIN EL_DROPEO.Ubicacion u ON m.SUPER_DOMICILIO = CONCAT(u.calle, ' ', u.altura) AND m.SUPER_LOCALIDAD = (SELECT nombre FROM EL_DROPEO.Localidad WHERE id = u.localidad_id)
    INNER JOIN EL_DROPEO.Condicion_Fiscal cf ON m.SUPER_CONDICION_FISCAL = cf.descripcion
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
INNER JOIN EL_DROPEO.Ubicacion u ON sucursales.direccion = CONCAT(u.calle, ' ', u.altura) AND sucursales.localidad = (SELECT nombre FROM EL_DROPEO.Localidad WHERE id = u.localidad_id)
INNER JOIN EL_DROPEO.Localidad l ON sucursales.localidad = l.nombre AND sucursales.provincia = (SELECT nombre FROM EL_DROPEO.Provincia WHERE id = l.provincia_id)
INNER JOIN EL_DROPEO.Supermercado s ON sucursales.SUPER_CUIT = s.cuit;

INSERT INTO EL_DROPEO.Tipo_Caja (descripcion)
SELECT DISTINCT SUBSTRING(CAJA_TIPO, CHARINDEX(' ', CAJA_TIPO, CHARINDEX(' ', CAJA_TIPO) + 1) + 1, LEN(CAJA_TIPO))
FROM gd_esquema.Maestra
WHERE CAJA_TIPO IS NOT NULL;

INSERT INTO EL_DROPEO.Caja (numero, tipo_caja_id, sucursal_id)
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

INSERT INTO EL_DROPEO.Empleado (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento, sucursal_id)
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

INSERT INTO EL_DROPEO.Cliente (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento, ubicacion_id)
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
    INNER JOIN EL_DROPEO.Ubicacion u ON CLIENTE_DOMICILIO = CONCAT(u.calle, ' ', u.altura) AND CLIENTE_LOCALIDAD = (SELECT nombre FROM EL_DROPEO.Localidad WHERE id = u.localidad_id)
) as clientes
WHERE rn = 1

INSERT INTO EL_DROPEO.Marca(nombre)
SELECT DISTINCT PRODUCTO_MARCA
FROM gd_esquema.Maestra
WHERE PRODUCTO_MARCA IS NOT NULL

INSERT INTO EL_DROPEO.Categoria(nombre)
SELECT DISTINCT PRODUCTO_CATEGORIA
FROM gd_esquema.Maestra
WHERE PRODUCTO_CATEGORIA IS NOT NULL

INSERT INTO EL_DROPEO.Sub_Categoria(nombre, categoria_id)
SELECT DISTINCT PRODUCTO_SUB_CATEGORIA, C.id
FROM gd_esquema.Maestra
LEFT JOIN EL_DROPEO.Categoria C ON C.nombre = PRODUCTO_CATEGORIA
WHERE PRODUCTO_CATEGORIA IS NOT NULL AND PRODUCTO_SUB_CATEGORIA IS NOT NULL

INSERT INTO EL_DROPEO.Producto(nombre, descripcion, precio, marca_id, sub_categoria_id) --Typo
SELECT DISTINCT PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO, M.id, cs.id
FROM (
	SELECT DISTINCT PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA
	FROM gd_esquema.Maestra) as productos
LEFT JOIN EL_DROPEO.Marca M ON M.nombre = PRODUCTO_MARCA
LEFT JOIN (
	SELECT S.nombre as nombre_subcategoria, categoria_id, C.nombre as nombre_categoria, s.id 
	FROM EL_DROPEO.Sub_Categoria S
	LEFT JOIN EL_DROPEO.Categoria C ON categoria_id = C.id
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
LEFT JOIN EL_DROPEO.Marca M ON M.id = P.marca_id
LEFT JOIN EL_DROPEO.Sub_Categoria S ON S.id = P.sub_categoria_id
LEFT JOIN EL_DROPEO.Categoria C ON C.id = S.categoria_id
LEFT JOIN gd_esquema.Maestra Maestra ON Maestra.PRODUCTO_NOMBRE = P.nombre AND Maestra.PRODUCTO_MARCA = M.nombre AND PRODUCTO_SUB_CATEGORIA = s.nombre AND PRODUCTO_CATEGORIA = c.nombre
INNER JOIN EL_DROPEO.Promocion Promo ON Maestra.PROMO_CODIGO = Promo.id
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


INSERT INTO EL_DROPEO.Comprobante (tipo_comprobante)
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
INNER JOIN EL_DROPEO.Comprobante Co ON Co.tipo_comprobante = TICKET_TIPO_COMPROBANTE
INNER JOIN EL_DROPEO.Empleado E ON E.dni = EMPLEADO_DNI
INNER JOIN (
	SELECT DISTINCT caja.numero, sucursal.nombre, sucursal.id FROM EL_DROPEO.Caja
	INNER JOIN EL_DROPEO.Sucursal sucursal ON sucursal.id = caja.sucursal_id
) cs ON cs.numero = CAJA_NUMERO AND cs.nombre = SUCURSAL_NOMBRE
WHERE TICKET_FECHA_HORA IS NOT NULL AND TICKET_TIPO_COMPROBANTE IS NOT NULL AND EMPLEADO_DNI IS NOT NULL AND CAJA_NUMERO IS NOT NULL

INSERT INTO EL_DROPEO.Detalle (cliente_id, numero_tarjeta, vencimiento_tarjeta, cuotas)
SELECT DISTINCT
    C.id AS cliente_id,
    PAGO_TARJETA_NRO,
    PAGO_TARJETA_FECHA_VENC,
    PAGO_TARJETA_CUOTAS
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Cliente C ON C.dni = CLIENTE_DNI
WHERE PAGO_TARJETA_NRO IS NOT NULL AND PAGO_TARJETA_FECHA_VENC IS NOT NULL AND PAGO_TARJETA_CUOTAS IS NOT NULL

INSERT INTO EL_DROPEO.Detalle (cliente_id, numero_tarjeta, vencimiento_tarjeta, cuotas)
SELECT DISTINCT
    C.id AS cliente_id,
    PAGO_TARJETA_NRO,
    PAGO_TARJETA_FECHA_VENC,
    PAGO_TARJETA_CUOTAS
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Cliente C ON C.dni = CLIENTE_DNI
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
LEFT JOIN EL_DROPEO.Detalle D ON D.numero_tarjeta = PAGO_TARJETA_NRO
INNER JOIN EL_DROPEO.Sucursal S ON S.nombre = SUCURSAL_NOMBRE
INNER JOIN EL_DROPEO.Venta V ON V.numero_ticket = TICKET_NUMERO AND S.id = V.caja_sucursal_id
WHERE PAGO_FECHA IS NOT NULL AND PAGO_MEDIO_PAGO IS NOT NULL AND PAGO_TARJETA_NRO IS NOT NULL AND PAGO_IMPORTE IS NOT NULL AND TICKET_FECHA_HORA IS NOT NULL

END
GO

-- Fin migración

EXEC EL_DROPEO.CREAR_TABLAS
GO
EXEC EL_DROPEO.MIGRACION
GO