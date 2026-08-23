USE DB_GestionVentas;
GO


/* =========================================
                TABLA CLIENTE
   ========================================= */

CREATE TABLE Cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni CHAR(8) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    ciudad VARCHAR(100) NOT NULL,
    fecha_registro DATE NOT NULL DEFAULT GETDATE(),
    estado BIT NOT NULL DEFAULT 1
);
GO


/* =========================================
                TABLA SUCURSAL
   ========================================= */

CREATE TABLE Sucursal (
    id_sucursal INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    estado BIT NOT NULL DEFAULT 1
);
GO


/* =========================================
                TABLA CATEGORIA
   ========================================= */

CREATE TABLE Categoria (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(250),
    estado BIT NOT NULL DEFAULT 1
);
GO


/* =========================================
                TABLA PROVEEDOR
   ========================================= */

CREATE TABLE Proveedor (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    razon_social VARCHAR(150) NOT NULL,
    ruc CHAR(11) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    direccion VARCHAR(200) NOT NULL,
    estado BIT NOT NULL DEFAULT 1
);
GO


/* =========================================
                TABLA EMPLEADO
   ========================================= */

CREATE TABLE Empleado (
    id_empleado INT IDENTITY(1,1) PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni CHAR(8) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    fecha_ingreso DATE NOT NULL DEFAULT GETDATE(),
    id_sucursal INT NOT NULL,
    estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT CK_Empleado_Salario
    CHECK (salario > 0),

    CONSTRAINT FK_Empleado_Sucursal
    FOREIGN KEY (id_sucursal)
    REFERENCES Sucursal(id_sucursal)
);
GO


/* =========================================
                TABLA PRODUCTO
   ========================================= */

CREATE TABLE Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(250),
    precio DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    id_proveedor INT NOT NULL,
    estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT CK_Producto_Precio
    CHECK (precio > 0),

    CONSTRAINT FK_Producto_Categoria
    FOREIGN KEY (id_categoria)
    REFERENCES Categoria(id_categoria),

    CONSTRAINT FK_Producto_Proveedor
    FOREIGN KEY (id_proveedor)
    REFERENCES Proveedor(id_proveedor)
);
GO


/* =========================================
                TABLA PEDIDO
   ========================================= */

CREATE TABLE Pedido (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',

    CONSTRAINT CK_Pedido_Estado
    CHECK (
        estado IN (
            'Pendiente',
            'Pagado',
            'Enviado',
            'Entregado',
            'Cancelado'
        )
    ),

    CONSTRAINT FK_Pedido_Cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente(id_cliente),

    CONSTRAINT FK_Pedido_Empleado
    FOREIGN KEY (id_empleado)
    REFERENCES Empleado(id_empleado)
);
GO


/* =========================================
            TABLA DETALLE_PEDIDO
   ========================================= */

CREATE TABLE Detalle_Pedido (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(5,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Detalle_Cantidad
    CHECK (cantidad > 0),

    CONSTRAINT CK_Detalle_Precio
    CHECK (precio_unitario > 0),

    CONSTRAINT CK_Detalle_Descuento
    CHECK (descuento BETWEEN 0 AND 100),

    CONSTRAINT FK_Detalle_Pedido
    FOREIGN KEY (id_pedido)
    REFERENCES Pedido(id_pedido),

    CONSTRAINT FK_Detalle_Producto
    FOREIGN KEY (id_producto)
    REFERENCES Producto(id_producto)
);
GO


/* =========================================
                TABLA PAGO
   ========================================= */

CREATE TABLE Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_Pago_Monto
    CHECK (monto > 0),

    CONSTRAINT CK_Pago_Metodo
    CHECK (
        metodo_pago IN (
            'Efectivo',
            'Tarjeta',
            'Yape',
            'Plin',
            'Transferencia'
        )
    ),

    CONSTRAINT FK_Pago_Pedido
    FOREIGN KEY (id_pedido)
    REFERENCES Pedido(id_pedido)
);
GO


/* =========================================
                TABLA INVENTARIO
   ========================================= */

CREATE TABLE Inventario (
    id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    id_sucursal INT NOT NULL,
    stock_actual INT NOT NULL DEFAULT 0,
    stock_minimo INT NOT NULL DEFAULT 5,
    fecha_actualizacion DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_Inventario_StockActual
    CHECK (stock_actual >= 0),

    CONSTRAINT CK_Inventario_StockMinimo
    CHECK (stock_minimo >= 0),

    CONSTRAINT UQ_Inventario_ProductoSucursal
    UNIQUE (id_producto, id_sucursal),

    CONSTRAINT FK_Inventario_Producto
    FOREIGN KEY (id_producto)
    REFERENCES Producto(id_producto),

    CONSTRAINT FK_Inventario_Sucursal
    FOREIGN KEY (id_sucursal)
    REFERENCES Sucursal(id_sucursal)
);
GO