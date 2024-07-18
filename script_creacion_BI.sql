USE GD1C2024
GO

----------
/* Drops */
----------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Obtener_Rango_Etario') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Obtener_Rango_Etario
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Obtener_Tiempo') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Obtener_Tiempo
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Cumplio_Entrega_Estimada') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Cumplio_Entrega_Estimada
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Crear_Tiempo_Si_No_Existe') AND type in (N'P', N'PC'))
    DROP PROCEDURE EL_DROPEO.Crear_Tiempo_Si_No_Existe
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Migrar_Fechas') AND type in (N'P', N'PC'))
    DROP PROCEDURE EL_DROPEO.Migrar_Fechas
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
    inicio INT NOT NULL,
    fin INT NOT NULL
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
    cumplio_envio BIT NOT NULL,
    costo_envio DECIMAL(18,2) NOT NULL,
)

CREATE TABLE EL_DROPEO.BI_Hechos_Promociones
(
    tiempo_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tiempo(id),
    categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Categoria(id),
    promocion_aplicada_descuento DECIMAL(18,2) NOT NULL
)

CREATE TABLE EL_DROPEO.BI_Hechos_Pagos
(
    sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Sucursal(id),
    medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Medio_De_Pago(id),
    tiempo_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tiempo(id),
    cuotas_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Cuotas(id),
    cliente_re_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Rango_Etario(id),
    descuento_aplicado DECIMAL(18,2) NOT NULL,
    importe DECIMAL(18,2) NOT NULL
)

------------------------------
/* Migracion de dimensiones */
------------------------------

-- Popular tabla de rango etario
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (0, 24);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (25, 34);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (35, 49);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (55, 200);

-- Popular tabla de localidades
INSERT INTO EL_DROPEO.BI_Localidad (nombre)
SELECT DISTINCT nombre as nombre_localidad
FROM EL_DROPEO.Localidades;

-- Popular Medios de Pago

INSERT INTO EL_DROPEO.BI_Medio_De_Pago (nombre)
SELECT DISTINCT tipo_pago
FROM EL_DROPEO.Medios_De_Pago;

-- Popular Sucursales
INSERT INTO EL_DROPEO.BI_Sucursal (nombre)
SELECT DISTINCT nombre
FROM EL_DROPEO.Sucursales;

-- Popular Cuotas
INSERT INTO EL_DROPEO.BI_Cuotas (cantidad)
SELECT DISTINCT cuotas
FROM EL_DROPEO.Detalles;

-------------------------
/* Migracion de hechos */
-------------------------



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

    RETURN @rango_etario_id;
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

    IF @mes BETWEEN 1 AND 3
        SET @cuatrimestre = 1;
    ELSE IF @mes BETWEEN 4 AND 6
        SET @cuatrimestre = 2;
    ELSE IF @mes BETWEEN 7 AND 9
        SET @cuatrimestre = 3;
    ELSE
        SET @cuatrimestre = 4;

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

    IF (CAST(@fecha_entrega AS DATE) <= CAST(@fecha_programada AS DATE) AND 
        @hora_entrega BETWEEN @hora_inicio AND @hora_fin)
    BEGIN
        SET @cumplio = 1;
    END
    ELSE
    BEGIN
        SET @cumplio = 0;
    END

    RETURN @cumplio;
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

    IF @mes BETWEEN 1 AND 3
        SET @cuatrimestre = 1;
    ELSE IF @mes BETWEEN 4 AND 6
        SET @cuatrimestre = 2;
    ELSE IF @mes BETWEEN 7 AND 9
        SET @cuatrimestre = 3;
    ELSE
        SET @cuatrimestre = 4;

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
-- Popular tabla de rango etario
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (0, 24);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (25, 34);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (35, 49);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (50, 200);

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
INSERT INTO EL_DROPEO.BI_Turno (inicio, fin) VALUES (8, 12);
INSERT INTO EL_DROPEO.BI_Turno (inicio, fin) VALUES (12, 16);
INSERT INTO EL_DROPEO.BI_Turno (inicio, fin) VALUES (16, 20);

-- Migrar tipos de caja
INSERT INTO EL_DROPEO.BI_Tipo_Caja (nombre)
SELECT descripcion FROM EL_DROPEO.Tipos_Caja;

-------------------------
/* Migracion de hechos */
-------------------------
INSERT INTO EL_DROPEO.BI_Hechos_Envios (tiempo_id, localidad_id, cliente_re_id, cumplio_envio, costo_envio)
SELECT
    EL_DROPEO.Obtener_Tiempo(e.fecha_entrega) as tiempo_id,
    l.id as localidad_id,
    EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento) as cliente_re_id,
    EL_DROPEO.Cumplio_Entrega_Estimada(e.fecha_programada, e.fecha_entrega, e.hora_inicio, e.hora_fin) as cumplio_envio,
    e.costo
FROM EL_DROPEO.Envios e
INNER JOIN EL_DROPEO.Ventas v ON e.venta_id = v.id
INNER JOIN EL_DROPEO.Sucursales s ON v.caja_sucursal_id = s.id
INNER JOIN EL_DROPEO.Clientes c ON c.dni = EL_DROPEO.Buscar_Cliente(v.numero_ticket, s.nombre)
INNER JOIN EL_DROPEO.Ubicaciones u ON u.id = s.ubicacion_id
INNER JOIN EL_DROPEO.Localidades l ON l.id = u.localidad_id

INSERT INTO EL_DROPEO.BI_Hechos_Promociones (tiempo_id, categoria_id, promocion_aplicada_descuento)
SELECT 
	EL_DROPEO.Obtener_Tiempo(v.fecha_hora) as tiempo_id, 
	BI_c.id as categoria_id,
	pr.promocion_aplicada_descuento
FROM EL_DROPEO.Promociones_X_Items pr
LEFT JOIN EL_DROPEO.Items i ON i.id = item_id
LEFT JOIN EL_DROPEO.Ventas v ON v.id = i.venta_id
LEFT JOIN EL_DROPEO.Productos p ON p.id = i.producto_id
LEFT JOIN EL_DROPEO.Sub_Categorias s ON s.id = p.sub_categoria_id
LEFT JOIN EL_DROPEO.Categorias c ON c.id = s.categoria_id
LEFT JOIN EL_DROPEO.BI_Categoria BI_c ON c.nombre = BI_c.nombre
WHERE promocion_aplicada_descuento > 0

INSERT INTO EL_DROPEO.BI_Hechos_Pagos (sucursal_id, medio_de_pago_id, tiempo_id, cuotas_id, cliente_re_id, descuento_aplicado, importe)
SELECT 
    s.id as sucursal_id,
    mp.id as medio_de_pago_id,
    EL_DROPEO.Obtener_Tiempo(p.fecha) as tiempo_id,
    cuota.id as cuotas_id,
    EL_DROPEO.Obtener_Rango_Etario(c.fecha_nacimiento) as cliente_re_id,
    dp.descuento_aplicado,
    p.importe
FROM EL_DROPEO.Pagos p
JOIN EL_DROPEO.Medios_De_Pago m ON m.id = p.medio_de_pago_id
JOIN EL_DROPEO.Detalles d ON p.id = d.pago_id
JOIN EL_DROPEO.BI_Cuotas cuota ON cuota.cantidad = d.cuotas
JOIN EL_DROPEO.Ventas v on v.id = p.venta_id
JOIN EL_DROPEO.Cajas caja on caja.numero = v.caja_numero and caja.sucursal_id = v.caja_sucursal_id
JOIN EL_DROPEO.Sucursales s ON s.id = caja.sucursal_id
JOIN EL_DROPEO.Clientes c ON c.dni = EL_DROPEO.Buscar_Cliente(v.numero_ticket, s.nombre)
JOIN EL_DROPEO.Descuentos_Pagos dp ON dp.pago_id = p.id
JOIN EL_DROPEO.BI_Medio_De_Pago mp on mp.nombre = m.tipo_pago 
