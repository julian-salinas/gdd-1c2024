USE GD1C2024
GO

----------
/* Drops */
----------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.BI_Cumplimiento_Envio') AND type in (N'U'))
    DROP TABLE EL_DROPEO.BI_Cumplimiento_Envio
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Obtener_Rango_Etario') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION EL_DROPEO.Obtener_Rango_Etario
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EL_DROPEO.Obtener_O_Crear_Tiempo') AND type in (N'P', N'PC'))
    DROP PROCEDURE EL_DROPEO.Obtener_O_Crear_Tiempo
GO

------------------------------
/* Creacion de dimensiones */
------------------------------

CREATE TABLE EL_DROPEO.BI_Cumplimiento_Envio(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    cumplio BIT NOT NULL
)

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

------------------------
/* Creacion de hechos */
------------------------

CREATE TABLE EL_DROPEO.BI_Hechos_Envios
(
    tiempo_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Tiempo(id),
    localidad_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Localidad(id),
    cliente_re_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Rango_Etario(id),
    cumplimiento_envio_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.BI_Cumplimiento_Envio(id),
    costo_envio DECIMAL(18,2) NOT NULL,
)

------------------------------
/* Migracion de dimensiones */
------------------------------

-- Popular tabla de cumplimiento de envio
INSERT INTO EL_DROPEO.BI_Cumplimiento_Envio(cumplio) VALUES (0);
INSERT INTO EL_DROPEO.BI_Cumplimiento_Envio(cumplio) VALUES (1);

-- Popular tabla de rango etario
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (0, 24);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (25, 34);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (35, 49);
INSERT INTO EL_DROPEO.BI_Rango_Etario (inicio, fin) VALUES (55, 200);

-- Popular tabla de localidades
INSERT INTO EL_DROPEO.BI_Localidad (nombre)
SELECT DISTINCT nombre as nombre_localidad
FROM EL_DROPEO.Localidades;

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

----------------
/* Procedures */
----------------
GO
CREATE PROCEDURE EL_DROPEO.Obtener_O_Crear_Tiempo
    @fecha DATETIME,
    @tiempo_id INT OUTPUT
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