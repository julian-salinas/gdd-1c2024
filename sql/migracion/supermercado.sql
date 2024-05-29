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
WITH CTE AS (
    SELECT 
        SUPER_NOMBRE,
        SUPER_RAZON_SOC,
        SUPER_CUIT,
        CAST(SUBSTRING(SUPER_IIBB, PATINDEX('%[0-9]%', SUPER_IIBB), LEN(SUPER_IIBB)) AS BIGINT) AS SUPER_IIBB,
        u.id AS ubicacion_id,
        CONVERT(DATETIME, SUPER_FECHA_INI_ACTIVIDAD, 101) AS fecha_inicio,
        cf.id AS condicion_fiscal_id,
        ROW_NUMBER() OVER (PARTITION BY SUPER_CUIT ORDER BY SUPER_CUIT) AS rn
    FROM gd_esquema.Maestra m
    INNER JOIN EL_DROPEO.Ubicacion u ON m.SUPER_DOMICILIO = CONCAT(u.calle, ' ', u.altura)
    INNER JOIN EL_DROPEO.Condicion_Fiscal cf ON m.SUPER_CONDICION_FISCAL = cf.descripcion
)
INSERT INTO EL_DROPEO.Supermercado (nombre, razon_social, cuit, iibb, ubicacion_id, fecha_inicio, condicion_fiscal_id)
SELECT 
    SUPER_NOMBRE,
    SUPER_RAZON_SOC,
    SUPER_CUIT,
    SUPER_IIBB,
    ubicacion_id,
    fecha_inicio,
    condicion_fiscal_id
FROM CTE
WHERE rn = 1;

END
GO

EXEC EL_DROPEO.MIGRAR_SUPERMERCADOS
GO