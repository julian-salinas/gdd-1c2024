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
    INNER JOIN EL_DROPEO.Ubicacion u ON m.SUPER_DOMICILIO = CONCAT(u.calle, ' ', u.altura)
    INNER JOIN EL_DROPEO.Condicion_Fiscal cf ON m.SUPER_CONDICION_FISCAL = cf.descripcion
) as supermercados
-- WHERE condicion_fiscal_id = 2
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
INNER JOIN EL_DROPEO.Ubicacion u ON sucursales.direccion = CONCAT(u.calle, ' ', u.altura)
INNER JOIN EL_DROPEO.Localidad l ON sucursales.localidad = l.nombre AND sucursales.provincia = (SELECT nombre FROM EL_DROPEO.Provincia WHERE id = l.provincia_id)
INNER JOIN EL_DROPEO.Supermercado s ON sucursales.SUPER_CUIT = s.cuit;

END
GO

EXEC EL_DROPEO.MIGRAR_SUPERMERCADOS
GO