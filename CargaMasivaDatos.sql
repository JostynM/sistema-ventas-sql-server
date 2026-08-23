USE DB_GestionVentas;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRY

    BEGIN TRANSACTION;


    /* =========================================
       1. NUEVAS SUCURSALES
       ========================================= */

    INSERT INTO Sucursal
    (
        nombre,
        ciudad,
        direccion,
        telefono
    )
    SELECT *
    FROM
    (
        VALUES
        ('San Miguel', 'Lima', 'Av. La Marina 2100', '014567893'),
        ('Santiago de Surco', 'Lima', 'Av. Primavera 1200', '014567894')
    ) AS datos(nombre, ciudad, direccion, telefono)
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Sucursal s
        WHERE s.nombre = datos.nombre
    );


    /* =========================================
       2. NUEVAS CATEGORÍAS
       ========================================= */

    INSERT INTO Categoria
    (
        nombre,
        descripcion
    )
    SELECT *
    FROM
    (
        VALUES
        ('Gaming', 'Equipos y accesorios orientados a videojuegos'),
        ('Smartphones', 'Teléfonos inteligentes'),
        ('Tablets', 'Tablets y dispositivos móviles'),
        ('Audio', 'Audífonos, parlantes y dispositivos de audio')
    ) AS datos(nombre, descripcion)
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Categoria c
        WHERE c.nombre = datos.nombre
    );


    /* =========================================
       3. NUEVOS PROVEEDORES
       ========================================= */

    INSERT INTO Proveedor
    (
        razon_social,
        ruc,
        telefono,
        email,
        direccion
    )
    SELECT *
    FROM
    (
        VALUES
        ('HP Peru Comercial SAC',
         '20500100001',
         '019000001',
         'ventas@hpportfolio.pe',
         'Av. República de Panamá 3500'),

        ('ASUS Peru SAC',
         '20500100002',
         '019000002',
         'ventas@asusportfolio.pe',
         'Av. Javier Prado 4200'),

        ('Xiaomi Peru SAC',
         '20500100003',
         '019000003',
         'ventas@xiaomiportfolio.pe',
         'Av. Arequipa 3000'),

        ('JBL Peru SAC',
         '20500100004',
         '019000004',
         'ventas@jblportfolio.pe',
         'Av. Benavides 1800')
    ) AS datos
    (
        razon_social,
        ruc,
        telefono,
        email,
        direccion
    )
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Proveedor p
        WHERE p.ruc = datos.ruc
    );


    /* =========================================
       4. NUEVOS CLIENTES
       ========================================= */

    INSERT INTO Cliente
    (
        nombres,
        apellidos,
        dni,
        email,
        telefono,
        ciudad,
        fecha_registro
    )
    SELECT *
    FROM
    (
        VALUES
        ('Diego','Sanchez','82000001','diego.sanchez@portfolio.pe','970000001','Lima','2025-01-05'),
        ('Valeria','Ruiz','82000002','valeria.ruiz@portfolio.pe','970000002','Lima','2025-01-12'),
        ('Sebastian','Flores','82000003','sebastian.flores@portfolio.pe','970000003','Arequipa','2025-01-20'),
        ('Camila','Ramos','82000004','camila.ramos@portfolio.pe','970000004','Trujillo','2025-02-02'),
        ('Alonso','Chavez','82000005','alonso.chavez@portfolio.pe','970000005','Cusco','2025-02-10'),

        ('Luciana','Vega','82000006','luciana.vega@portfolio.pe','970000006','Lima','2025-02-18'),
        ('Mateo','Navarro','82000007','mateo.navarro@portfolio.pe','970000007','Piura','2025-03-01'),
        ('Daniela','Paredes','82000008','daniela.paredes@portfolio.pe','970000008','Chiclayo','2025-03-15'),
        ('Adrian','Ortiz','82000009','adrian.ortiz@portfolio.pe','970000009','Lima','2025-03-21'),
        ('Sofia','Cabrera','82000010','sofia.cabrera@portfolio.pe','970000010','Arequipa','2025-04-02'),

        ('Bruno','Castillo','82000011','bruno.castillo@portfolio.pe','970000011','Lima','2025-04-11'),
        ('Alejandra','Reyes','82000012','alejandra.reyes@portfolio.pe','970000012','Trujillo','2025-04-19'),
        ('Gabriel','Espinoza','82000013','gabriel.espinoza@portfolio.pe','970000013','Cusco','2025-05-01'),
        ('Fiorella','Medina','82000014','fiorella.medina@portfolio.pe','970000014','Lima','2025-05-15'),
        ('Rodrigo','Salazar','82000015','rodrigo.salazar@portfolio.pe','970000015','Piura','2025-05-20'),

        ('Nicole','Aguilar','82000016','nicole.aguilar@portfolio.pe','970000016','Lima','2025-06-03'),
        ('Renzo','Molina','82000017','renzo.molina@portfolio.pe','970000017','Arequipa','2025-06-14'),
        ('Andrea','Campos','82000018','andrea.campos@portfolio.pe','970000018','Chiclayo','2025-06-25'),
        ('Franco','Delgado','82000019','franco.delgado@portfolio.pe','970000019','Lima','2025-07-01'),
        ('Mariana','Fuentes','82000020','mariana.fuentes@portfolio.pe','970000020','Trujillo','2025-07-17'),

        ('Joaquin','Herrera','82000021','joaquin.herrera@portfolio.pe','970000021','Cusco','2025-07-29'),
        ('Natalia','Rojas','82000022','natalia.rojas@portfolio.pe','970000022','Lima','2025-08-10'),
        ('Mauricio','Peña','82000023','mauricio.pena@portfolio.pe','970000023','Piura','2025-08-22'),
        ('Carolina','Valdez','82000024','carolina.valdez@portfolio.pe','970000024','Lima','2025-09-04'),
        ('Thiago','Miranda','82000025','thiago.miranda@portfolio.pe','970000025','Arequipa','2025-09-16'),

        ('Micaela','Torres','82000026','micaela.torres@portfolio.pe','970000026','Lima','2025-10-01'),
        ('Emilio','Guzman','82000027','emilio.guzman@portfolio.pe','970000027','Trujillo','2025-10-12'),
        ('Paula','Carrasco','82000028','paula.carrasco@portfolio.pe','970000028','Cusco','2025-10-25'),
        ('Martin','Soto','82000029','martin.soto@portfolio.pe','970000029','Lima','2025-11-03'),
        ('Antonella','Romero','82000030','antonella.romero@portfolio.pe','970000030','Chiclayo','2025-11-18')
    ) AS datos
    (
        nombres,
        apellidos,
        dni,
        email,
        telefono,
        ciudad,
        fecha_registro
    )
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Cliente c
        WHERE c.dni = datos.dni
           OR c.email = datos.email
           OR c.telefono = datos.telefono
    );


    /* =========================================
       5. NUEVOS EMPLEADOS
       ========================================= */

    INSERT INTO Empleado
    (
        nombres,
        apellidos,
        dni,
        email,
        telefono,
        cargo,
        salario,
        fecha_ingreso,
        id_sucursal
    )
    SELECT
        datos.nombres,
        datos.apellidos,
        datos.dni,
        datos.email,
        datos.telefono,
        datos.cargo,
        datos.salario,
        datos.fecha_ingreso,
        s.id_sucursal
    FROM
    (
        VALUES
        ('Kevin','Morales','80100001','kevin.morales@gestionventas.pe','960100001','Vendedor',1900,'2025-01-10','Lima Centro'),
        ('Melissa','Cruz','80100002','melissa.cruz@gestionventas.pe','960100002','Vendedor',1950,'2025-02-15','San Isidro'),
        ('Oscar','Mendoza','80100003','oscar.mendoza@gestionventas.pe','960100003','Vendedor',1900,'2025-03-01','Miraflores'),
        ('Claudia','Vera','80100004','claudia.vera@gestionventas.pe','960100004','Vendedor',1950,'2025-03-20','San Miguel'),
        ('Luis','Pacheco','80100005','luis.pacheco@gestionventas.pe','960100005','Vendedor',2000,'2025-04-12','Santiago de Surco'),
        ('Patricia','Leon','80100006','patricia.leon@gestionventas.pe','960100006','Supervisor',2800,'2025-05-01','Lima Centro'),
        ('Marco','Diaz','80100007','marco.diaz@gestionventas.pe','960100007','Vendedor',1900,'2025-06-07','San Miguel'),
        ('Karla','Solis','80100008','karla.solis@gestionventas.pe','960100008','Vendedor',2000,'2025-07-18','Santiago de Surco')
    ) AS datos
    (
        nombres,
        apellidos,
        dni,
        email,
        telefono,
        cargo,
        salario,
        fecha_ingreso,
        sucursal
    )

    INNER JOIN Sucursal s
        ON s.nombre = datos.sucursal

    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Empleado e
        WHERE e.dni = datos.dni
           OR e.email = datos.email
           OR e.telefono = datos.telefono
    );


    /* =========================================
       6. NUEVOS PRODUCTOS
       ========================================= */

    INSERT INTO Producto
    (
        nombre,
        descripcion,
        precio,
        id_categoria,
        id_proveedor
    )
    SELECT
        datos.nombre,
        datos.descripcion,
        datos.precio,
        c.id_categoria,
        pr.id_proveedor

    FROM
    (
        VALUES
        ('HP Pavilion 15','Laptop para estudio y trabajo',2399.00,'Laptops','20500100001'),
        ('HP Victus 15','Laptop gaming',3699.00,'Gaming','20500100001'),
        ('HP Laptop 15','Laptop de uso general',1899.00,'Laptops','20500100001'),
        ('HP Omen 16','Laptop gaming de alto rendimiento',5299.00,'Gaming','20500100001'),

        ('ASUS Vivobook 15','Laptop para productividad',2499.00,'Laptops','20500100002'),
        ('ASUS Zenbook 14','Ultrabook premium',4199.00,'Laptops','20500100002'),
        ('ASUS TUF Gaming F15','Laptop gaming',3899.00,'Gaming','20500100002'),
        ('ASUS ROG Strix G16','Laptop gaming profesional',6299.00,'Gaming','20500100002'),
        ('ASUS ROG Ally','Consola portátil gaming',2999.00,'Gaming','20500100002'),

        ('Xiaomi Redmi Note 13','Smartphone gama media',699.00,'Smartphones','20500100003'),
        ('Xiaomi Redmi Note 13 Pro','Smartphone gama media premium',1099.00,'Smartphones','20500100003'),
        ('Xiaomi 14T','Smartphone gama alta',1999.00,'Smartphones','20500100003'),
        ('Poco X6 Pro','Smartphone orientado a rendimiento',1399.00,'Smartphones','20500100003'),
        ('Xiaomi Pad 6','Tablet Android',1499.00,'Tablets','20500100003'),

        ('JBL Tune 520BT','Audífonos Bluetooth',199.00,'Audio','20500100004'),
        ('JBL Live 660NC','Audífonos con cancelación de ruido',499.00,'Audio','20500100004'),
        ('JBL Charge 5','Parlante Bluetooth',649.00,'Audio','20500100004'),
        ('JBL Flip 6','Parlante portátil',449.00,'Audio','20500100004'),
        ('JBL Quantum 100','Audífonos gaming',179.00,'Gaming','20500100004'),
        ('JBL Quantum 610','Audífonos gaming inalámbricos',599.00,'Gaming','20500100004')
    ) AS datos
    (
        nombre,
        descripcion,
        precio,
        categoria,
        ruc_proveedor
    )

    INNER JOIN Categoria c
        ON c.nombre = datos.categoria

    INNER JOIN Proveedor pr
        ON pr.ruc = datos.ruc_proveedor

    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Producto p
        WHERE p.nombre = datos.nombre
    );


    /* =========================================
       7. INVENTARIO DE LOS NUEVOS PRODUCTOS
       ========================================= */

    INSERT INTO Inventario
    (
        id_producto,
        id_sucursal,
        stock_actual,
        stock_minimo
    )
    SELECT
        p.id_producto,
        s.id_sucursal,

        150 +
        (
            ABS(CHECKSUM(p.id_producto, s.id_sucursal)) % 51
        ),

        15

    FROM Producto p

    INNER JOIN Proveedor pr
        ON p.id_proveedor = pr.id_proveedor

    CROSS JOIN Sucursal s

    WHERE pr.ruc IN
    (
        '20500100001',
        '20500100002',
        '20500100003',
        '20500100004'
    )

    AND NOT EXISTS
    (
        SELECT 1
        FROM Inventario i
        WHERE i.id_producto = p.id_producto
          AND i.id_sucursal = s.id_sucursal
    );


    /* =========================================
       8. PREPARAR CLIENTES, EMPLEADOS
          Y PRODUCTOS PARA GENERAR VENTAS
       ========================================= */

    DECLARE @ClientesCarga TABLE
    (
        rn INT PRIMARY KEY,
        id_cliente INT
    );

    INSERT INTO @ClientesCarga
    SELECT
        ROW_NUMBER() OVER (ORDER BY id_cliente),
        id_cliente
    FROM Cliente
    WHERE email LIKE '%@portfolio.pe';


    DECLARE @EmpleadosCarga TABLE
    (
        rn INT PRIMARY KEY,
        id_empleado INT
    );

    INSERT INTO @EmpleadosCarga
    SELECT
        ROW_NUMBER() OVER (ORDER BY id_empleado),
        id_empleado
    FROM Empleado
    WHERE email LIKE '%@gestionventas.pe';


    DECLARE @ProductosCarga TABLE
    (
        rn INT PRIMARY KEY,
        id_producto INT,
        precio DECIMAL(10,2)
    );

    INSERT INTO @ProductosCarga
    SELECT
        ROW_NUMBER() OVER (ORDER BY p.id_producto),
        p.id_producto,
        p.precio
    FROM Producto p

    INNER JOIN Proveedor pr
        ON p.id_proveedor = pr.id_proveedor

    WHERE pr.ruc IN
    (
        '20500100001',
        '20500100002',
        '20500100003',
        '20500100004'
    );


    /* =========================================
       9. CANTIDADES DISPONIBLES
       ========================================= */

    DECLARE @cantidadClientes INT;
    DECLARE @cantidadEmpleados INT;
    DECLARE @cantidadProductos INT;

    SELECT @cantidadClientes = COUNT(*)
    FROM @ClientesCarga;

    SELECT @cantidadEmpleados = COUNT(*)
    FROM @EmpleadosCarga;

    SELECT @cantidadProductos = COUNT(*)
    FROM @ProductosCarga;


    IF @cantidadClientes = 0
       OR @cantidadEmpleados = 0
       OR @cantidadProductos = 0
    BEGIN
        THROW 50010,
        'No existen suficientes datos para generar las ventas.',
        1;
    END;


    /* =========================================
       10. GENERAR 180 PEDIDOS
       ========================================= */

    DECLARE @i INT = 1;

    DECLARE @id_cliente INT;
    DECLARE @id_empleado INT;

    DECLARE @id_producto1 INT;
    DECLARE @id_producto2 INT;

    DECLARE @precio1 DECIMAL(10,2);
    DECLARE @precio2 DECIMAL(10,2);

    DECLARE @id_pedido INT;

    DECLARE @fecha DATETIME;
    DECLARE @estado VARCHAR(30);
    DECLARE @metodo VARCHAR(30);

    DECLARE @cantidad1 INT;
    DECLARE @cantidad2 INT;

    DECLARE @descuento1 DECIMAL(5,2);
    DECLARE @descuento2 DECIMAL(5,2);

    DECLARE @monto DECIMAL(10,2);


    WHILE @i <= 180
    BEGIN

        /* -------------------------------------
           Seleccionar cliente
           ------------------------------------- */

        SELECT @id_cliente = id_cliente
        FROM @ClientesCarga
        WHERE rn =
        (
            ((@i - 1) % @cantidadClientes) + 1
        );


        /* -------------------------------------
           Seleccionar empleado
           ------------------------------------- */

        SELECT @id_empleado = id_empleado
        FROM @EmpleadosCarga
        WHERE rn =
        (
            ((@i - 1) % @cantidadEmpleados) + 1
        );


        /* -------------------------------------
           Primer producto
           ------------------------------------- */

        SELECT
            @id_producto1 = id_producto,
            @precio1 = precio
        FROM @ProductosCarga
        WHERE rn =
        (
            ((@i - 1) % @cantidadProductos) + 1
        );


        /* -------------------------------------
           Segundo producto
           ------------------------------------- */

        SELECT
            @id_producto2 = id_producto,
            @precio2 = precio
        FROM @ProductosCarga
        WHERE rn =
        (
            ((@i + 6) % @cantidadProductos) + 1
        );


        /* -------------------------------------
           Fecha del pedido
           ------------------------------------- */

        SET @fecha =
        DATEADD
        (
            MINUTE,
            @i,
            DATEADD
            (
                DAY,
                @i - 1,
                CAST('2026-01-01T09:00:00' AS DATETIME)
            )
        );


        /* -------------------------------------
           Estado del pedido
           ------------------------------------- */

        SET @estado =
        CASE @i % 4

            WHEN 0 THEN 'Entregado'
            WHEN 1 THEN 'Pagado'
            WHEN 2 THEN 'Enviado'
            ELSE 'Pendiente'

        END;


        /* -------------------------------------
           Cantidades
           ------------------------------------- */

        SET @cantidad1 = 1 + (@i % 3);

        SET @cantidad2 = 1 + ((@i + 1) % 2);


        /* -------------------------------------
           Descuentos
           ------------------------------------- */

        SET @descuento1 =
        CASE @i % 4
            WHEN 1 THEN 5
            WHEN 2 THEN 10
            ELSE 0
        END;

        SET @descuento2 =
        CASE @i % 5
            WHEN 0 THEN 10
            ELSE 0
        END;


        /* =====================================
           CREAR PEDIDO
           ===================================== */

        IF NOT EXISTS
        (
            SELECT 1
            FROM Pedido
            WHERE fecha_pedido = @fecha
              AND id_cliente = @id_cliente
              AND id_empleado = @id_empleado
        )
        BEGIN

            INSERT INTO Pedido
            (
                id_cliente,
                id_empleado,
                fecha_pedido,
                estado
            )
            VALUES
            (
                @id_cliente,
                @id_empleado,
                @fecha,
                @estado
            );

            SET @id_pedido = SCOPE_IDENTITY();

        END

        ELSE
        BEGIN

            SELECT @id_pedido = id_pedido
            FROM Pedido
            WHERE fecha_pedido = @fecha
              AND id_cliente = @id_cliente
              AND id_empleado = @id_empleado;

        END;


        /* =====================================
           PRIMER PRODUCTO DEL PEDIDO
           ===================================== */

        IF NOT EXISTS
        (
            SELECT 1
            FROM Detalle_Pedido
            WHERE id_pedido = @id_pedido
              AND id_producto = @id_producto1
        )
        BEGIN

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
                @id_producto1,
                @cantidad1,
                @precio1,
                @descuento1
            );

        END;


        /* =====================================
           SEGUNDO PRODUCTO DEL PEDIDO
           ===================================== */

        IF NOT EXISTS
        (
            SELECT 1
            FROM Detalle_Pedido
            WHERE id_pedido = @id_pedido
              AND id_producto = @id_producto2
        )
        BEGIN

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
                @id_producto2,
                @cantidad2,
                @precio2,
                @descuento2
            );

        END;


        /* =====================================
           REGISTRAR PAGO
           ===================================== */

        IF @estado IN
        (
            'Pagado',
            'Enviado',
            'Entregado'
        )
        BEGIN

            SELECT
                @monto =
                CAST
                (
                    SUM
                    (
                        cantidad
                        * precio_unitario
                        * (1 - descuento / 100.0)
                    )
                    AS DECIMAL(10,2)
                )

            FROM Detalle_Pedido

            WHERE id_pedido = @id_pedido;


            SET @metodo =
            CASE @i % 5

                WHEN 0 THEN 'Efectivo'
                WHEN 1 THEN 'Tarjeta'
                WHEN 2 THEN 'Yape'
                WHEN 3 THEN 'Plin'
                ELSE 'Transferencia'

            END;


            IF NOT EXISTS
            (
                SELECT 1
                FROM Pago
                WHERE id_pedido = @id_pedido
            )
            BEGIN

                INSERT INTO Pago
                (
                    id_pedido,
                    metodo_pago,
                    monto,
                    fecha_pago
                )
                VALUES
                (
                    @id_pedido,
                    @metodo,
                    @monto,
                    DATEADD(MINUTE, 10, @fecha)
                );

            END;

        END;


        SET @i = @i + 1;

    END;


    /* =========================================
       11. CONFIRMAR TODOS LOS CAMBIOS
       ========================================= */

    COMMIT;

    PRINT 'Carga masiva realizada correctamente.';


END TRY

BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK;

    PRINT 'Error durante la carga masiva.';
    PRINT 'Se deshicieron todos los cambios.';

    THROW;

END CATCH;
GO


/* =========================================
   12. COMPROBAR RESULTADOS
   ========================================= */

SELECT COUNT(*) AS total_clientes
FROM Cliente;

SELECT COUNT(*) AS total_sucursales
FROM Sucursal;

SELECT COUNT(*) AS total_empleados
FROM Empleado;

SELECT COUNT(*) AS total_productos
FROM Producto;

SELECT COUNT(*) AS total_inventario
FROM Inventario;

SELECT COUNT(*) AS total_pedidos
FROM Pedido;

SELECT COUNT(*) AS total_detalles
FROM Detalle_Pedido;

SELECT COUNT(*) AS total_pagos
FROM Pago;
GO

SELECT * FROM Pago