-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio12;
USE tp4_ejercicio12;
SET NAMES utf8mb4;

-- =========================================================
-- TABLA BARBERIA
-- =========================================================
CREATE TABLE Barberia (
    codBarberia INT PRIMARY KEY,
    razon_social VARCHAR(120) UNIQUE,
    direccion VARCHAR(160),
    telefono VARCHAR(40)
);

-- =========================================================
-- TABLA CLIENTE
-- =========================================================
CREATE TABLE Cliente (
    nroCliente INT PRIMARY KEY,
    DNI INT UNIQUE,
    nombYAp VARCHAR(120),
    direccionC VARCHAR(160),
    fechaNacimiento DATE,
    celular VARCHAR(40)
);

-- =========================================================
-- TABLA BARBERO
-- =========================================================
CREATE TABLE Barbero (
    codEmpleado INT PRIMARY KEY,
    DNIB INT UNIQUE,
    nombYApB VARCHAR(120),
    direccionB VARCHAR(160),
    telefonoContacto VARCHAR(40),
    mail VARCHAR(120)
);

-- =========================================================
-- TABLA ATENCION
-- =========================================================
CREATE TABLE Atencion (
    codEmpleado INT,
    fecha DATE,
    hora TIME,
    codBarberia INT,
    nroCliente INT,
    descTratamiento VARCHAR(160),
    valor DECIMAL(10,2),
    PRIMARY KEY (codEmpleado, fecha, hora),
    FOREIGN KEY (codEmpleado) REFERENCES Barbero(codEmpleado),
    FOREIGN KEY (codBarberia) REFERENCES Barberia(codBarberia),
    FOREIGN KEY (nroCliente) REFERENCES Cliente(nroCliente)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- BARBERIAS (incluye 'Corta barba' y 'Barberia Barbara')
INSERT INTO Barberia (codBarberia, razon_social, direccion, telefono) VALUES
(1, 'Corta barba',       'Av. 7 1234, La Plata',        '221-4101000'),
(2, 'Barberia Barbara',  'Calle 12 555, La Plata',      '221-4101001'),
(3, 'Bigote Fino',       'Diag. 80 100, La Plata',      '221-4101002'),
(4, 'La Navaja',         'Av. 13 1300, Ensenada',       '221-4101003'),
(5, 'Barba & Co.',       'Calle 6 345, Berisso',        '221-4101004');

-- CLIENTES (incluye DNI 22283566 y 22222222 para baja)
INSERT INTO Cliente (nroCliente, DNI, nombYAp, direccionC, fechaNacimiento, celular) VALUES
(101, 20333444, 'Juan Pérez',        'Calle 10 111, La Plata',    '1990-05-10', '221-5000001'),
(102, 21444555, 'Ana Gómez',         'Calle 11 222, La Plata',    '1988-07-20', '221-5000002'),
(103, 22555666, 'Carlos Rossi',      'Calle 12 333, La Plata',    '1995-03-15', '221-5000003'),
(104, 23666777, 'Lucía Benítez',     'Diag. 80 444, La Plata',    '1992-12-01', '221-5000004'),
(105, 24777888, 'Tomás Herrera',     'Av. 7 555, La Plata',       '1998-04-25', '221-5000005'),
(106, 25888999, 'Sofía Martínez',    'Av. 13 666, Ensenada',      '1991-01-30', '221-5000006'),
(107, 26999111, 'Bruno Sosa',        'Calle 6 777, Berisso',      '1993-09-09', '221-5000007'),
(108, 22283566, 'Valentina Paz',     'Calle 60 888, La Plata',    '1996-11-11', '221-5000008'),
(109, 23333111, 'Diego Acosta',      'Calle 1 999, La Plata',     '1987-08-08', '221-5000009'),
(110, 24444222, 'Ramiro Leiva',      'Calle 2 200, La Plata',     '1994-02-02', '221-5000010'),
(111, 22222222, 'Cliente Para Baja', 'Calle 3 300, La Plata',     '1990-10-10', '221-5000011'),
(112, 25555333, 'Gonzalo Álvarez',   'Calle 4 400, La Plata',     '1999-06-06', '221-5000012');

-- BARBEROS
INSERT INTO Barbero (codEmpleado, DNIB, nombYApB, direccionB, telefonoContacto, mail) VALUES
(201, 30111222, 'Oscar López',        'Calle 21 111, La Plata',   '221-4102001', 'oscar.lopez@barba.com'),
(202, 30222333, 'María Pérez',        'Calle 22 222, La Plata',   '221-4102002', 'maria.perez@barba.com'),
(203, 30333444, 'Juan García',        'Calle 23 333, La Plata',   '221-4102003', 'juan.garcia@barba.com'),
(204, 30444555, 'Santiago Gómez',     'Calle 24 444, La Plata',   '221-4102004', 'santiago.gomez@barba.com'),
(205, 30555666, 'Carla Acosta',       'Calle 25 555, La Plata',   '221-4102005', 'carla.acosta@barba.com'),
(206, 30666777, 'Pablo Bravo',        'Calle 26 666, La Plata',   '221-4102006', 'pablo.bravo@barba.com'),
(207, 30777888, 'Valentina Maidana',  'Calle 27 777, La Plata',   '221-4102007', 'valentina.maidana@barba.com'),
(208, 30888999, 'Diego Herrera',      'Calle 28 888, La Plata',   '221-4102008', 'diego.herrera@barba.com');

-- ATENCIONES
-- Reglas para consultas:
-- * Año 2023: suficientes atenciones por barbero para conteo (punto 2).
-- * Año 2024: atenciones para varios clientes, y algunos clientes SIN atenciones en 2024 (punto 1).
-- * Cliente DNI 22283566 (nroCliente 108) atendido en 'Corta barba' y 'Barberia Barbara' (punto 5 y 3).
-- * Valor > 5000 para detectar barberos (punto 4).
INSERT INTO Atencion (codEmpleado, fecha, hora, codBarberia, nroCliente, descTratamiento, valor) VALUES
-- 2023
(201, '2023-01-10', '10:00:00', 1, 101, 'Corte clásico',            2500.00),
(201, '2023-02-15', '11:00:00', 1, 102, 'Corte + barba',            4500.00),
(201, '2023-03-20', '12:00:00', 2, 103, 'Afeitado tradicional',     3000.00),
(202, '2023-01-05', '09:30:00', 1, 104, 'Corte clásico',            2500.00),
(202, '2023-04-18', '15:30:00', 3, 105, 'Arreglo de barba',         2000.00),
(203, '2023-05-22', '16:00:00', 2, 106, 'Corte + tratamiento',      5200.00),
(203, '2023-06-01', '10:15:00', 3, 107, 'Corte degradado',          3500.00),
(204, '2023-02-28', '13:45:00', 2, 108, 'Corte clásico',            2500.00),
(204, '2023-07-10', '11:30:00', 2, 101, 'Corte + barba',            4800.00),
(205, '2023-08-12', '14:00:00', 3, 102, 'Tratamiento capilar',      6000.00),
(205, '2023-09-15', '09:00:00', 3, 103, 'Corte clásico',            2500.00),
(206, '2023-10-20', '17:00:00', 4, 104, 'Afeitado',                 2800.00),
(206, '2023-11-05', '10:00:00', 4, 105, 'Corte + barba premium',    7000.00),
(207, '2023-03-03', '12:30:00', 5, 106, 'Corte clásico',            2500.00),
(207, '2023-12-22', '18:30:00', 5, 107, 'Corte + barba',            4800.00),
(208, '2023-12-28', '19:00:00', 5, 109, 'Color + corte',            8000.00),

-- 2024 (algunos clientes no tendrán atenciones este año: p.ej., nro 111, 112)
(201, '2024-01-12', '10:00:00', 1, 101, 'Corte clásico',            2600.00),
(201, '2024-02-10', '11:00:00', 1, 102, 'Corte + barba',            5000.00),
(201, '2024-03-14', '12:00:00', 1, 108, 'Corte clásico',            2600.00), -- 108 DNI 22283566 en Corta barba
(201, '2024-05-20', '10:30:00', 2, 108, 'Arreglo de barba',         3000.00), -- mismo cliente en Barberia Barbara
(202, '2024-01-05', '09:30:00', 1, 104, 'Corte clásico',            2600.00),
(202, '2024-04-18', '15:30:00', 3, 105, 'Arreglo de barba',         2200.00),
(203, '2024-06-22', '16:00:00', 2, 106, 'Corte + tratamiento',      5400.00), -- >5000
(203, '2024-07-01', '10:15:00', 3, 107, 'Corte degradado',          3600.00),
(204, '2024-02-28', '13:45:00', 2, 108, 'Corte clásico',            2600.00),
(205, '2024-08-12', '14:00:00', 3, 102, 'Tratamiento capilar',      6200.00), -- >5000
(206, '2024-10-20', '17:00:00', 4, 104, 'Afeitado',                 3000.00),
(207, '2024-03-03', '12:30:00', 5, 106, 'Corte clásico',            2600.00),
(208, '2024-12-28', '19:00:00', 5, 109, 'Color + corte',            8200.00), -- >5000

-- 2025 (para variedad)
(201, '2025-01-12', '10:00:00', 1, 101, 'Corte clásico',            2700.00),
(202, '2025-02-10', '11:00:00', 1, 102, 'Corte + barba',            5200.00),
(203, '2025-03-14', '12:00:00', 2, 103, 'Corte clásico',            2700.00),
(204, '2025-04-20', '10:30:00', 2, 108, 'Arreglo de barba',         3200.00),
(205, '2025-06-18', '15:30:00', 3, 110, 'Tratamiento capilar',      6300.00), -- >5000
(206, '2025-07-22', '16:00:00', 4, 111, 'Corte + barba premium',    7100.00), -- cliente 111 (para baja) tiene 2025 pero no 2024
(207, '2025-08-01', '10:15:00', 5, 112, 'Corte degradado',          3700.00),
(208, '2025-09-11', '18:30:00', 5, 107, 'Corte + barba',            4900.00);
