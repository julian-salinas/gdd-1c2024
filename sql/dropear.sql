
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID(N'[EL_DROPEO].[MIGRACION]'))
DROP PROCEDURE EL_DROPEO.MIGRACION
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'EL_DROPEO')
DROP SCHEMA EL_DROPEO
GO
