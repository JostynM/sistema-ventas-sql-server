USE DB_GestionVentas;
GO


/* =========================================
      1. PROCEDIMIENTO REGISTRAR CLIENTE
   ========================================= */

CREATE PROCEDURE sp_RegistrarCliente
    @nombres VARCHAR(100),
    @apellidos VARCHAR(100),
    @dni CHAR(8),
    @email VARCHAR(150),
    @telefono VARCHAR(20),
    @ciudad VARCHAR(100)
AS
BEGIN

    INSERT INTO Cliente
    (
        nombres,
        apellidos,
        dni,
        email,
        telefono,
        ciudad
    )
    VALUES
    (
        @nombres,
        @apellidos,
        @dni,
        @email,
        @telefono,
        @ciudad
    );

END;
GO

EXEC sp_RegistrarCliente
    @nombres = 'Fernando',
    @apellidos = 'Gomez',
    @dni = '72345678',
    @email = 'fernando@gmail.com',
    @telefono = '911222333',
    @ciudad = 'Lima';
GO


/* =========================================
      2. PROCEDIMIENTO CONSULTAR
         PEDIDOS POR CLIENTE
   ========================================= */

CREATE PROCEDURE sp_ConsultarPedidosCliente
    @id_cliente INT
AS
BEGIN
    SELECT
        p.id_pedido,
        c.nombres,
        c.apellidos,
        p.fecha_pedido,
        p.estado,
        dbo.fn_TotalPedido(p.id_pedido) AS total_pedido
    FROM Pedido p
    INNER JOIN Cliente c
        ON p.id_cliente = c.id_cliente
    WHERE p.id_cliente = @id_cliente;

END;
GO

/* =========================================
      3. PROCEDIMIENTO ACTUALIZAR
         ESTADO DE PEDIDO
   ========================================= */

CREATE OR ALTER PROCEDURE dbo.sp_ActualizarEstadoPedido
    @id_pedido INT,
    @nuevo_estado VARCHAR(30)
AS
BEGIN

    UPDATE Pedido
    SET estado = @nuevo_estado
    WHERE id_pedido = @id_pedido;

END;
GO

EXEC dbo.sp_ActualizarEstadoPedido
    @id_pedido = 5,
    @nuevo_estado = 'Enviado';
GO

SELECT *
FROM Pedido
WHERE id_pedido = 5;