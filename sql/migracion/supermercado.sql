USE GD1C2024
GO

CREATE PROCEDURE EL_DROPEO.MIGRAR_SUPERMERCADOS AS
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

END