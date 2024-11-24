USE COM2900G09
GO

EXEC deposito.InsertarCategoria @Descripcion = 'Electronic accessories'
GO

EXEC deposito.InsertarCategoria @Descripcion = 'Importados'
GO

EXEC deposito.InsertarCategoria @Descripcion = 'Descontinuado'
GO

EXEC deposito.InsertarProducto @Categoria = 3, @Nombre = 'Descontinuado', @Precio = 0, @PrecioReferencia = '0', @UnidadReferencia = '', @Fecha = GETDATE()
GO

USE master
GO