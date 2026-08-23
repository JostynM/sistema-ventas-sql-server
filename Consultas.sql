USE DB_GestionVentas;
GO


/* =========================================
          1. CONSULTAS BASICAS
   ========================================= */

-- Mostrar todos los clientes
SELECT *
FROM Cliente;


-- Mostrar columnas específicas
SELECT nombres, apellidos, ciudad
FROM Cliente;


-- Clientes que viven en Lima
SELECT *
FROM Cliente
WHERE ciudad = 'Lima';


-- Productos con precio mayor a S/ 500
SELECT nombre, precio
FROM Producto
WHERE precio > 500;


-- Productos ordenados del más caro al más barato
SELECT nombre, precio
FROM Producto
ORDER BY precio DESC;


/* =========================================
          2. TOP Y DISTINCT
   ========================================= */

-- Los 5 productos más caros
SELECT TOP 5
    nombre,
    precio
FROM Producto
ORDER BY precio DESC;


-- Mostrar ciudades sin repetir
SELECT DISTINCT ciudad
FROM Cliente;


/* =========================================
              3. LIKE
   ========================================= */

-- Productos cuyo nombre comienza con Lenovo
SELECT *
FROM Producto
WHERE nombre LIKE 'Lenovo%';


-- Productos que contienen la palabra Logitech
SELECT *
FROM Producto
WHERE nombre LIKE '%Logitech%';


/* =========================================
          4. FUNCIONES AGREGADAS
   ========================================= */

-- Cantidad total de clientes
SELECT COUNT(*) AS total_clientes
FROM Cliente;


-- Precio promedio de productos
SELECT AVG(precio) AS precio_promedio
FROM Producto;


-- Producto más caro
SELECT MAX(precio) AS precio_maximo
FROM Producto;


-- Producto más barato
SELECT MIN(precio) AS precio_minimo
FROM Producto;


/* =========================================
              5. GROUP BY
   ========================================= */

-- Cantidad de clientes por ciudad
SELECT
    ciudad,
    COUNT(*) AS cantidad_clientes
FROM Cliente
GROUP BY ciudad;


-- Cantidad de empleados por sucursal
SELECT
    id_sucursal,
    COUNT(*) AS cantidad_empleados
FROM Empleado
GROUP BY id_sucursal;


/* =========================================
              6. HAVING
   ========================================= */

-- Ciudades que tienen más de un cliente
SELECT
    ciudad,
    COUNT(*) AS cantidad_clientes
FROM Cliente
GROUP BY ciudad
HAVING COUNT(*) > 1;

/* =========================================
              7. INNER JOIN
   ========================================= */

-- Mostrar empleados junto con su sucursal
SELECT
    e.nombres,
    e.apellidos,
    s.nombre AS sucursal
FROM Empleado e
INNER JOIN Sucursal s
    ON e.id_sucursal = s.id_sucursal;

    /* =========================================
              8. LEFT JOIN
   ========================================= */

-- Mostrar todos los clientes y sus pedidos
SELECT
    c.nombres,
    c.apellidos,
    p.id_pedido,
    p.estado
FROM Cliente c
LEFT JOIN Pedido p
    ON c.id_cliente = p.id_cliente;

    /* =========================================
              9. SUBCONSULTAS
   ========================================= */

-- Mostrar productos con precio mayor al promedio
SELECT
    nombre,
    precio
FROM Producto
WHERE precio > (
    SELECT AVG(precio)
    FROM Producto
);

-- Mostrar clientes que tienen pedidos
SELECT
    nombres,
    apellidos
FROM Cliente
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Pedido
);


-- Mostrar productos que aparecen en algún pedido
SELECT
    nombre,
    precio
FROM Producto
WHERE id_producto IN (
    SELECT id_producto
    FROM Detalle_Pedido
);


-- Mostrar empleados que han atendido pedidos
SELECT
    nombres,
    apellidos,
    cargo
FROM Empleado
WHERE id_empleado IN (
    SELECT id_empleado
    FROM Pedido
);

/* =========================================
                10. CTE
   ========================================= */

-- Mostrar productos con precio mayor al promedio usando CTE
WITH PromedioPrecio AS (
    SELECT AVG(precio) AS precio_promedio
    FROM Producto
)
SELECT
    p.nombre,
    p.precio
FROM Producto p
CROSS JOIN PromedioPrecio pp
WHERE p.precio > pp.precio_promedio;

/* =========================================
          11. WINDOW FUNCTIONS
   ========================================= */

-- Numerar productos del más caro al más barato
SELECT
    nombre,
    precio,
    ROW_NUMBER() OVER (
        ORDER BY precio DESC
    ) AS posicion
FROM Producto;

/* =========================================
          13. SUM() OVER()
   ========================================= */

-- Mostrar productos y acumular sus precios
SELECT
    nombre,
    precio,
    SUM(precio) OVER (
        ORDER BY precio
    ) AS total_acumulado
FROM Producto;

/* =========================================
              14. LAG()
   ========================================= */

-- Comparar el precio de cada producto con el producto anterior
SELECT
    nombre,
    precio,
    LAG(precio) OVER (
        ORDER BY precio
    ) AS precio_anterior
FROM Producto;

/* =========================================
          15. CONSULTAS DE NEGOCIO
   ========================================= */


/* 1. CLIENTE CON MAYOR CANTIDAD DE PEDIDOS */

SELECT TOP 1 WITH TIES
    c.nombres,
    c.apellidos,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM Cliente c
INNER JOIN Pedido p
    ON c.id_cliente = p.id_cliente
GROUP BY
    c.nombres,
    c.apellidos
ORDER BY COUNT(p.id_pedido) DESC;


/* 2. PRODUCTO MAS VENDIDO */

SELECT TOP 1 WITH TIES
    pr.nombre AS producto,
    SUM(dp.cantidad) AS unidades_vendidas
FROM Producto pr
INNER JOIN Detalle_Pedido dp
    ON pr.id_producto = dp.id_producto
INNER JOIN Pedido p
    ON dp.id_pedido = p.id_pedido
WHERE p.estado <> 'Cancelado'
GROUP BY pr.nombre
ORDER BY SUM(dp.cantidad) DESC;


/* 3. TOTAL VENDIDO POR CLIENTE */

SELECT
    c.nombres,
    c.apellidos,
    SUM(
        dp.cantidad * dp.precio_unitario *
        (1 - dp.descuento / 100.0)
    ) AS total_comprado
FROM Cliente c
INNER JOIN Pedido p
    ON c.id_cliente = p.id_cliente
INNER JOIN Detalle_Pedido dp
    ON p.id_pedido = dp.id_pedido
WHERE p.estado <> 'Cancelado'
GROUP BY
    c.nombres,
    c.apellidos
ORDER BY total_comprado DESC;


/* 4. VENTAS REALIZADAS POR EMPLEADO */

SELECT
    e.nombres,
    e.apellidos,
    COUNT(DISTINCT p.id_pedido) AS cantidad_pedidos,
    SUM(
        dp.cantidad * dp.precio_unitario *
        (1 - dp.descuento / 100.0)
    ) AS total_vendido
FROM Empleado e
INNER JOIN Pedido p
    ON e.id_empleado = p.id_empleado
INNER JOIN Detalle_Pedido dp
    ON p.id_pedido = dp.id_pedido
WHERE p.estado <> 'Cancelado'
GROUP BY
    e.nombres,
    e.apellidos
ORDER BY total_vendido DESC;


/* 5. VENTAS POR SUCURSAL */

SELECT
    s.nombre AS sucursal,
    SUM(
        dp.cantidad * dp.precio_unitario *
        (1 - dp.descuento / 100.0)
    ) AS total_vendido
FROM Sucursal s
INNER JOIN Empleado e
    ON s.id_sucursal = e.id_sucursal
INNER JOIN Pedido p
    ON e.id_empleado = p.id_empleado
INNER JOIN Detalle_Pedido dp
    ON p.id_pedido = dp.id_pedido
WHERE p.estado <> 'Cancelado'
GROUP BY s.nombre
ORDER BY total_vendido DESC;


/* 6. PRODUCTOS CON STOCK BAJO */

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
WHERE i.stock_actual <= i.stock_minimo
ORDER BY i.stock_actual;


/* 7. TOTAL PAGADO POR METODO DE PAGO */

SELECT
    metodo_pago,
    COUNT(*) AS cantidad_pagos,
    SUM(monto) AS total_pagado
FROM Pago
GROUP BY metodo_pago
ORDER BY total_pagado DESC;


/* 8. CATEGORIA CON MAS UNIDADES VENDIDAS */

SELECT TOP 1 WITH TIES
    c.nombre AS categoria,
    SUM(dp.cantidad) AS unidades_vendidas
FROM Categoria c
INNER JOIN Producto pr
    ON c.id_categoria = pr.id_categoria
INNER JOIN Detalle_Pedido dp
    ON pr.id_producto = dp.id_producto
INNER JOIN Pedido p
    ON dp.id_pedido = p.id_pedido
WHERE p.estado <> 'Cancelado'
GROUP BY c.nombre
ORDER BY SUM(dp.cantidad) DESC;


/* 9. CANTIDAD DE PEDIDOS POR ESTADO */

SELECT
    estado,
    COUNT(*) AS cantidad_pedidos
FROM Pedido
GROUP BY estado
ORDER BY cantidad_pedidos DESC;


/* 10. RANKING DE PRODUCTOS POR INGRESOS */

SELECT
    producto,
    total_vendido,
    RANK() OVER (
        ORDER BY total_vendido DESC
    ) AS ranking
FROM (
    SELECT
        pr.nombre AS producto,
        SUM(
            dp.cantidad * dp.precio_unitario *
            (1 - dp.descuento / 100.0)
        ) AS total_vendido
    FROM Producto pr
    INNER JOIN Detalle_Pedido dp
        ON pr.id_producto = dp.id_producto
    INNER JOIN Pedido p
        ON dp.id_pedido = p.id_pedido
    WHERE p.estado <> 'Cancelado'
    GROUP BY pr.nombre
) AS ventas_productos;