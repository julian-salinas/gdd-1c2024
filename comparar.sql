DECLARE @vista NVARCHAR(255)
DECLARE @tabla NVARCHAR(255)
DECLARE @sql NVARCHAR(MAX)

-- Lista de vistas y tablas
DECLARE vistas_y_tablas CURSOR FOR
SELECT 
    'Vista_Porcentaje_Descuento', 'Materialized_Vista_Porcentaje_Descuento'
UNION ALL
SELECT 
    'Vista_Importe_Pagos_Cuotas', 'Materialized_Vista_Importe_Pagos_Cuotas'
UNION ALL
SELECT 
    'Vista_Promedio_Importe_Cuota', 'Materialized_Vista_Promedio_Importe_Cuota'
UNION ALL
SELECT 
    'Vista_Porcentaje_Descuento_Medio_Pago', 'Materialized_Vista_Porcentaje_Descuento_Medio_Pago'
UNION ALL
SELECT 
    'Ticket_Promedio_Mensual', 'Materialized_Ticket_Promedio_Mensual'
UNION ALL
SELECT 
    'Cantidad_Unidades_Promedio', 'Materialized_Cantidad_Unidades_Promedio'
UNION ALL
SELECT 
    'Porcentaje_Anual_Ventas', 'Materialized_Porcentaje_Anual_Ventas'
UNION ALL
SELECT 
    'Ventas_Por_Turno', 'Materialized_Ventas_Por_Turno'
UNION ALL
SELECT
    'Top_Categorias_Descuento_Aplicado', 'Materialized_Top_Categorias_Descuento_Aplicado'
UNION ALL
SELECT
    'Porcentaje_Cumplimiento_Envios', 'Materialized_Porcentaje_Cumplimiento_Envios'
UNION ALL
SELECT 
    'Cantidad_Envios_Por_Rango_Etario_Clientes', 'Materialized_Cantidad_Envios_Por_Rango_Etario_Clientes'
UNION ALL
SELECT 
    'Localidades_Con_Mayor_Costo_Envio', 'Materialized_Localidades_Con_Mayor_Costo_Envio'
UNION ALL
SELECT 
    'Porcentaje_Descuento_Aplicado', 'Materialized_Porcentaje_Descuento_Aplicado'

OPEN vistas_y_tablas
FETCH NEXT FROM vistas_y_tablas INTO @vista, @tabla

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Comparar datos de la vista con la tabla materializada
    SET @sql = '
    IF EXISTS (
        SELECT * 
        FROM EL_DROPEO.' + @vista + '
        EXCEPT
        SELECT * 
        FROM EL_DROPEO.' + @tabla + '
    )
    PRINT ''Error: Diferencias encontradas entre ' + @vista + ' y ' + @tabla + ''''

    EXEC sp_executesql @sql

    -- Comparar datos de la tabla materializada con la vista
    SET @sql = '
    IF EXISTS (
        SELECT * 
        FROM EL_DROPEO.' + @tabla + '
        EXCEPT
        SELECT * 
        FROM EL_DROPEO.' + @vista + '
    )
    PRINT ''Error: Diferencias encontradas entre ' + @tabla + ' y ' + @vista + ''''

    EXEC sp_executesql @sql

    FETCH NEXT FROM vistas_y_tablas INTO @vista, @tabla
END

CLOSE vistas_y_tablas
DEALLOCATE vistas_y_tablas
