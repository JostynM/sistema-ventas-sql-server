USE DB_GestionVentas;
GO


/* =========================================
        1. FUNCION CALCULAR TOTAL
           CON DESCUENTO
   ========================================= */

CREATE FUNCTION fn_CalcularTotalDescuento
(
    @cantidad INT,
    @precio DECIMAL(10,2),
    @descuento DECIMAL(5,2)
)
RETURNS DECIMAL(12,2)
AS
BEGIN

    DECLARE @total DECIMAL(12,2);

    SET @total =
        @cantidad * @precio *
        (1 - @descuento / 100.0);

    RETURN @total;

END;
GO


/* =========================================
        2. FUNCION TOTAL DEL PEDIDO
   ========================================= */

CREATE FUNCTION fn_TotalPedido
(
    @id_pedido INT
)
RETURNS DECIMAL(12,2)
AS
BEGIN

    DECLARE @total DECIMAL(12,2);

    SELECT @total = SUM(
        cantidad * precio_unitario *
        (1 - descuento / 100.0)
    )
    FROM Detalle_Pedido
    WHERE id_pedido = @id_pedido;

    RETURN ISNULL(@total, 0);

END;
GO


/* =========================================
        3. FUNCION STOCK TOTAL
           DE UN PRODUCTO
   ========================================= */

CREATE FUNCTION fn_StockTotalProducto
(
    @id_producto INT
)
RETURNS INT
AS
BEGIN

    DECLARE @stock_total INT;

    SELECT @stock_total = SUM(stock_actual)
    FROM Inventario
    WHERE id_producto = @id_producto;

    RETURN ISNULL(@stock_total, 0);

END;
GO


/* =========================================
           PRUEBA DE FUNCIONES
   ========================================= */

-- Probar cálculo con descuento
SELECT dbo.fn_CalcularTotalDescuento(
    2,
    100,
    10
) AS total_con_descuento;


-- Probar total del pedido 1
SELECT dbo.fn_TotalPedido(1)
AS total_pedido;


-- Probar stock total del producto 1
SELECT dbo.fn_StockTotalProducto(1)
AS stock_total;


/* =========================================
       USAR FUNCION EN UNA CONSULTA
   ========================================= */

-- Calcular el total de cada detalle de pedido
SELECT
    id_detalle,
    id_pedido,
    id_producto,
    cantidad,
    precio_unitario,
    descuento,

    dbo.fn_CalcularTotalDescuento(
        cantidad,
        precio_unitario,
        descuento
    ) AS total

FROM Detalle_Pedido;
GO


/* =========================================
     MOSTRAR TOTAL DE TODOS LOS PEDIDOS
   ========================================= */

SELECT
    id_pedido,
    id_cliente,
    fecha_pedido,
    estado,
    dbo.fn_TotalPedido(id_pedido) AS total_pedido
FROM Pedido;
GO


/* =========================================
      MOSTRAR STOCK TOTAL DE PRODUCTOS
   ========================================= */

SELECT
    id_producto,
    nombre,
    precio,
    dbo.fn_StockTotalProducto(id_producto) AS stock_total
FROM Producto;
GO