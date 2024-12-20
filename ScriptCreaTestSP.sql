/*
Script para probar varios SP
la prueba debe:
Cargar cargos, medios de Pago, tipos de cliente,Datos facturacion
Cargar 3 categorias
Cargar 5 productos
Cargar 2 sucursales
Cargar 2 empleados
Cargar 2 clientes

*/
use COM2900G09
go

CREATE OR ALTER PROCEDURE test.CargarDatos 
AS
BEGIN
	DECLARE @FechaActual DATETIME;
	SET @FechaActual = GETDATE();
	--Datos Facturacion
	EXEC facturacion.ConfigurarDatosFacturacion @CUIT='00123456789', @FechaInicio=@FechaActual, @RazonSocial='Aurora S.A.'
	--Empleado: Cargo
	EXEC infraestructura.InsertarCargo @descripcion='Cajero'				--1
	EXEC infraestructura.InsertarCargo @descripcion='Supervisor'			--2
	EXEC infraestructura.InsertarCargo @descripcion='Gerente de Sucursal'	--3
	--Medios de pago
	EXEC facturacion.insertarMedioDePago @nombre='Credit card',@descripcion='Tarjeta de credito'	--1
	EXEC facturacion.insertarMedioDePago @nombre='Cash',@descripcion='Efectivo'						--2
	EXEC facturacion.insertarMedioDePago @nombre='Ewallet',@descripcion='Billetera Electronica'		--3
	--Categorias
	EXEC deposito.InsertarCategoria @descripcion = 'Perfumeria'		--1
	EXEC deposito.InsertarCategoria @descripcion = 'Almacen'		--2
	EXEC deposito.InsertarCategoria @descripcion = 'Electronicos'	--3
	--Productos
	EXEC deposito.InsertarProducto 
		@Categoria = 2,
		@Nombre = 'Aceite de Oliva',
		@Precio = 2250,
		@PrecioReferencia = 2.25,
		@UnidadReferencia = 'ml',
		@Fecha = @FechaActual;
	EXEC deposito.InsertarProducto 
		@Categoria = 2,
		@Nombre = 'Fideos Mamamama',
		@Precio = 500,
		@PrecioReferencia = 0.5,
		@UnidadReferencia = 'gr',
		@Fecha = @FechaActual;
	EXEC deposito.InsertarProducto 
		@Categoria = 1,
		@Nombre = 'Desodorante alcantarilla',
		@Precio = 1950,
		@PrecioReferencia = 10,
		@UnidadReferencia = 'ml',
		@Fecha = @FechaActual;
	EXEC deposito.InsertarProducto 
		@Categoria = 1,
		@Nombre = 'Perfume Paco',
		@Precio = 2100,
		@PrecioReferencia = 10.5,
		@UnidadReferencia = 'ml',
		@Fecha = @FechaActual;
	EXEC deposito.InsertarProducto 
		@Categoria = 3,
		@Nombre = 'Televisor Ultravision',
		@Precio = 125000,
		@PrecioReferencia = 125000,
		@UnidadReferencia = 'U',
		@Fecha = @FechaActual;
	--Sucursales
	EXEC infraestructura.InsertarSucursal 
		@Direccion = 'Av. Brig. Gral. Juan Manuel de Rosas 3634, B1754 San Justo, Provincia de Buenos Aires',
		@Ciudad = 'San Justo',
		@Horario = 'L a V 8 a. m.–9 p. m.S y D 9 a. m.-8 p. m.',
		@Telefono = '5555-5551'
	EXEC infraestructura.InsertarSucursal 
		@Direccion = 'Av. de Mayo 791, B1704 Ramos Mejía, Provincia de Buenos Aires',
		@Ciudad = 'Ramos Mejia',
		@Horario = 'L a V 8 a. m.–9 p. m.S y D 9 a. m.-8 p. m.',
		@Telefono = '5555-5552'
	--Empleados
	EXEC infraestructura.insertarEmpleado
		@Legajo = 257020,
		@Nombre = 'Romina Alejandra',
		@Apellido = 'Alias',
		@DNI=36383025,
		@Direccion='Bernardo de Irigoyen 2647, San Isidro, Buenos Aires',
		@EmailPersonal='RominaAlejandra_ALIAS@gmail.com',
		@EmailEmpresa='RominaAlejandra.ALIAS@superA.com',
		@CUIL='0',
		@Turno='TM',
		@Cargo= 1,
		@Sucursal= 1
	EXEC infraestructura.insertarEmpleado
		@Legajo = 257025,
		@Nombre = 'Rolando',
		@Apellido = 'Lopez',
		@DNI = 29943254,
		@Direccion = 'Av. Rivadavia 6538, Ciudad Autónoma de Buenos Aires, Ciudad Autónoma de Buenos Aires',
		@EmailPersonal = 'Rolando_LOPEZ@gmail.com',
		@EmailEmpresa ='Rolando.LOPEZ@superA.com',
		@CUIL = '0',
		@Turno = 'TT',
		@Cargo = 2,
		@Sucursal = 2
END
GO

CREATE OR ALTER PROCEDURE test.CrearClientes
AS
BEGIN
	--Cliente: Tipo
	EXEC facturacion.InsertarTipoCliente @nombre='Member'--1
	EXEC facturacion.InsertarTipoCliente @nombre='Normal'--2
	--Clientes: Femenino member (con CUIL)
	EXEC facturacion.InsertarCliente 
		@DNI = 11111111,
		@CUIL = '00111111110',
		@Nombre = 'Marta',
		@Apellido = 'Lopez',
		@Genero = 'F',
		@idtipoCliente = 1
	--Clientes: Femenino normal (sin CUIL)
	EXEC facturacion.InsertarCliente 
		@DNI = 22222222,
		@Nombre = 'Juana',
		@Apellido = 'Gonzalez',
		@Genero = 'F',
		@idtipoCliente = 2
	--Clientes: Masculino member (con CUIL)
	EXEC facturacion.InsertarCliente 
		@DNI = 11111112,
		@CUIL = '00111111120',
		@Nombre = 'Franco',
		@Apellido = 'Locatimpo',
		@Genero = 'M',
		@idtipoCliente = 1
	--Clientes: Masculino normal (sin CUIL)
	EXEC facturacion.InsertarCliente 
		@DNI = 22222221,
		@Nombre = 'Mauro',
		@Apellido = 'Vigliano',
		@Genero = 'M',
		@idtipoCliente = 2
END
GO

CREATE OR ALTER PROCEDURE test.CrearVentas
AS
BEGIN
	DECLARE @IDVenta INT
	--VENTA 1
	EXEC facturacion.iniciarVenta @Cliente = 1, @Empleado=257020, @ID = @IDVenta OUTPUT
	EXEC facturacion.InsertarLineaVenta @IdVenta, @idProducto = 5, @Cantidad = 1
	EXEC facturacion.InsertarLineaVenta @IdVenta, @idProducto = 98, @Cantidad = 3
	EXEC facturacion.InsertarLineaVenta @IdVenta, @idProducto = 209, @Cantidad = 1
	EXEC facturacion.CerrarVenta @ID = @Idventa
	--VENTA 2
	EXEC facturacion.iniciarVenta @Cliente = 4, @Empleado=257022, @ID = @IDVenta OUTPUT
	EXEC facturacion.InsertarLineaVenta @IdVenta, @idProducto = 212, @Cantidad = 5
	EXEC facturacion.InsertarLineaVenta @IdVenta, @idProducto = 5777, @Cantidad = 12
	EXEC facturacion.CerrarVenta @ID = @Idventa
END
GO


/*
EXEC test.CrearClientes
EXEC test.CrearVentas
exec facturacion.EliminarVenta 1001

select * from facturacion.cliente
select * from facturacion.Venta
select * from facturacion.lineaVenta
select * from facturacion.factura
*/
