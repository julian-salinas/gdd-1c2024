USE GD1C2024
GO

CREATE PROCEDURE EL_DROPEO.MIGRAR_VENTAS AS
BEGIN

INSERT INTO EL_DROPEO.Comprobante (tipo_comprobante)
SELECT DISTINCT TICKET_TIPO_COMPROBANTE 
FROM gd_esquema.Maestra;

INSERT INTO EL_DROPEO.Venta (numero_ticket, fecha, comprobante_id, empleado_id, caja_numero, caja_sucursal_id)
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

END

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
INNER JOIN EL_DROPEO.Detalle D ON D.numero_tarjeta = PAGO_TARJETA_NRO
INNER JOIN EL_DROPEO.Venta V ON V.fecha_hora = TICKET_FECHA_HORA
WHERE PAGO_FECHA IS NOT NULL AND PAGO_MEDIO_PAGO IS NOT NULL AND PAGO_TARJETA_NRO IS NOT NULL AND PAGO_IMPORTE IS NOT NULL AND TICKET_FECHA_HORA IS NOT NULL


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

EXEC EL_DROPEO.MIGRAR_VENTAS
GO