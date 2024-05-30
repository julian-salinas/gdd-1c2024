USE GD1C2024
GO

CREATE PROCEDURE EL_DROPEO.MIGRAR_SUPERMERCADOS AS
BEGIN

/*
 Migración de provincias
 */
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

/*
 Migración de localidades
 */
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

/*
 Migración de ubicaciones
 */
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

/*
 Migración de condiciones fiscales
 */
INSERT INTO EL_DROPEO.Condicion_Fiscal (descripcion)
SELECT DISTINCT SUPER_CONDICION_FISCAL FROM gd_esquema.Maestra
WHERE SUPER_CONDICION_FISCAL IS NOT NULL

/*
 Migración de supermercados
 */
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
        CONVERT(DATETIME, SUPER_FECHA_INI_ACTIVIDAD, 101) AS fecha_inicio,
        cf.id AS condicion_fiscal_id,
		SUPER_DOMICILIO
    FROM gd_esquema.Maestra m
    INNER JOIN EL_DROPEO.Ubicacion u ON m.SUPER_DOMICILIO = CONCAT(u.calle, ' ', u.altura) AND m.SUPER_LOCALIDAD = (SELECT nombre FROM EL_DROPEO.Localidad WHERE id = u.localidad_id)
    INNER JOIN EL_DROPEO.Condicion_Fiscal cf ON m.SUPER_CONDICION_FISCAL = cf.descripcion
) as supermercados
/* NOTA: 
El where debe descomentarse para ejecutar la query porque hay supermercados 
exactamente iguales pero con distinta condición fiscal.
El problema es que el cuit tiene la constraint UNIQUE, no debería haber dos supermercados con el mismo cuit.
Confirmar si es correcto o no.
*/

/*
 Migración de sucursales
 */
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

/*
 Migración de tipos de caja
 */
INSERT INTO EL_DROPEO.Tipo_Caja (descripcion)
SELECT DISTINCT SUBSTRING(CAJA_TIPO, CHARINDEX(' ', CAJA_TIPO, CHARINDEX(' ', CAJA_TIPO) + 1) + 1, LEN(CAJA_TIPO))
FROM gd_esquema.Maestra
WHERE CAJA_TIPO IS NOT NULL;

/*
 Migración de cajas
 */
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
INNER JOIN EL_DROPEO.Tipo_Caja tc ON tc.descripcion LIKE '%' + cajas.CAJA_TIPO + '%'

/*
 Migración de empleados
 */
INSERT INTO EL_DROPEO.Empleado (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento, sucursal_id)
SELECT 
    EMPLEADO_NOMBRE,
    EMPLEADO_APELLIDO,
    EMPLEADO_DNI,
    CONVERT(DATETIME, EMPLEADO_FECHA_REGISTRO, 101) AS fecha_registro,
    EMPLEADO_TELEFONO,
    EMPLEADO_MAIL,
    CONVERT(DATETIME, EMPLEADO_FECHA_NACIMIENTO, 101) AS fecha_nacimiento,
    s.id AS sucursal_id
FROM gd_esquema.Maestra
INNER JOIN EL_DROPEO.Sucursal s ON SUCURSAL_NOMBRE = s.nombre

/*
 Migración de clientes
 */
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
        CONVERT(DATETIME, CLIENTE_FECHA_REGISTRO, 101) AS fecha_registro,
        CLIENTE_TELEFONO,
        CLIENTE_MAIL,
        CONVERT(DATETIME, CLIENTE_FECHA_NACIMIENTO, 101) AS fecha_nacimiento,
        u.id AS ubicacion_id,
        ROW_NUMBER() OVER (PARTITION BY CLIENTE_DNI ORDER BY CLIENTE_FECHA_REGISTRO DESC) AS rn
    FROM gd_esquema.Maestra m
    INNER JOIN EL_DROPEO.Ubicacion u ON CLIENTE_DOMICILIO = CONCAT(u.calle, ' ', u.altura) AND CLIENTE_LOCALIDAD = (SELECT nombre FROM EL_DROPEO.Localidad WHERE id = u.localidad_id)
) as clientes
WHERE rn = 1

END
GO

EXEC EL_DROPEO.MIGRAR_SUPERMERCADOS
GO