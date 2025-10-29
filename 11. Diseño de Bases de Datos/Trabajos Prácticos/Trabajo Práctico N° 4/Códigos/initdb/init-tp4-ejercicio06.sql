-- ================================================
-- CREACIÓN E INICIALIZACIÓN DE LA BASE DE DATOS
-- Ejercicio 6 – Práctica SQL
-- ================================================

-- 1. Crear la base de datos
DROP DATABASE IF EXISTS tp4_ejercicio6;
CREATE DATABASE tp4_ejercicio6;
USE tp4_ejercicio6;
SET NAMES utf8mb4;



-- ================================================
-- 2. Creación de tablas
-- ================================================

CREATE TABLE Tecnico (
    codTec INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL
);

CREATE TABLE Repuesto (
    codRep INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE Reparacion (
    nroReparac INT PRIMARY KEY,
    codTec INT NOT NULL,
    precio_total DECIMAL(12,2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (codTec) REFERENCES Tecnico(codTec)
);

CREATE TABLE RepuestoReparacion (
    nroReparac INT NOT NULL,
    codRep INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (nroReparac, codRep),
    FOREIGN KEY (nroReparac) REFERENCES Reparacion(nroReparac),
    FOREIGN KEY (codRep) REFERENCES Repuesto(codRep)
);

-- ================================================
-- 3. Inserción de datos de ejemplo
-- ================================================

-- Técnicos
INSERT INTO Tecnico (codTec, nombre, especialidad) VALUES
(1, 'José Gonzalez', 'Electrónica'),
(2, 'María López', 'Mecánica'),
(3, 'Carlos Pérez', 'Electricidad'),
(4, 'Laura Fernández', 'Electrónica'),
(5, 'Diego Morales', 'Mecánica'),
(6, 'Sofía Díaz', 'Electricidad'),
(7, 'Andrés Torres', 'Electrónica'),
(8, 'Lucía Romero', 'Mecánica'),
(9, 'Javier García', 'Electricidad'),
(10, 'Natalia Suárez', 'Electrónica'),
(11, 'Juan Lopez', 'Electrónica');

-- Repuestos
INSERT INTO Repuesto (codRep, nombre, stock, precio) VALUES
(1, 'Placa base', 12, 12000.00),
(2, 'Motor', 8, 9000.00),
(3, 'Tornillo', 200, 15.00),
(4, 'Pantalla LCD', 6, 14500.00),
(5, 'Cable de poder', 50, 120.00),
(6, 'Sensor óptico', 15, 2500.00),
(7, 'Batería', 25, 7000.00),
(8, 'Transformador', 10, 11000.00),
(9, 'Placa de circuito', 18, 8000.00),
(10, 'Motor pequeño', 30, 4000.00),
(11, 'Resistor', 100, 8.00),
(12, 'Capacitor', 90, 12.00),
(13, 'Ventilador', 40, 3000.00),
(14, 'Tapa metálica', 60, 500.00),
(15, 'Disipador', 35, 1200.00),
(16, 'Fusible', 70, 50.00),
(17, 'Sensor térmico', 20, 1800.00),
(18, 'Microchip', 15, 9800.00),
(19, 'Carcasa', 25, 3500.00),
(20, 'Cable USB', 80, 200.00);

-- Reparaciones (2022, 2023, 2024)
INSERT INTO Reparacion (nroReparac, codTec, precio_total, fecha) VALUES
(101, 1, 12150.00, '2023-01-15'),
(102, 1, 22000.00, '2023-07-10'),
(103, 2, 4000.00, '2022-05-20'),
(104, 2, 9500.00, '2022-11-11'),
(105, 3, 6000.00, '2023-03-22'),
(106, 3, 12000.00, '2024-02-03'),
(107, 4, 11000.00, '2023-06-02'),
(108, 4, 3000.00, '2022-04-05'),
(109, 5, 15000.00, '2023-09-14'),
(110, 6, 9500.00, '2022-08-18'),
(111, 7, 6500.00, '2023-12-10'),
(112, 8, 7200.00, '2022-03-09'),
(113, 9, 4800.00, '2023-05-07'),
(114, 10, 5300.00, '2023-08-30'),
(115, 1, 13500.00, '2024-04-14'),
(116, 2, 12000.00, '2022-06-25'),
(117, 3, 8700.00, '2023-02-14'),
(118, 5, 10200.00, '2023-10-20'),
(119, 6, 7600.00, '2022-12-30'),
(120, 7, 4100.00, '2022-07-10'),
(121, 1, 33500.00, '2025-04-10');

-- Repuestos utilizados en reparaciones
INSERT INTO RepuestoReparacion (nroReparac, codRep, cantidad, precio) VALUES
-- Reparaciones de José Gonzalez (codTec = 1)
(101, 1, 1, 12000.00),
(101, 3, 10, 15.00),
(102, 4, 1, 14500.00),
(102, 5, 2, 120.00),
(115, 18, 1, 9800.00),
(115, 6, 2, 2500.00),
(121, 4, 1, 30000.00),
(121, 3, 10, 150.00), 
(121, 5, 1, 120.00), 
(121, 17, 1, 1800.00),
-- Reparaciones de María López (codTec = 2)
(103, 7, 1, 7000.00),
(104, 10, 2, 4000.00),
(116, 13, 1, 3000.00),
-- Reparaciones de Carlos Pérez (codTec = 3)
(105, 5, 3, 120.00),
(105, 11, 4, 8.00),
(117, 12, 5, 12.00),
(117, 17, 1, 1800.00),
(106, 2, 1, 9000.00),
-- Reparaciones de Laura Fernández (codTec = 4)
(107, 8, 1, 11000.00),
(108, 14, 4, 500.00),
-- Reparaciones de Diego Morales (codTec = 5)
(109, 1, 1, 12000.00),
(109, 15, 1, 1200.00),
(118, 9, 1, 8000.00),
-- Reparaciones de Sofía Díaz (codTec = 6)
(110, 16, 2, 50.00),
(119, 20, 3, 200.00),
-- Reparaciones de Andrés Torres (codTec = 7)
(111, 3, 15, 15.00),
(120, 5, 1, 120.00),
-- Reparaciones de Lucía Romero (codTec = 8)
(112, 7, 1, 7000.00),
(112, 14, 2, 500.00),
-- Reparaciones de Javier García (codTec = 9)
(113, 19, 1, 3500.00),
(113, 12, 3, 12.00),
-- Reparaciones de Natalia Suárez (codTec = 10)
(114, 15, 1, 1200.00),
(114, 6, 1, 2500.00);
