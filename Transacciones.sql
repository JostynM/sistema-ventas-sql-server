USE DB_GestionVentas;
GO


/* =========================================
   1. TRANSACCIÓN CON ROLLBACK
   ========================================= */

BEGIN TRANSACTION;

UPDATE Inventario
SET stock_actual = stock_actual - 2
WHERE id_inventario = 1;

SELECT *
FROM Inventario
WHERE id_inventario = 1;

ROLLBACK;
GO


/* =========================================
   2. TRANSACCIÓN CON COMMIT
   ========================================= */

BEGIN TRANSACTION;

UPDATE Pedido
SET estado = 'Pagado'
WHERE id_pedido = 5;

COMMIT;
GO

SELECT * FROM Pedido

/* =========================================
   3. TRANSACCIÓN PARA REGISTRAR UNA VENTA
   ========================================= */

BEGIN TRY

    BEGIN TRANSACTION;

    -- 1. Crear el pedido
    INSERT INTO Pedido
    (
        id_cliente,
        id_empleado,
        estado
    )
    VALUES
    (
        1,
        1,
        'Pagado'
    );


    -- Guardar el ID del pedido recién creado
    DECLARE @id_pedido INT;

    SET @id_pedido = SCOPE_IDENTITY();


    -- 2. Registrar el producto vendido
    INSERT INTO Detalle_Pedido
    (
        id_pedido,
        id_producto,
        cantidad,
        precio_unitario,
        descuento
    )
    VALUES
    (
        @id_pedido,
        5,
        1,
        249,
        0
    );


    -- 3. Registrar el pago
    INSERT INTO Pago
    (
        id_pedido,
        metodo_pago,
        monto
    )
    VALUES
    (
        @id_pedido,
        'Yape',
        249
    );


    -- Si todo salió bien
    COMMIT;

    PRINT 'Venta registrada correctamente.';

END TRY

BEGIN CATCH

    -- Si ocurre algún error
    IF @@TRANCOUNT > 0
        ROLLBACK;

    PRINT 'Ocurrió un error. Se deshicieron los cambios.';

    THROW;

END CATCH;
GO  

SELECT @@TRANCOUNT AS transacciones_abiertas;

SELECT TOP 5 *
FROM Pedido
ORDER BY id_pedido DESC;

SELECT TOP 5 *
FROM Pedido
ORDER BY id_pedido DESC;

SELECT TOP 5 *
FROM Detalle_Pedido
ORDER BY id_detalle DESC;

SELECT TOP 5 *
FROM Pago
ORDER BY id_pago DESC;