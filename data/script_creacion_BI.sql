USE GD1C2024
GO

----------
/* Drops */
----------

-- DROP VIEWS

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'EL_DROPEO.Vista_Promedio_Importe_Cuota') and type in (N'V'))
DROP VIEW EL_DROPEO.Vista_Promedio_Importe_Cuota;
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'EL_DROPEO.Vista_Porcentaje_Descuento_Medio_Pago') and type in (N'V'))
DROP VIEW EL_DROPEO.Vista_Porcentaje_Descuento_Medio_Pago;
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'EL_DROPEO.Vista_Importe_Pagos_Cuotas') and type in (N'V'))
DROP VIEW EL_DROPEO.Vista_Importe_Pagos_Cuotas;
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'EL_DROPEO.Vista_Porcentaje_Descuento') and type in (N'V'))
DROP VIEW EL_DROPEO.Vista_Porcentaje_Descuento;
GO

-- DROP FUNCTIONS

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Obtener_Rango_Etario') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Obtener_Rango_Etario
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Rango_Etario_String') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Rango_Etario_String
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Obtener_Tiempo') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Obtener_Tiempo
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Cumplio_Entrega_Estimada') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Cumplio_Entrega_Estimada
GO

-- DROP PROCEDURES
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Buscar_Turno') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Buscar_Turno
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Buscar_Cuotas') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Buscar_Cuotas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Calcular_Desvio_Envio') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Calcular_Desvio_Envio
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Crear_Tiempo_Si_No_Existe') AND type in (N'P', N'PC'))
    DROP PROCEDURE EL_DROPEO.Crear_Tiempo_Si_No_Existe
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Migrar_Fechas') AND type in (N'P', N'PC'))
    DROP PROCEDURE EL_DROPEO.Migrar_Fechas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Ticket_Promedio_Mensual') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Ticket_Promedio_Mensual
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Cantidad_Unidades_Promedio') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Cantidad_Unidades_Promedio
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Porcentaje_Anual_Ventas') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Porcentaje_Anual_Ventas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Ventas_Por_Turno') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Ventas_Por_Turno
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Top_Categorias_Descuento_Aplicado') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Top_Categorias_Descuento_Aplicado
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Porcentaje_Cumplimiento_Envios') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Porcentaje_Cumplimiento_Envios
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Cantidad_Envios_Por_Rango_Etario_Clientes') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Cantidad_Envios_Por_Rango_Etario_Clientes
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Localidades_Con_Mayor_Costo_Envio') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Localidades_Con_Mayor_Costo_Envio
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Porcentaje_Descuento_Aplicado') AND type in (N'V'))
    DROP VIEW EL_DROPEO.Porcentaje_Descuento_Aplicado
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Hechos_Ventas') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Hechos_Ventas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Hechos_Envios') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Hechos_Envios
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Hechos_Pagos') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Hechos_Pagos
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Hechos_Promociones') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Hechos_Promociones
GO

-- DROPS DIMENSIONES

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Rango_Etario') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Rango_Etario
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Localidad') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Localidad
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Tiempo') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Tiempo
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Medio_De_Pago') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Medio_De_Pago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Sucursal') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Sucursal
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Cuotas') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Cuotas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Categoria') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Categoria
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Provincia') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Provincia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Turno') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Turno
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Tipo_Caja') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Tipo_Caja
GO

------------------------------
/* Creacion de dimensiones */
------------------------------

CREATE TABLE EL_DROPEO.BI_Rango_Etario
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    inicio INT NOT NULL,
    fin INT NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Localidad
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Tiempo
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    anio INT NOT NULL,
    cuatrimestre INT NOT NULL,
    mes INT NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Sucursal
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Categoria
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Medio_De_Pago
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Provincia
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)


CREATE TABLE EL_DROPEO.BI_Cuotas
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    cantidad INT NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Turno
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    inicio INT,
    fin INT
)

CREATE TABLE EL_DROPEO.BI_Tipo_Caja
(
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)

------------------------
/* Creacion de hechos */
------------------------

CREATE TABLE EL_DROPEO.BI_Hechos_Envios
(
    tiempo_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tiempo(id),
    localidad_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Localidad(id),
    cliente_re_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Rango_Etario(id),
    sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Sucursal(id),
    cumplio_envio BIT NOT NULL,
    costo_envio DECIMAL(18,2) NOT NULL,
    cantidad INT NOT NULL,
    desvio INT NOT NULL,
    CONSTRAINT pk_BI_Hechos_Envios PRIMARY KEY (tiempo_id, localidad_id, cliente_re_id, sucursal_id, cumplio_envio)
)

CREATE TABLE EL_DROPEO.BI_Hechos_Promociones
(
    tiempo_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tiempo(id),
    categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Categoria(id),
    promocion_aplicada_descuento DECIMAL(18,2) NOT NULL,
    CONSTRAINT pk_BI_Hechos_Promociones PRIMARY KEY (tiempo_id, categoria_id)
)

CREATE TABLE EL_DROPEO.BI_Hechos_Pagos
(
    sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Sucursal(id),
    medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Medio_De_Pago(id),
    tiempo_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tiempo(id),
    cuotas_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Cuotas(id),
    cliente_re_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Rango_Etario(id),
    descuento_aplicado DECIMAL(18,2) NOT NULL,
    importe DECIMAL(18,2) NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT pk_BI_Hechos_Pagos PRIMARY KEY (sucursal_id, medio_de_pago_id, tiempo_id, cuotas_id, cliente_re_id)
)

CREATE TABLE EL_DROPEO.BI_Hechos_Ventas
(
    tiempo_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tiempo(id),
    provincia_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Provincia(id),
    localidad_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Localidad(id),
    cliente_rango_etario INT FOREIGN KEY REFERENCES EL_DROPEO.BI_Rango_Etario(id),
    empleado_rango_etario INT FOREIGN KEY REFERENCES EL_DROPEO.BI_Rango_Etario(id),
    sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Sucursal(id),
    turno_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Turno(id),
    tipo_caja_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tipo_Caja(id),
    monto_total DECIMAL(18,2) NOT NULL,
    unidades INT NOT NULL,
    cantidad_tickets INT NOT NULL,
    CONSTRAINT pk_BI_Hechos_Ventas PRIMARY KEY (tiempo_id, provincia_id, localidad_id, cliente_rango_etario, empleado_rango_etario,
        sucursal_id, turno_id, tipo_caja_id) 
)

---------------
/* Funciones */
---------------
GO
CREATE FUNCTION EL_DROPEO.Obtener_Rango_Etario (@fecha DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @anios DECIMAL(18,0);

    SET @anios = DATEDIFF(YEAR, @fecha, GETDATE());

    DECLARE @rango_etario_id INT;

    SELECT @rango_etario_id = id
    FROM EL_DROPEO.BI_Rango_Etario
    WHERE fin >= @anios AND inicio <= @anios;

    IF @rango_etario_id IS NULL 
    BEGIN
        SELECT @rango_etario_id = id
        FROM EL_DROPEO.BI_Rango_Etario
        WHERE inicio = 0 AND fin = 0;
    END

    RETURN @rango_etario_id;
END

GO
CREATE FUNCTION EL_DROPEO.Rango_Etario_String (@inicio INT, @fin INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @rango_etario NVARCHAR(255);

    IF @inicio = 0 AND @fin = 0
        SET @rango_etario = 'Desconocido';
    ELSE
        SET @rango_etario = CAST(@inicio AS NVARCHAR(255)) + ' - ' + CAST(@fin AS NVARCHAR(255));

    RETURN @rango_etario;
END

GO
CREATE FUNCTION EL_DROPEO.Obtener_Tiempo (@fecha DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @anio INT;
    DECLARE @cuatrimestre INT;
    DECLARE @mes INT;

    SET @anio = YEAR(@fecha);
    SET @mes = MONTH(@fecha);

    IF @mes BETWEEN 1 AND 4
        SET @cuatrimestre = 1;
    ELSE IF @mes BETWEEN 5 AND 8
        SET @cuatrimestre = 2;
    ELSE
        SET @cuatrimestre = 3;

    DECLARE @tiempo_id INT;
    SELECT @tiempo_id = id
    FROM EL_DROPEO.BI_Tiempo
    WHERE anio = @anio AND cuatrimestre = @cuatrimestre AND mes = @mes;

    RETURN @tiempo_id;
END

GO
CREATE FUNCTION EL_DROPEO.Cumplio_Entrega_Estimada (
    @fecha_programada DATETIME,
    @fecha_entrega DATETIME,
    @hora_inicio INT,
    @hora_fin INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @cumplio BIT;
    DECLARE @hora_entrega INT;

    SET @hora_entrega = DATEPART(HOUR, @fecha_entrega);

    IF (CAST(@fecha_entrega AS DATE) < CAST(@fecha_programada AS DATE)
        OR (CAST(@fecha_entrega AS DATE) = CAST(@fecha_programada AS DATE) AND 
            @hora_entrega BETWEEN @hora_inicio AND @hora_fin))
    BEGIN
        SET @cumplio = 1;
    END
    ELSE
    BEGIN
        SET @cumplio = 0;
    END

    RETURN @cumplio;
END

GO
CREATE FUNCTION EL_DROPEO.Calcular_Desvio_Envio
(
    @fecha_programada DATETIME,
    @fecha_entrega DATETIME,
    @hora_inicio INT,
    @hora_fin INT
)
RETURNS INT
AS
BEGIN
    DECLARE @resultado INT;
    DECLARE @inicio_rango DATETIME;
    DECLARE @fin_rango DATETIME;

    SET @inicio_rango = DATEADD(HOUR, @hora_inicio, @fecha_programada);
    SET @fin_rango = DATEADD(HOUR, @hora_fin, @fecha_programada);

    IF @fecha_entrega BETWEEN @inicio_rango AND @fin_rango
    BEGIN
        RETURN 0;
    END
    IF @fecha_entrega < @inicio_rango
    BEGIN
        SET @resultado = ABS(DATEDIFF(HOUR, @fecha_entrega, @inicio_rango));
        RETURN @resultado;
    END
    SET @resultado = ABS(DATEDIFF(HOUR, @fecha_entrega, @fin_rango));
    RETURN @resultado;
END;

GO
CREATE FUNCTION EL_DROPEO.Buscar_Turno (@fecha DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @hora INT;
    DECLARE @turno_id INT;

    SET @hora = DATEPART(HOUR, @fecha);

    SELECT @turno_id = id
    FROM EL_DROPEO.BI_Turno
    WHERE inicio <= @hora AND fin > @hora;

    -- if turno_id is null, return turno with name "otro"
    IF @turno_id IS NULL
    BEGIN
        SELECT @turno_id = id
        FROM EL_DROPEO.BI_Turno
        WHERE nombre = 'otro';
    END

    RETURN @turno_id;
END

GO
CREATE FUNCTION EL_DROPEO.Buscar_Cuotas (@pago_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @id INT;
    SELECT @id = c.id
    FROM EL_DROPEO.Detalles d
    JOIN EL_DROPEO.BI_Cuotas c ON c.cantidad = d.cuotas
    WHERE d.pago_id = @pago_id;

    IF @id IS NULL
    BEGIN
        SELECT @id = c.id
        FROM EL_DROPEO.BI_Cuotas c
        WHERE c.cantidad = 0;
    END

    RETURN @id;
END

----------------
/* Procedures */
----------------
GO
CREATE PROCEDURE EL_DROPEO.Crear_Tiempo_Si_No_Existe
    @fecha DATETIME
AS
BEGIN
    DECLARE @anio INT;
    DECLARE @cuatrimestre INT;
    DECLARE @mes INT;

    SET @anio = YEAR(@fecha);
    SET @mes = MONTH(@fecha);

    IF @mes BETWEEN 1 AND 4
        SET @cuatrimestre = 1;
    ELSE IF @mes BETWEEN 5 AND 8
        SET @cuatrimestre = 2;
    ELSE
        SET @cuatrimestre = 3;

    DECLARE @tiempo_id INT;
    SELECT @tiempo_id = id
    FROM EL_DROPEO.BI_Tiempo
    WHERE anio = @anio AND cuatrimestre = @cuatrimestre AND mes = @mes;

    IF @tiempo_id IS NULL
    BEGIN
        INSERT INTO EL_DROPEO.BI_Tiempo (anio, cuatrimestre, mes)
        VALUES (@anio, @cuatrimestre, @mes);

        SELECT @tiempo_id = SCOPE_IDENTITY();
    END
END

GO
CREATE PROCEDURE EL_DROPEO.Migrar_Fechas
    @tabla NVARCHAR(128),
    @columna NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    DECLARE @fecha_entrega DATETIME;

    SET @sql = 'DECLARE cursorTabla CURSOR FOR SELECT ' + @columna + ' FROM EL_DROPEO.' + @tabla + ';';
    EXEC sp_executesql @sql;
    OPEN cursorTabla;
    FETCH NEXT FROM cursorTabla INTO @fecha_entrega;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC EL_DROPEO.Crear_Tiempo_Si_No_Existe @fecha_entrega;

        FETCH NEXT FROM cursorTabla INTO @fecha_entrega;
    END

    CLOSE cursorTabla;
    DEALLOCATE cursorTabla;
END

------------------------------
/* Migracion de dimensiones */
------------------------------
GO

-- Popular Sucursales
INSERT INTO EL_DROPEO.BI_Sucursal (nombre)
SELECT DISTINCT nombre
FROM EL_DROPEO.Sucursales;

-- Popular tabla de rango etario
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (0, 24);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (25, 34);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (35, 49);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (50, 200);
-- Usado para clientes null
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (0, 0);

-- Popular Medios de Pago

INSERT INTO EL_DROPEO.BI_Medio_De_Pago (nombre)
SELECT DISTINCT descripcion
FROM EL_DROPEO.Medios_De_Pago;

-- Popular Cuotas
INSERT INTO EL_DROPEO.BI_Cuotas (cantidad)
SELECT DISTINCT cuotas
FROM EL_DROPEO.Detalles;

INSERT INTO EL_DROPEO.BI_Cuotas (cantidad) VALUES (0)


-- Popular tabla de localidades
INSERT INTO EL_DROPEO.BI_Localidad (nombre)
SELECT DISTINCT nombre as nombre_localidad
FROM EL_DROPEO.Localidades;

-- Migrar tiempo de envios
EXEC EL_DROPEO.Migrar_Fechas 'Envios', 'fecha_entrega';

-- Migrar tiempo de ventas
EXEC EL_DROPEO.Migrar_Fechas 'Ventas', 'fecha_hora';

-- Migrar tiempo de pagos
EXEC EL_DROPEO.Migrar_Fechas 'Pagos', 'fecha';

-- Migrar categorias
INSERT INTO EL_DROPEO.BI_Categoria (nombre)
SELECT nombre as nombre_categoria
FROM EL_DROPEO.Categorias;

-- Migrar provincias
INSERT INTO EL_DROPEO.BI_Provincia (nombre)
SELECT nombre FROM EL_DROPEO.Provincias;

-- Popular turnos
INSERT INTO EL_DROPEO.BI_Turno (nombre, inicio, fin) VALUES ('maniana', 8, 12);
INSERT INTO EL_DROPEO.BI_Turno (nombre, inicio, fin) VALUES ('tarde', 12, 16);
INSERT INTO EL_DROPEO.BI_Turno (nombre, inicio, fin) VALUES ('noche', 16, 20);
INSERT INTO EL_DROPEO.BI_TURNO (nombre) VALUES ('otro') 

-- Migrar tipos de caja
INSERT INTO EL_DROPEO.BI_Tipo_Caja (nombre)
SELECT descripcion FROM EL_DROPEO.Tipos_Caja;

-------------------------
/* Migracion de hechos */
-------------------------
INSERT INTO EL_DROPEO.BI_Hechos_Envios (tiempo_id, localidad_id, cliente_re_id, sucursal_id, cumplio_envio, costo_envio, cantidad, desvio)
SELECT
    EL_DROPEO.Obtener_Tiempo(e.fecha_entrega) as tiempo_id,
    bi_l.id as localidad_id,
    EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento) as cliente_re_id,
    bi_s.id as sucursal_id,
    EL_DROPEO.Cumplio_Entrega_Estimada(e.fecha_programada, e.fecha_entrega, e.hora_inicio, e.hora_fin) as cumplio_envio,
    SUM(e.costo),
    COUNT(*) as cantidad,
    SUM(EL_DROPEO.Calcular_Desvio_Envio(e.fecha_programada, e.fecha_entrega, e.hora_inicio, e.hora_fin)) as desvio
FROM EL_DROPEO.Envios e
INNER JOIN EL_DROPEO.Ventas v ON e.venta_id = v.id
INNER JOIN EL_DROPEO.Sucursales s ON v.caja_sucursal_id = s.id
INNER JOIN EL_DROPEO.Clientes c ON c.dni = EL_DROPEO.Buscar_Cliente(v.numero_ticket, s.nombre)
INNER JOIN EL_DROPEO.Ubicaciones u ON u.id = c.ubicacion_id
INNER JOIN EL_DROPEO.Localidades l ON l.id = u.localidad_id
INNER JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.nombre = l.nombre
INNER JOIN EL_DROPEO.BI_Sucursal bi_s ON bi_s.nombre = s.nombre
GROUP BY EL_DROPEO.Obtener_Tiempo(e.fecha_entrega), bi_l.id, EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento), bi_s.id, EL_DROPEO.Cumplio_Entrega_Estimada(e.fecha_programada, e.fecha_entrega, e.hora_inicio, e.hora_fin)

INSERT INTO EL_DROPEO.BI_Hechos_Promociones (tiempo_id, categoria_id, promocion_aplicada_descuento)
SELECT 
	EL_DROPEO.Obtener_Tiempo(v.fecha_hora) as tiempo_id, 
	BI_c.id as categoria_id,
	SUM(pr.promocion_aplicada_descuento)
FROM EL_DROPEO.Promociones_X_Items pr
LEFT JOIN EL_DROPEO.Items i ON i.id = item_id
LEFT JOIN EL_DROPEO.Ventas v ON v.id = i.venta_id
LEFT JOIN EL_DROPEO.Productos p ON p.id = i.producto_id
LEFT JOIN EL_DROPEO.Sub_Categorias s ON s.id = p.sub_categoria_id
LEFT JOIN EL_DROPEO.Categorias c ON c.id = s.categoria_id
LEFT JOIN EL_DROPEO.BI_Categoria BI_c ON c.nombre = BI_c.nombre
GROUP BY EL_DROPEO.Obtener_Tiempo(v.fecha_hora), BI_c.id

INSERT INTO EL_DROPEO.BI_Hechos_Pagos (sucursal_id, medio_de_pago_id, tiempo_id, cuotas_id, cliente_re_id, descuento_aplicado, importe, cantidad)
SELECT
    s.id as sucursal_id,
    mp.id as medio_de_pago_id,
    EL_DROPEO.Obtener_Tiempo(p.fecha) as tiempo_id,
    EL_DROPEO.Buscar_Cuotas(p.id) as cuotas_id,
    EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento) as cliente_re_id,
    SUM(dp.descuento_aplicado) AS descuento_aplicado,
    SUM(p.importe) AS importe,
    COUNT(*) as cantidad
FROM EL_DROPEO.Pagos p
JOIN EL_DROPEO.Medios_De_Pago m ON m.id = p.medio_de_pago_id
JOIN EL_DROPEO.Ventas v on v.id = p.venta_id
JOIN EL_DROPEO.Cajas caja on caja.numero = v.caja_numero and caja.sucursal_id = v.caja_sucursal_id
JOIN EL_DROPEO.Sucursales s ON s.id = caja.sucursal_id
JOIN EL_DROPEO.Clientes c ON c.dni = EL_DROPEO.Buscar_Cliente(v.numero_ticket, s.nombre)
JOIN EL_DROPEO.Descuentos_Pagos dp ON dp.pago_id = p.id
JOIN EL_DROPEO.BI_Medio_De_Pago mp on mp.nombre = m.descripcion
GROUP BY s.id, mp.id, EL_DROPEO.Obtener_Tiempo(p.fecha), EL_DROPEO.Buscar_Cuotas(p.id), EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento)

INSERT INTO EL_DROPEO.BI_Hechos_Ventas (tiempo_id, provincia_id, localidad_id, cliente_rango_etario, empleado_rango_etario, sucursal_id, turno_id, tipo_caja_id, monto_total, unidades, cantidad_tickets)
SELECT
  EL_DROPEO.Obtener_Tiempo(v.fecha_hora) as tiempo_id,
  bi_p.id as provincia_id,
  bi_l.id as localidad_id,
  EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento) as cliente_rango_etario,
  EL_DROPEO.Obtener_Rango_Etario(e.fecha_nacimiento) as empleado_rango_etario,
  bi_s.id as sucursal_id,
  EL_DROPEO.Buscar_Turno(v.fecha_hora) as turno_id,
  bi_tc.id as tipo_caja_id,
  sum(i.precio_unitario * i.cantidad) as monto_total,
  sum(i.cantidad) as unidades,
  count(distinct numero_ticket) as cantidad_tickets
FROM EL_DROPEO.Ventas v
LEFT JOIN EL_DROPEO.Sucursales s ON s.id = v.caja_sucursal_id
LEFT JOIN EL_DROPEO.Ubicaciones u ON u.id = s.ubicacion_id
LEFT JOIN EL_DROPEO.Localidades l ON l.id = u.localidad_id
LEFT JOIN EL_DROPEO.Provincias p ON p.id = l.provincia_id
LEFT JOIN EL_DROPEO.BI_Provincia bi_p ON bi_p.nombre = p.nombre
LEFT JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.nombre = l.nombre
LEFT JOIN EL_DROPEO.BI_Sucursal bi_s ON bi_s.nombre = s.nombre
LEFT JOIN EL_DROPEO.Clientes c ON c.dni = EL_DROPEO.Buscar_Cliente(v.numero_ticket, s.nombre)
LEFT JOIN EL_DROPEO.Empleados e ON e.id = v.empleado_id
LEFT JOIN EL_DROPEO.Items i ON i.venta_id = v.id
LEFT JOIN EL_DROPEO.Cajas caja ON caja.numero = v.caja_numero and caja.sucursal_id = v.caja_sucursal_id
LEFT JOIN EL_DROPEO.Tipos_Caja tc ON tc.id = caja.tipo_caja_id
LEFT JOIN EL_DROPEO.BI_Tipo_Caja bi_tc ON tc.descripcion = bi_tc.nombre
GROUP BY EL_DROPEO.Obtener_Tiempo(v.fecha_hora), bi_p.id, bi_l.id, EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento), EL_DROPEO.Obtener_Rango_Etario(e.fecha_nacimiento), bi_s.id, EL_DROPEO.Buscar_Turno(v.fecha_hora), bi_tc.id
-------------------------
/* Creacion de vistas */
-------------------------

-- Porcentaje de descuento aplicados en función del total de los tickets según el
-- mes de cada año.
GO
CREATE VIEW EL_DROPEO.Vista_Porcentaje_Descuento AS
SELECT
    tiempo.mes,
    (SUM(pagos.descuento_aplicado) / SUM(pagos.importe + pagos.descuento_aplicado)) * 100 as porcentaje_descuento
FROM EL_DROPEO.BI_Hechos_Pagos pagos
JOIN EL_DROPEO.BI_Tiempo tiempo ON tiempo.id = pagos.tiempo_id
GROUP BY tiempo.mes

-- Las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de
-- pago, mes y año. Se calcula sumando los importes totales de todas las ventas en
-- cuotas.
GO
CREATE VIEW EL_DROPEO.Vista_Importe_Pagos_Cuotas AS
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

-- Promedio de importe de la cuota en función del rango etario del cliente.
GO
CREATE VIEW EL_DROPEO.Vista_Promedio_Importe_Cuota AS
SELECT
    EL_DROPEO.Rango_Etario_String(re.inicio, re.fin) as rango_etario,
    c.cantidad,
    sum(pagos.importe) / sum(pagos.cantidad) as promedio_importe_cuota
FROM EL_DROPEO.BI_Hechos_Pagos pagos
JOIN EL_DROPEO.BI_Cuotas c ON c.id = pagos.cuotas_id
JOIN EL_DROPEO.BI_Rango_Etario re ON re.id = pagos.cliente_re_id
GROUP BY re.inicio, re.fin, c.cantidad

-- Porcentaje de descuento aplicado por cada medio de pago en función del valor
-- de total de pagos sin el descuento, por cuatrimestre. Es decir, total de descuentos
-- sobre el total de pagos más el total de descuentos.
GO
CREATE VIEW EL_DROPEO.Vista_Porcentaje_Descuento_Medio_Pago AS
SELECT
    bi_t.cuatrimestre,
    mp.nombre as medio_de_pago,
    (SUM(pagos.descuento_aplicado) / (SUM(pagos.importe) + SUM(pagos.descuento_aplicado))) * 100 as porcentaje_descuento
FROM EL_DROPEO.BI_Hechos_Pagos pagos
JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = pagos.tiempo_id
JOIN EL_DROPEO.BI_Medio_De_Pago mp ON mp.id = pagos.medio_de_pago_id
GROUP BY bi_t.cuatrimestre, mp.nombre

--  Valor promedio de las ventas (en $) según la localidad, año y mes. 
--  Se calcula en función de la sumatoria del importe de las ventas sobre el total de las mismas
GO
CREATE VIEW EL_DROPEO.Ticket_Promedio_Mensual
AS
    SELECT
        bi_l.nombre as localidad,
        bi_t.anio,
        bi_t.mes,
        SUM(bi_hv.monto_total) / SUM(bi_hv.cantidad_tickets) as ticket_promedio
    FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
    JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
    JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.id = bi_hv.localidad_id
    GROUP BY bi_l.nombre, bi_t.anio, bi_t.mes


-- Cantidad promedio de artículos que se venden en función de los tickets según el turno para cada cuatrimestre de cada año. 
-- Se obtiene sumando la cantidad de artículos de todos los tickets correspondientes sobre la cantidad de tickets. 
-- Si un producto tiene más de una unidad en un ticket, para el indicador se consideran todas las unidades.
GO
CREATE VIEW EL_DROPEO.Cantidad_Unidades_Promedio
AS
    SELECT
        bi_tur.nombre as turno,
        bi_t.anio,
        bi_t.cuatrimestre,
        SUM(bi_hv.unidades) / SUM(bi_hv.cantidad_tickets) as unidades_promedio
    FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
    JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
    JOIN EL_DROPEO.BI_Turno bi_tur ON bi_tur.id = bi_hv.turno_id
    GROUP BY bi_tur.nombre, bi_t.anio, bi_t.cuatrimestre


-- Porcentaje anual de ventas registradas por rango etario del empleado según el
-- tipo de caja para cada cuatrimestre. Se calcula tomando la cantidad de ventas
-- correspondientes sobre el total de ventas anual.
GO
CREATE VIEW EL_DROPEO.Porcentaje_Anual_Ventas -- ESTA OK, si sumas los porcentajes te casi el total, debe ser un error de redondeo
AS
    SELECT
        EL_DROPEO.Rango_Etario_String(bi_r.inicio, bi_r.fin) as rango_etario,
        bi_tc.nombre as tipo_caja,
        bi_t.anio,
        bi_t.cuatrimestre,
        CONVERT(DECIMAL(10, 2), SUM(bi_hv.cantidad_tickets)) / CONVERT(
            DECIMAL(10, 2),
            (SELECT SUM(cantidad_tickets)
            FROM EL_DROPEO.BI_Hechos_Ventas 
            JOIN EL_DROPEO.BI_Tiempo ON BI_Tiempo.id = BI_Hechos_Ventas.tiempo_id
            WHERE BI_Tiempo.anio = bi_t.anio)
        ) * 100 AS porcentaje
    FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
    JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
    JOIN EL_DROPEO.BI_Tipo_Caja bi_tc ON bi_tc.id = bi_hv.tipo_caja_id
    JOIN EL_DROPEO.BI_Rango_Etario bi_r ON bi_r.id = bi_hv.empleado_rango_etario
    GROUP BY bi_r.inicio, bi_r.fin, bi_tc.nombre, bi_t.anio, bi_t.cuatrimestre

-- Cantidad de ventas registradas por turno para cada localidad según el mes de
-- cada año
GO
CREATE VIEW EL_DROPEO.Ventas_Por_Turno
AS
    SELECT
        bi_l.nombre as localidad,
        bi_t.anio,
        bi_t.mes,
        bi_tur.nombre as turno,
        SUM(bi_hv.cantidad_tickets) as cantidad_ventas
    FROM EL_DROPEO.BI_Hechos_Ventas bi_hv
    JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_hv.tiempo_id
    JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.id = bi_hv.localidad_id
    JOIN EL_DROPEO.BI_Turno bi_tur ON bi_tur.id = bi_hv.turno_id
    GROUP BY bi_l.nombre, bi_t.anio, bi_t.mes, bi_tur.nombre

-- Las tres categorías de productos con mayor descuento aplicado 
-- A partir de promociones para cada cuatrimestre de cada año 
GO
CREATE VIEW EL_DROPEO.Top_Categorias_Descuento_Aplicado
AS
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

-- Porcentaje de cumplimiento de envíos en los tiempos programados por sucursal por año/mes (desvío)
-- usar nuevo esuqema tabla hechos_envios: agrupados por los que cumplkieron
GO
CREATE VIEW EL_DROPEO.Porcentaje_Cumplimiento_Envios
AS
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

-- Cantidad de envíos por rango etario del cliente, para cada cuatrimestre de cada año
GO
CREATE VIEW EL_DROPEO.Cantidad_Envios_Por_Rango_Etario_Clientes
AS
    SELECT
        EL_DROPEO.Rango_Etario_String(bi_r.inicio, bi_r.fin) as rango_etario,
        bi_t.anio,
        bi_t.cuatrimestre,
        sum(cantidad) as cantidad_envios
    FROM EL_DROPEO.BI_Hechos_Envios bi_he
    JOIN EL_DROPEO.BI_Tiempo bi_t ON bi_t.id = bi_he.tiempo_id
    JOIN EL_DROPEO.BI_Rango_Etario bi_r ON bi_r.id = bi_he.cliente_re_id
    GROUP BY bi_r.inicio, bi_r.fin, bi_t.anio, bi_t.cuatrimestre

-- Localidades con mayor costo de envío, tomando la localidad del cliente
GO
CREATE VIEW EL_DROPEO.Localidades_Con_Mayor_Costo_Envio
AS
    SELECT
        bi_l.nombre as localidad,
        SUM(bi_he.costo_envio) as costo_total
    FROM EL_DROPEO.BI_Hechos_Envios bi_he
    JOIN EL_DROPEO.BI_Localidad bi_l ON bi_l.id = bi_he.localidad_id
    GROUP BY bi_l.nombre


-- Porcentaje de descuento aplicados en función del total de los tickets 
-- Según el mes de cada año.
GO
CREATE VIEW EL_DROPEO.Porcentaje_Descuento_Aplicado
AS 
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

