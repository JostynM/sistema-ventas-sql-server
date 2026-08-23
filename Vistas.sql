
USE DB_GestionVentas;
GO


/* =========================================
              1. VISTA EMPLEADOS
                 CON SUCURSAL
   ========================================= */

CREATE VIEW vw_EmpleadosSucursal
AS
SELECT
    e.id_empleado,
    e.nombres,
    e.apellidos,
    e.cargo,
    e.salario,
    s.nombre AS sucursal,
    s.ciudad
FROM Empleado e
INNER JOIN Sucursal s
    ON e.id_sucursal = s.id_sucursal;
GO


/* =========================================
              2. VISTA PRODUCTOS
          CON CATEGORIA Y PROVEEDOR
   ========================================= */

CREATE VIEW vw_ProductosDetalle
AS
SELECT
    p.id_producto,
    p.nombre AS producto,
    p.descripcion,
    p.precio,
    c.nombre AS categoria,
    pr.razon_social AS proveedor,
    p.estado
FROM Producto p
INNER JOIN Categoria c
    ON p.id_categoria = c.id_categoria
INNER JOIN Proveedor pr
    ON p.id_proveedor = pr.id_proveedor;
GO


/* =========================================
              3. VISTA PEDIDOS
                 CON CLIENTE
   ========================================= */

CREATE VIEW vw_PedidosCliente
AS
SELECT
    p.id_pedido,
    c.nombres,
    c.apellidos,
    p.fecha_pedido,
    p.estado
FROM Pedido p
INNER JOIN Cliente c
    ON p.id_cliente = c.id_cliente;
GO


/* =========================================
             4. VISTA DETALLE
                  DE VENTAS
   ========================================= */

CREATE VIEW vw_DetalleVentas
AS
SELECT
    p.id_pedido,
    p.fecha_pedido,

    c.nombres AS nombre_cliente,
    c.apellidos AS apellido_cliente,

    e.nombres AS nombre_empleado,
    e.apellidos AS apellido_empleado,

    pr.nombre AS producto,

    dp.cantidad,
    dp.precio_unitario,
    dp.descuento,

    dp.cantidad * dp.precio_unitario
        AS subtotal,

    dp.cantidad * dp.precio_unitario *
    (1 - dp.descuento / 100.0)
        AS total_con_descuento,

    p.estado
FROM Pedido p
INNER JOIN Cliente c
    ON p.id_cliente = c.id_cliente
INNER JOIN Empleado e
    ON p.id_empleado = e.id_empleado
INNER JOIN Detalle_Pedido dp
    ON p.id_pedido = dp.id_pedido
INNER JOIN Producto pr
    ON dp.id_producto = pr.id_producto;
GO


/* =========================================
              5. VISTA INVENTARIO
                 POR SUCURSAL
   ========================================= */

CREATE VIEW vw_InventarioSucursal
AS
SELECT
    i.id_inventario,
    pr.nombre AS producto,
    s.nombre AS sucursal,
    i.stock_actual,
    i.stock_minimo,
    i.fecha_actualizacion
FROM Inventario i
INNER JOIN Producto pr
    ON i.id_producto = pr.id_producto
INNER JOIN Sucursal s
    ON i.id_sucursal = s.id_sucursal;
GO


/* =========================================
              6. VISTA STOCK BAJO
   ========================================= */

CREATE VIEW vw_ProductosStockBajo
AS
SELECT
    pr.nombre AS producto,
    s.nombre AS sucursal,
    i.stock_actual,
    i.stock_minimo
FROM Inventario i
INNER JOIN Producto pr
    ON i.id_producto = pr.id_producto
INNER JOIN Sucursal s
    ON i.id_sucursal = s.id_sucursal
WHERE i.stock_actual <= i.stock_minimo;
GO


/* =========================================
            CONSULTAR LAS VISTAS
   ========================================= */

SELECT *
FROM vw_EmpleadosSucursal;

SELECT *
FROM vw_ProductosDetalle;

SELECT *
FROM vw_PedidosCliente;

SELECT *
FROM vw_DetalleVentas;

SELECT *
FROM vw_InventarioSucursal;

SELECT *
FROM vw_ProductosStockBajo;
GO