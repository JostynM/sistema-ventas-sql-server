USE DB_GestionVentas;
GO


/* =========================================
                CLIENTES
   ========================================= */

INSERT INTO Cliente
(nombres, apellidos, dni, email, telefono, ciudad)
VALUES
('Carlos', 'Ramirez', '76543210', 'carlos@gmail.com', '987654321', 'Lima'),
('Andrea', 'Torres', '74859632', 'andrea@gmail.com', '912345678', 'Arequipa'),
('Luis', 'Mendoza', '70123456', 'luis@gmail.com', '956789123', 'Trujillo'),
('Maria', 'Lopez', '73456789', 'maria@gmail.com', '923456789', 'Lima'),
('Pedro', 'Castro', '71234567', 'pedro@gmail.com', '978654321', 'Cusco');
GO


/* =========================================
                SUCURSALES
   ========================================= */

INSERT INTO Sucursal
(nombre, ciudad, direccion, telefono)
VALUES
('Lima Centro', 'Lima', 'Av. Arequipa 1200', '014567890'),
('San Isidro', 'Lima', 'Av. Javier Prado 2500', '014567891'),
('Miraflores', 'Lima', 'Av. Larco 850', '014567892');
GO


/* =========================================
                CATEGORIAS
   ========================================= */

INSERT INTO Categoria
(nombre, descripcion)
VALUES
('Laptops', 'Computadoras portátiles'),
('Monitores', 'Monitores para computadoras'),
('Accesorios', 'Accesorios y periféricos'),
('Almacenamiento', 'Discos duros, SSD y memorias'),
('Componentes', 'Componentes internos para computadoras');
GO


/* =========================================
                PROVEEDORES
   ========================================= */

INSERT INTO Proveedor
(razon_social, ruc, telefono, email, direccion)
VALUES
('Lenovo Peru SAC', '20123456789', '987111111',
 'ventas@lenovo.com', 'Av. Javier Prado 1500, Lima'),

('Logitech Peru SAC', '20987654321', '987222222',
 'ventas@logitech.com', 'Av. Arequipa 2100, Lima'),

('Kingston Technology SAC', '20456789123', '987333333',
 'ventas@kingston.com', 'Av. República de Panamá 3500, Lima'),

('Samsung Peru SAC', '20678912345', '987444444',
 'ventas@samsung.com', 'Av. Canaval y Moreyra 450, Lima');
GO


/* =========================================
                EMPLEADOS
   ========================================= */

INSERT INTO Empleado
(nombres, apellidos, dni, email, telefono, cargo, salario, id_sucursal)
VALUES
('Jorge', 'Salazar', '74561230', 'jorge@empresa.com',
 '951111111', 'Vendedor', 1800.00, 1),

('Lucia', 'Fernandez', '75612340', 'lucia@empresa.com',
 '952222222', 'Vendedor', 1800.00, 2),

('Miguel', 'Rojas', '76723450', 'miguel@empresa.com',
 '953333333', 'Administrador', 3200.00, 1),

('Daniela', 'Vargas', '77834560', 'daniela@empresa.com',
 '954444444', 'Vendedor', 1900.00, 3),

('Renato', 'Silva', '78945670', 'renato@empresa.com',
 '955555555', 'Supervisor', 2500.00, 2),

('Camila', 'Herrera', '79056781', 'camila@empresa.com',
 '956666666', 'Vendedor', 1850.00, 3);
GO


/* =========================================
                PRODUCTOS
   ========================================= */

INSERT INTO Producto
(nombre, descripcion, precio, id_categoria, id_proveedor)
VALUES
('Lenovo IdeaPad 3', 'Laptop Ryzen 5, 8GB RAM, SSD 512GB', 2199.00, 1, 1),
('Lenovo ThinkPad E14', 'Laptop empresarial Intel Core i5', 3299.00, 1, 1),
('Samsung Odyssey G5', 'Monitor gaming 27 pulgadas', 1299.00, 2, 4),
('Samsung Essential Monitor', 'Monitor Full HD 24 pulgadas', 649.00, 2, 4),
('Mouse Logitech G502', 'Mouse gaming de alto rendimiento', 249.00, 3, 2),
('Teclado Logitech K380', 'Teclado inalámbrico Bluetooth', 179.00, 3, 2),
('Logitech C920', 'Webcam Full HD', 329.00, 3, 2),
('Kingston NV2 1TB', 'Unidad SSD NVMe 1TB', 299.00, 4, 3),
('Kingston DataTraveler 128GB', 'Memoria USB 128GB', 69.00, 4, 3),
('Kingston Fury 16GB', 'Memoria RAM DDR4 16GB', 189.00, 5, 3);
GO


/* =========================================
                PEDIDOS
   ========================================= */

INSERT INTO Pedido
(id_cliente, id_empleado, estado)
VALUES
(1, 1, 'Entregado'),
(2, 2, 'Entregado'),
(3, 4, 'Pagado'),
(4, 1, 'Enviado'),
(5, 6, 'Pendiente'),
(1, 2, 'Entregado'),
(4, 4, 'Pagado'),
(2, 1, 'Cancelado');
GO


/* =========================================
            DETALLE DE PEDIDOS
   ========================================= */

INSERT INTO Detalle_Pedido
(id_pedido, id_producto, cantidad, precio_unitario, descuento)
VALUES
(1, 1, 1, 2199.00, 0),
(1, 5, 1, 249.00, 10),

(2, 3, 1, 1299.00, 5),
(2, 6, 1, 179.00, 0),

(3, 8, 2, 299.00, 0),
(3, 9, 2, 69.00, 0),

(4, 2, 1, 3299.00, 10),
(4, 5, 2, 249.00, 0),

(5, 4, 1, 649.00, 0),
(5, 7, 1, 329.00, 0),

(6, 10, 2, 189.00, 5),
(6, 8, 1, 299.00, 0),

(7, 1, 1, 2199.00, 0),
(7, 6, 2, 179.00, 0),

(8, 9, 3, 69.00, 0);
GO


/* =========================================
                PAGOS
   ========================================= */

INSERT INTO Pago
(id_pedido, metodo_pago, monto)
VALUES
(1, 'Tarjeta', 2423.10),
(2, 'Yape', 1413.05),
(3, 'Transferencia', 736.00),
(4, 'Tarjeta', 3467.10),
(6, 'Plin', 658.10),
(7, 'Transferencia', 2557.00);
GO


/* =========================================
                INVENTARIO
   ========================================= */

INSERT INTO Inventario
(id_producto, id_sucursal, stock_actual, stock_minimo)
VALUES

-- Producto 1
(1, 1, 10, 3),
(1, 2, 8, 3),
(1, 3, 5, 3),

-- Producto 2
(2, 1, 6, 2),
(2, 2, 4, 2),
(2, 3, 3, 2),

-- Producto 3
(3, 1, 7, 2),
(3, 2, 5, 2),
(3, 3, 2, 2),

-- Producto 4
(4, 1, 12, 4),
(4, 2, 9, 4),
(4, 3, 6, 4),

-- Producto 5
(5, 1, 25, 5),
(5, 2, 18, 5),
(5, 3, 20, 5),

-- Producto 6
(6, 1, 15, 5),
(6, 2, 11, 5),
(6, 3, 14, 5),

-- Producto 7
(7, 1, 8, 3),
(7, 2, 6, 3),
(7, 3, 4, 3),

-- Producto 8
(8, 1, 20, 5),
(8, 2, 16, 5),
(8, 3, 10, 5),

-- Producto 9
(9, 1, 30, 8),
(9, 2, 25, 8),
(9, 3, 22, 8),

-- Producto 10
(10, 1, 18, 5),
(10, 2, 13, 5),
(10, 3, 9, 5);
GO


/* =========================================
           VERIFICACION DE DATOS
   ========================================= */

SELECT * FROM Cliente;
SELECT * FROM Sucursal;
SELECT * FROM Categoria;
SELECT * FROM Proveedor;
SELECT * FROM Empleado;
SELECT * FROM Producto;
SELECT * FROM Pedido;
SELECT * FROM Detalle_Pedido;
SELECT * FROM Pago;
SELECT * FROM Inventario;
GO