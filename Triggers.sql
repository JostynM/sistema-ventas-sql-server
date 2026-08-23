USE DB_GestionVentas;
GO


/* =========================================
   1. ACTUALIZAR FECHA DEL INVENTARIO
   ========================================= */

CREATE OR ALTER TRIGGER dbo.tr_ActualizarFechaInventario
ON Inventario
AFTER UPDATE
AS
BEGIN

    IF NOT UPDATE(stock_actual)
        RETURN;

    UPDATE i
    SET fecha_actualizacion = GETDATE()
    FROM Inventario i
    INNER JOIN inserted ins
        ON i.id_inventario = ins.id_inventario;

END;
GO

SELECT *
FROM Inventario
WHERE id_inventario = 1;

UPDATE Inventario
SET stock_actual = 20
WHERE id_inventario = 1;

UPDATE Inventario
SET stock_actual = stock_actual - 2
WHERE id_inventario = 1;

/* =========================================
   2. DESCONTAR STOCK AL REGISTRAR UNA VENTA
   ========================================= */

CREATE OR ALTER TRIGGER dbo.tr_DescontarStockVenta
ON Detalle_Pedido
AFTER INSERT
AS
BEGIN

    -- Verificar si hay suficiente stock
    IF EXISTS
    (
        SELECT 1
        FROM inserted ins

        INNER JOIN Pedido pe
            ON ins.id_pedido = pe.id_pedido

        INNER JOIN Empleado e
            ON pe.id_empleado = e.id_empleado

        INNER JOIN Inventario inv
            ON inv.id_producto = ins.id_producto
            AND inv.id_sucursal = e.id_sucursal

        GROUP BY
            inv.id_producto,
            inv.id_sucursal,
            inv.stock_actual

        HAVING inv.stock_actual < SUM(ins.cantidad)
    )
    BEGIN
        THROW 50001, 'Stock insuficiente para realizar la venta.', 1;
    END;



    -- Descontar el stock
    UPDATE inv
    SET inv.stock_actual =
        inv.stock_actual - ventas.cantidad_vendida

    FROM Inventario inv

    INNER JOIN
    (
        SELECT
            ins.id_producto,
            e.id_sucursal,
            SUM(ins.cantidad) AS cantidad_vendida

        FROM inserted ins

        INNER JOIN Pedido pe
            ON ins.id_pedido = pe.id_pedido

        INNER JOIN Empleado e
            ON pe.id_empleado = e.id_empleado

        GROUP BY
            ins.id_producto,
            e.id_sucursal

    ) ventas
        ON inv.id_producto = ventas.id_producto
        AND inv.id_sucursal = ventas.id_sucursal;

END;
GO


