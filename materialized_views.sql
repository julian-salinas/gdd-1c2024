/*
    La idea de este archivo es guardar las vistas que entregamos para poder comparar con las demas vistas
*/

/* -------------------------------------------------------------------------------
   Porcentaje de descuento aplicados en función del total de los tickets según el
   mes de cada año.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Porcentaje_Descuento_Aplicado(
    mes int not null,
    porcentaje_descuento decimal(10, 6) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Porcentaje_Descuento_Aplicado
SELECT
    tiempo.mes,
    (SUM(pagos.descuento_aplicado) / SUM(pagos.importe + pagos.descuento_aplicado)) * 100 as porcentaje_descuento
FROM EL_DROPEO.BI_Hechos_Pagos pagos
JOIN EL_DROPEO.BI_Tiempo tiempo ON tiempo.id = pagos.tiempo_id
GROUP BY tiempo.mes

/* -------------------------------------------------------------------------------
   Las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de
   pago, mes y año. Se calcula sumando los importes totales de todas las ventas en
   cuotas.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Importe_Pagos_Cuotas(
    sucursal varchar(255) not null,
    medio_de_pago varchar(255) not null,
    anio int not null,
    mes int not null,
    importe_total decimal(10, 2) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Importe_Pagos_Cuotas
SELECT
    subquery.sucursal,
    subquery.medio_de_pago,
    subquery.anio,
    subquery.mes,
    subquery.importe_total
FROM (
    SELECT
        s.nombre as sucursal,
        mp.nombre as medio_de_pago,
        bi_t.anio,
        bi_t.mes,
        SUM(bi_p.importe) as importe_total,
        ROW_NUMBER() OVER (PARTITION BY mp.nombre, bi_t.anio, bi_t.mes ORDER BY SUM(bi_p.importe) DESC) as rn
    FROM EL_DROPEO.BI_Hechos_Pagos bi_p
    JOIN EL_DROPEO.BI_Sucursal s ON s.id = bi_p.sucursal_id
    JOIN EL_DROPEO.BI_Medio_De_Pago mp ON mp.id = bi_p.medio_de_pago_id
    JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_p.tiempo_id
    JOIN EL_DROPEO.BI_Cuotas bi_c ON bi_c.id = bi_p.cuotas_id
	WHERE bi_c.cantidad > 0
    GROUP BY s.nombre, mp.nombre, bi_t.anio, bi_t.mes
) as subquery
WHERE subquery.rn <= 3

/* -------------------------------------------------------------------------------
   Promedio de importe de la cuota en función del rango etareo del cliente.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Promedio_Importe_Cuota(
    rango_etario varchar(255) not null,
    cantidad int not null,
    promedio_importe_cuota decimal(10, 2) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Promedio_Importe_Cuota
SELECT
    EL_DROPEO.Rango_Etario_String(re.inicio, re.fin) as rango_etario,
    c.cantidad,
    sum(pagos.importe) / sum(pagos.cantidad) as promedio_importe_cuota
FROM EL_DROPEO.BI_Hechos_Pagos pagos
JOIN EL_DROPEO.BI_Cuotas c ON c.id = pagos.cuotas_id
JOIN EL_DROPEO.BI_Rango_Etario re ON re.id = pagos.cliente_re_id
GROUP BY re.inicio, re.fin, c.cantidad

/* -------------------------------------------------------------------------------
   Porcentaje de descuento aplicado por cada medio de pago en función del valor
   de total de pagos sin el descuento, por cuatrimestre. Es decir, total de descuentos
   sobre el total de pagos más el total de descuentos.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Porcentaje_Descuento_Medio_Pago(
    cuatrimestre int not null,
    medio_de_pago varchar(255) not null,
    porcentaje_descuento decimal(10, 6) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Porcentaje_Descuento_Medio_Pago
SELECT
    bi_t.cuatrimestre,
    mp.nombre as medio_de_pago,
    (SUM(pagos.descuento_aplicado) / (SUM(pagos.importe) + SUM(pagos.descuento_aplicado))) * 100 as porcentaje_descuento
FROM EL_DROPEO.BI_Hechos_Pagos pagos
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = pagos.tiempo_id
JOIN EL_DROPEO.BI_Medio_De_Pago mp ON mp.id = pagos.medio_de_pago_id
GROUP BY bi_t.cuatrimestre, mp.nombre

/* -------------------------------------------------------------------------------
   Valor promedio de las ventas (en $) según la localidad, año y mes. 
   Se calcula en función de la sumatoria del importe de las ventas sobre el total de las mismas
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Valor_Promedio_Ventas(
    localidad varchar(255) not null,
    anio int not null,
    mes int not null,
    ticket_promedio decimal(12, 6) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Valor_Promedio_Ventas
SELECT
    bi_l.nombre as localidad,
    bi_t.anio,
    bi_t.mes,
    SUM(bi_hv.monto_total) / COUNT(*) as ticket_promedio
FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.id = bi_hv.localidad_id
GROUP BY bi_l.nombre, bi_t.anio, bi_t.mes

/* -------------------------------------------------------------------------------
   Cantidad promedio de artículos que se venden en función de los tickets según el turno para cada cuatrimestre de cada año. 
   Se obtiene sumando la cantidad de artículos de todos los tickets correspondientes sobre la cantidad de tickets. 
   Si un producto tiene más de una unidad en un ticket, para el indicador se consideran todas las unidades.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Cantidad_Unidades_Promedio(
    turno_id int not null,
    anio int not null,
    cuatrimestre int not null,
    unidades_promedio decimal(10, 6) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Cantidad_Unidades_Promedio
SELECT
    bi_hv.turno_id,
    bi_t.anio,
    bi_t.cuatrimestre,
    SUM(bi_hv.unidades) / COUNT(*) as unidades_promedio
FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
GROUP BY bi_hv.turno_id, bi_t.anio, bi_t.cuatrimestre

/* -------------------------------------------------------------------------------
   Porcentaje anual de ventas registradas por rango etario del empleado según el
   tipo de caja para cada cuatrimestre. Se calcula tomando la cantidad de ventas
   correspondientes sobre el total de ventas anual.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Porcentaje_Anual_Ventas(
    rango_etario varchar(255) not null,
    tipo_caja varchar(255) not null,
    anio int not null,
    cuatrimestre int not null,
    porcentaje decimal(14, 13) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Porcentaje_Anual_Ventas
SELECT
    EL_DROPEO.Rango_Etario_String(bi_r.inicio, bi_r.fin) as rango_etario,
    bi_tc.nombre as tipo_caja,
    bi_t.anio,
    bi_t.cuatrimestre,
    CONVERT(DECIMAL(10, 2), COUNT(*)) / CONVERT(
        DECIMAL(10, 2),
        (SELECT COUNT(*)
        FROM EL_DROPEO.BI_Hechos_Ventas 
        JOIN EL_DROPEO.BI_Tiempo ON BI_Tiempo.id = BI_Hechos_Ventas.tiempo_id 
        WHERE BI_Tiempo.anio = bi_t.anio)
    ) * 100 AS porcentaje
FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
JOIN EL_DROPEO.BI_Tipo_Caja bi_tc ON bi_tc.id = bi_hv.tipo_caja_id
JOIN EL_DROPEO.BI_Rango_Etario bi_r ON bi_r.id = bi_hv.empleado_rango_etario
GROUP BY bi_r.inicio, bi_r.fin, bi_tc.nombre, bi_t.anio, bi_t.cuatrimestre

/* -------------------------------------------------------------------------------
   Cantidad de ventas registradas por turno para cada localidad según el mes de
   cada año.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Ventas_Por_Turno(
    localidad varchar(255) not null,
    anio int not null,
    mes int not null,
    turno varchar(255) not null,
    cantidad_ventas int not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Ventas_Por_Turno
SELECT
    bi_l.nombre as localidad,
    bi_t.anio,
    bi_t.mes,
    bi_tur.nombre as turno,
    COUNT(*) as cantidad_ventas
FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.id = bi_hv.localidad_id
JOIN EL_DROPEO.BI_Turno bi_tur ON bi_tur.id = bi_hv.turno_id
GROUP BY bi_l.nombre, bi_t.anio, bi_t.mes, bi_tur.nombre

/* -------------------------------------------------------------------------------
   Cantidad de ventas registradas por rango etario del empleado según el tipo de
   caja para cada cuatrimestre de cada año.
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Vista_Ventas_Por_Rango_Etario(
    categoria varchar(255) not null,
    anio int not null,
    cuatrimestre int not null,
    descuento_total decimal(11,2) not null
)

INSERT INTO EL_DROPEO.Materialized_Vista_Ventas_Por_Rango_Etario
SELECT
    categoria, 
    anio, 
    cuatrimestre, 
    descuento_total
FROM (
    SELECT
        bi_c.nombre as categoria,
        bi_t.anio,
        bi_t.cuatrimestre,
        SUM(bi_hp.promocion_aplicada_descuento) as descuento_total,
        ROW_NUMBER() OVER (PARTITION BY bi_t.anio, bi_t.cuatrimestre ORDER BY SUM(bi_hp.promocion_aplicada_descuento) DESC) as rn
    FROM EL_DROPEO.BI_Hechos_Promociones bi_hp
    JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hp.tiempo_id
    JOIN EL_DROPEO.BI_Categoria bi_c ON bi_c.id = bi_hp.categoria_id
    GROUP BY bi_c.nombre, bi_t.anio, bi_t.cuatrimestre
) as sq
WHERE rn <= 3

/* -------------------------------------------------------------------------------
   Porcentaje de cumplimiento de envíos en los tiempos programados por sucursal por año/mes (desvío)
   usar nuevo esuqema tabla hechos_envios: agrupados por los que cumplieron
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Porcentaje_Cumplimiento_Envios(
    sucursal varchar(255) not null,
    anio int not null,
    mes int not null,
    porcentaje_cumplimiento decimal(10, 2) not null,
    cant_cumplieron int not null,
    desvio decimal(15, 13) not null
)

INSERT INTO EL_DROPEO.Materialized_Porcentaje_Cumplimiento_Envios
SELECT
    bi_s.nombre as sucursal,
    bi_t.anio,
    bi_t.mes,
    CONVERT(DECIMAL(10,2), (SUM(CASE WHEN bi_he.cumplio_envio = 1 THEN bi_he.cantidad ELSE 0 END)) / CONVERT(DECIMAL(10,2), sum(cantidad)) * 100) as porcentaje_cumplimiento,
    SUM(CASE WHEN bi_he.cumplio_envio = 1 THEN bi_he.cantidad ELSE 0 END) cant_cumplieron,
    CONVERT(DECIMAL(10,2), SUM(DESVIO)) / CONVERT(DECIMAL(10,2), count(*)) desvio
FROM EL_DROPEO.BI_Hechos_Envios bi_he
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_he.tiempo_id
JOIN EL_DROPEO.BI_Sucursal bi_s ON bi_s.id = bi_he.sucursal_id
GROUP BY bi_s.nombre, bi_t.anio, bi_t.mes

/* -------------------------------------------------------------------------------
   Cantidad de envíos por rango etario del cliente, para cada cuatrimestre de cada año
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Cantidad_Envios_Por_Rango_Etario_Clientes(
    rango_etario varchar(255) not null,
    anio int not null,
    cuatrimestre int not null,
    cantidad_envios int not null
)

INSERT INTO EL_DROPEO.Materialized_Cantidad_Envios_Por_Rango_Etario_Clientes
SELECT
    EL_DROPEO.Rango_Etario_String(bi_r.inicio, bi_r.fin) as rango_etario,
    bi_t.anio,
    bi_t.cuatrimestre,
    sum(cantidad) as cantidad_envios
FROM EL_DROPEO.BI_Hechos_Envios bi_he
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_he.tiempo_id
JOIN EL_DROPEO.BI_Rango_Etario bi_r ON bi_r.id = bi_he.cliente_re_id
GROUP BY bi_r.inicio, bi_r.fin, bi_t.anio, bi_t.cuatrimestre

/* -------------------------------------------------------------------------------
   Localidades con mayor costo de envío, tomando la localidad del cliente
---------------------------------------------------------------------------------- */
CREATE TABLE EL_DROPEO.Materialized_Localidades_Con_Mayor_Costo_Envio(
    localidad varchar(255) not null,
    costo_total decimal(10, 2) not null
)

INSERT INTO EL_DROPEO.Materialized_Localidades_Con_Mayor_Costo_Envio
SELECT
    bi_l.nombre as localidad,
    SUM(bi_he.costo_envio) as costo_total
FROM EL_DROPEO.BI_Hechos_Envios bi_he
JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.id = bi_he.localidad_id
GROUP BY bi_l.nombre

/* -------------------------------------------------------------------------------
   Porcentaje de descuento aplicados en función del total de los tickets 
   Según el mes de cada año.
*/
CREATE TABLE EL_DROPEO.Materialized_Porcentaje_Descuento_Aplicado(
    anio int not null,
    mes int not null,
    porcentaje_descuento decimal(10, 6) not null
)

INSERT INTO EL_DROPEO.Materialized_Porcentaje_Descuento_Aplicado
SELECT 
    ventas.anio AS anio,
    ventas.mes AS mes,
    ((total_promo_descuento_aplicado + total_descuentos_pagos) / total_tickets) * 100 AS porcentaje_descuento
FROM (
    SELECT
        t.anio AS anio,
        t.mes AS mes,
        sum(monto_total) AS total_tickets
    FROM el_dropeo.bi_hechos_ventas bi_hv
    JOIN el_dropeo.bi_tiempo t ON bi_hv.tiempo_id = t.id
    GROUP BY t.anio, t.mes
) AS ventas
JOIN (
    SELECT
        tpr.anio AS anio,
        tpr.mes AS mes,
        sum(bi_hpr.promocion_aplicada_descuento) AS total_promo_descuento_aplicado
    FROM el_dropeo.bi_hechos_promociones bi_hpr
    JOIN el_dropeo.bi_tiempo tpr ON bi_hpr.tiempo_id = tpr.id
    GROUP BY tpr.anio, tpr.mes
) as promos ON promos.anio = ventas.anio AND promos.mes = ventas.mes
JOIN (
    SELECT 
        tp.anio as anio,
        tp.mes as mes,
        sum(bi_hp.descuento_aplicado) AS total_descuentos_pagos 
    FROM el_dropeo.bi_hechos_pagos bi_hp
    JOIN el_dropeo.bi_tiempo tp ON bi_hp.tiempo_id = tp.id
    GROUP BY tp.anio, tp.mes
) AS pagos ON pagos.anio = ventas.anio AND pagos.mes = ventas.mes
