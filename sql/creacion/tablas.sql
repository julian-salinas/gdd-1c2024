USE GD1C2024
GO

CREATE PROCEDURE EL_DROPEO.MIGRACION AS BEGIN

/*
 Creación de tablas
*/

CREATE TABLE EL_DROPEO.Provincia(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Localidad(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	provincia_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Provincia
)

CREATE TABLE EL_DROPEO.Ubicacion(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	calle NVARCHAR(255) NOT NULL,
	altura INT NOT NULL,
	localidad_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Localidad
)

CREATE TABLE EL_DROPEO.Condicion_Fiscal(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Supermercado(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	razon_social NVARCHAR(255) NOT NULL,
	cuit NVARCHAR(255) NOT NULL UNIQUE,
	iibb INT NOT NULL,
	ubicacion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ubicacion
	fecha_inicio DATETIME NOT NULL,
	condicion_fiscal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Condicion_Fiscal
)

CREATE TABLE EL_DROPEO.Sucursal(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ubicacion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ubicacion,
	supermercado_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Supermercado
)

CREATE TABLE EL_DROPEO.Tipo_Caja(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
)

CREATE TABLE EL_DROPEO.Caja(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_caja_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Tipo_Caja,
	sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sucursal
)

CREATE TABLE EL_DROPEO.Cliente(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,	
	apellido NVARCHAR(255) NOT NULL,
	dni INT NOT NULL UNIQUE,
	fecha_registro DATETIME,
	telefono INT,
	mail NVARCHAR(255),
	fecha_nacimiento DATE,
	ubicacion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ubicacion
)

CREATE TABLE EL_DROPEO.Comprobante(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_comprobante NVARCHAR(255) NOT NULL,
)

CREATE TABLE EL_DROPEO.Empleado(
	legajo INT NOT NULL PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	apellido NVARCHAR(255) NOT NULL,
	dni INT NOT NULL UNIQUE,
	fecha_registro DATETIME,
	sucursal_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sucursal,
	telefono INT,
	mail NVARCHAR(255),
	fecha_nacimiento DATE
)

CREATE TABLE EL_DROPEO.Ventas(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha DATETIME NOT NULL,
	comprobante_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Comprobante,
	caja_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Caja,
	empleado_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Empleado
)

CREATE TABLE EL_DROPEO.Medio_De_Pago(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Detalle(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cliente_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Cliente,
	numero_tarjeta INT NOT NULL,
	vencimiento_tarjeta DATE NOT NULL,
	cuotas INT NOT NULL
)

CREATE TABLE EL_DROPEO.Pagos(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha DATETIME NOT NULL,
	importe DECIMAL(18, 2) NOT NULL,
	venta_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ventas,
	medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Medio_De_Pago,
	detalle_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Detalle
)

CREATE TABLE EL_DROPEO.Descuentos(
	codigo INT NOT NULL PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	monto DECIMAL(18, 2) NOT NULL,
	tope DECIMAL(18, 2) NOT NULL,
	medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Medio_De_Pago
)

CREATE TABLE EL_DROPEO.Marca(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Categoria(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Sub_Categoria(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Categoria,
	nombre NVARCHAR(255) NOT NULL
)

CREATE TABLE EL_DROPEO.Producto(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
	descricion NVARCHAR(255) NOT NULL,
	precio DECIMAL(18, 2) NOT NULL,
	marca_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Marca,
	sub_categoria_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Sub_Categoria
)

CREATE TABLE EL_DROPEO.Item(
	venta_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Ventas,
	producto_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Producto,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(18, 2) NOT NULL,
	PRIMARY KEY(venta_id, producto_id)
)

CREATE TABLE EL_DROPEO.Promocion(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
)

CREATE TABLE EL_DROPEO.Regla(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descripcion NVARCHAR(255) NOT NULL,
	cantidad_aplicable_descuento DECIMAL(18, 2) NOT NULL,
	cantidad_aplicable_regla INT NOT NULL,
	cantidad_maxima INT NOT NULL,
	misma_marca BIT NOT NULL,
	mismo_producto BIT NOT NULL,
	promocion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Promocion
)

CREATE TABLE EL_DROPEO.Promocion_Producto(
	promocion_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Promocion,
	producto_id INT NOT NULL FOREIGN KEY REFERENCES EL_DROPEO.Producto,
	PRIMARY KEY(promocion_id, producto_id)
)

END
