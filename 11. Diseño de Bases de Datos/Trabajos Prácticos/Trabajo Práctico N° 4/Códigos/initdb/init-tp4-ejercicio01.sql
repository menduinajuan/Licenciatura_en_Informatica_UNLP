-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio1;
USE tp4_ejercicio1;
SET NAMES utf8mb4;


-- =========================================================
-- TABLA CLIENTE
-- =========================================================
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    DNI INT UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(100)
);

-- =========================================================
-- TABLA PRODUCTO
-- =========================================================
CREATE TABLE Producto (
    idProducto INT PRIMARY KEY,
    nombreP VARCHAR(50),
    descripcion VARCHAR(100),
    precio DECIMAL(10,2),
    stock INT
);

-- =========================================================
-- TABLA FACTURA
-- =========================================================
CREATE TABLE Factura (
    nroTicket INT PRIMARY KEY,
    total DECIMAL(12,2),
    fecha DATE,
    hora TIME,
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- =========================================================
-- TABLA DETALLE
-- =========================================================
CREATE TABLE Detalle (
    nroTicket INT,
    idProducto INT,
    cantidad INT,
    precioUnitario DECIMAL(10,2),
    PRIMARY KEY (nroTicket, idProducto),
    FOREIGN KEY (nroTicket) REFERENCES Factura(nroTicket),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- CLIENTES
INSERT INTO Cliente (idCliente, nombre, apellido, DNI, telefono, direccion) VALUES
(400001, 'Juan', 'Perez', 45789456, '221-4501234', 'Calle 12 N 345'),
(400002, 'Ana', 'Perez', 45811222, '221-4407890', 'Calle 6 N 987'),
(400003, 'Carlos', 'Garcia', 45999888, '223-4703333', 'Av 7 N 1234'),
(400004, 'Lucia', 'Fernandez', 45677111, '221-4112345', 'Diag 80 N 999'),
(400005, 'Pedro', 'Penalba', 46777888, '221-4305678', 'Calle 44 N 125'),
(400006, 'Maria', 'Pepe', 46666111, '220-4901122', 'Calle 30 N 850'),
(400007, 'Sofia', 'Rojas', 45712345, '221-4909988', 'Calle 15 N 100'),
(400008, 'Jorge', 'Perez', 46889900, '221-4400789', 'Calle 11 N 2587'),
(400009, 'Laura', 'Benitez', 45123456, '222-4709876', 'Av 1 N 300'),
(400010, 'Mario', 'Garcia', 46000001, '221-4807777', 'Calle 60 N 77');

-- PRODUCTOS
INSERT INTO Producto (idProducto, nombreP, descripcion, precio, stock) VALUES
(1, 'prod1', 'Producto 1 descripcion', 1000.00, 50),
(2, 'prod2', 'Producto 2 descripcion', 2500.00, 30),
(3, 'prod3', 'Producto 3 descripcion', 1500.00, 40),
(4, 'prod4', 'Producto 4 descripcion', 3200.00, 25),
(5, 'prod38', 'Producto 38 especial', 800.00, 100),
(6, 'Z', 'Producto Z', 5000.00, 10),
(7, 'A', 'Producto A', 2000.00, 15),
(8, 'B', 'Producto B', 1000.00, 10),
(9, 'C', 'Producto C', 900.00, 60),
(10, 'D', 'Producto D', 15000.00, 5);

-- FACTURAS
INSERT INTO Factura (nroTicket, total, fecha, hora, idCliente) VALUES
(1001, 5500.00, '2024-05-10', '10:00:00', 400001),
(1002, 4000.00, '2024-06-15', '11:30:00', 400002),
(1003, 7200.00, '2023-08-21', '12:15:00', 400003),
(1004, 3000.00, '2024-02-14', '09:45:00', 400004),
(1005, 9000.00, '2024-04-05', '18:20:00', 400005),
(1006, 15000.00, '2023-12-12', '13:00:00', 400006),
(1007, 25000.00, '2024-07-19', '15:00:00', 400007),
(1008, 1800.00, '2025-01-05', '19:00:00', 400008),
(1009, 8000.00, '2024-09-09', '08:00:00', 400009),
(1010, 11000.00, '2023-03-22', '10:10:00', 400010),

-- Nuevas facturas para multiplicidad y montos altos
(1011, 22000.00, '2024-07-25', '12:00:00', 400007),
(1012, 48000.00, '2024-08-05', '13:30:00', 400007),
(1013, 32000.00, '2024-09-15', '09:45:00', 400005),
(1014, 42000.00, '2024-10-01', '10:10:00', 400005),
(1015, 60000.00, '2024-11-20', '16:00:00', 400005);

-- DETALLES
INSERT INTO Detalle (nroTicket, idProducto, cantidad, precioUnitario) VALUES
-- Factura 1001: Juan Perez
(1001, 1, 2, 1000.00),
(1001, 2, 1, 2500.00),

-- Factura 1002: Ana Perez
(1002, 1, 1, 1000.00),
(1002, 3, 2, 1500.00),

-- Factura 1003: Carlos Garcia
(1003, 1, 3, 1000.00),
(1003, 5, 2, 800.00),

-- Factura 1004: Lucia Fernandez
(1004, 3, 1, 1500.00),
(1004, 4, 1, 3200.00),

-- Factura 1005: Pedro Penalba
(1005, 2, 2, 2500.00),
(1005, 5, 5, 800.00),

-- Factura 1006: Maria Pepe
(1006, 1, 2, 1000.00),
(1006, 6, 1, 5000.00),

-- Factura 1007: Sofia Rojas
(1007, 2, 1, 2500.00),
(1007, 3, 1, 1500.00),
(1007, 4, 2, 3200.00),

-- Factura 1008: Jorge Perez
(1008, 1, 1, 1000.00),
(1008, 2, 1, 2500.00),

-- Factura 1009: Laura Benitez
(1009, 7, 3, 2000.00),
(1009, 8, 2, 1000.00),

-- Factura 1010: Mario Garcia
(1010, 5, 1, 800.00),
(1010, 3, 1, 1500.00),
(1010, 6, 1, 5000.00),

-- Nuevas facturas (clientes con multiples facturas)
-- Sofia Rojas (supera 100000 en total)
(1011, 4, 5, 3200.00),
(1012, 10, 3, 15000.00),

-- Pedro Penalba (mismas referencias)
(1013, 2, 5, 2500.00),
(1014, 3, 5, 1500.00),
(1015, 10, 4, 15000.00);
