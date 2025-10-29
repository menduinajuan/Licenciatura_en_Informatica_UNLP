-- ===========================================================
-- EJERCICIO 2 - PODAS DE ÁRBOLES
-- ===========================================================

-- =========================================
-- CREACIÓN DE LA BASE DE DATOS
-- =========================================
DROP DATABASE IF EXISTS tp4_ejercicio2;
CREATE DATABASE tp4_ejercicio2;
USE tp4_ejercicio2;
SET NAMES utf8mb4;

-- =========================================
-- TABLA: Localidad
-- =========================================
CREATE TABLE Localidad (
    codigoPostal INT PRIMARY KEY,
    nombreL VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    nroHabitantes INT NOT NULL
);

-- =========================================
-- TABLA: Arbol
-- =========================================
CREATE TABLE Arbol (
    nroArbol INT PRIMARY KEY,
    especie VARCHAR(100) NOT NULL,
    anios INT NOT NULL,
    calle VARCHAR(100) NOT NULL,
    nro INT NOT NULL,
    codigoPostal INT NOT NULL,
    FOREIGN KEY (codigoPostal) REFERENCES Localidad(codigoPostal)
);

-- =========================================
-- TABLA: Podador
-- =========================================
CREATE TABLE Podador (
    DNI INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    fnac DATE NOT NULL,
    codigoPostalVive INT NOT NULL,
    FOREIGN KEY (codigoPostalVive) REFERENCES Localidad(codigoPostal)
);

-- =========================================
-- TABLA: Poda
-- =========================================
CREATE TABLE Poda (
    codPoda INT PRIMARY KEY,
    fecha DATE NOT NULL,
    DNI INT NOT NULL,
    nroArbol INT NOT NULL,
    FOREIGN KEY (DNI) REFERENCES Podador(DNI),
    FOREIGN KEY (nroArbol) REFERENCES Arbol(nroArbol)
);

-- =========================================
-- INSERCIÓN DE DATOS DE EJEMPLO
-- =========================================

-- Localidades
INSERT INTO Localidad (codigoPostal, nombreL, descripcion, nroHabitantes) VALUES
(1900, 'La Plata', 'Capital de la Provincia de Buenos Aires', 700000),
(4400, 'Salta', 'Ciudad norteña con cerros y valles', 550000),
(5000, 'Córdoba', 'Centro del país, conocida por sus sierras', 800000),
(2000, 'Rosario', 'Ciudad portuaria a orillas del Paraná', 900000),
(8300, 'Neuquén', 'Ciudad patagónica en crecimiento', 350000),
(9100, 'Trelew', 'Ciudad del Chubut, cercana a la costa atlántica', 130000);

-- Árboles
INSERT INTO Arbol (nroArbol, especie, anios, calle, nro, codigoPostal) VALUES
(1, 'Jacarandá', 12, 'Calle 1', 101, 1900),
(2, 'Eucalipto', 20, 'Calle 2', 102, 1900),
(3, 'Tilo', 15, 'Calle 3', 103, 1900),
(4, 'Conífera', 18, 'Calle 4', 104, 1900),
(5, 'Jacarandá', 25, 'Calle 5', 105, 4400),
(6, 'Eucalipto', 22, 'Calle 6', 106, 4400),
(7, 'Tilo', 16, 'Calle 7', 107, 4400),
(8, 'Conífera', 19, 'Calle 8', 108, 4400),
(9, 'Jacarandá', 10, 'Calle 9', 109, 5000),
(10, 'Eucalipto', 12, 'Calle 10', 110, 5000),
(11, 'Tilo', 13, 'Calle 11', 111, 5000),
(12, 'Conífera', 17, 'Calle 12', 112, 5000),
(13, 'Jacarandá', 20, 'Calle 13', 113, 2000),
(14, 'Eucalipto', 23, 'Calle 14', 114, 2000),
(15, 'Tilo', 21, 'Calle 15', 115, 2000),
(16, 'Conífera', 19, 'Calle 16', 116, 2000),
(17, 'Jacarandá', 24, 'Calle 17', 117, 8300),
(18, 'Eucalipto', 11, 'Calle 18', 118, 8300),
(19, 'Tilo', 22, 'Calle 19', 119, 8300),
(20, 'Conífera', 25, 'Calle 20', 120, 8300),
(21, 'Jacarandá', 9, 'Calle 21', 121, 9100),
(22, 'Eucalipto', 15, 'Calle 22', 122, 1900),
(23, 'Tilo', 20, 'Calle 23', 123, 2000),
(24, 'Conífera', 26, 'Calle 24', 124, 4400),
(25, 'Jacarandá', 14, 'Calle 25', 125, 1900),
(26, 'Eucalipto', 19, 'Calle 26', 126, 4400),
(27, 'Tilo', 21, 'Calle 27', 127, 5000),
(28, 'Conífera', 24, 'Calle 28', 128, 2000),
(29, 'Jacarandá', 17, 'Calle 29', 129, 8300),
(30, 'Eucalipto', 18, 'Calle 30', 130, 9100);

-- Podadores
INSERT INTO Podador (DNI, nombre, apellido, telefono, fnac, codigoPostalVive) VALUES
(11122333, 'Juan', 'Perez', '221-4445555', '1985-03-14', 1900),
(22233444, 'Jose', 'Garcia', '387-5556666', '1990-07-22', 4400),
(33344555, 'Maria', 'Zapata', '351-4449999', '1988-11-30', 5000),
(44455666, 'Pedro', 'Gonzalez', '341-4451122', '1982-02-10', 2000),
(55566777, 'Laura', 'Carata', '299-2223333', '1995-09-17', 8300),
(66677888, 'Luis', 'Alata', '223-7788999', '1987-05-25', 9100),
(77788999, 'Sofia', 'Ramirez', '221-1234567', '1991-08-12', 1900),
(88899000, 'Diego', 'Morata', '387-9876543', '1984-12-04', 4400);

-- Podas (diversos años)
INSERT INTO Poda (codPoda, fecha, DNI, nroArbol) VALUES
(1, '2022-05-10', 11122333, 1),
(2, '2023-06-15', 11122333, 2),
(3, '2024-03-20', 22233444, 3),
(4, '2023-08-25', 33344555, 4),
(5, '2022-09-12', 22233444, 5),
(6, '2023-11-02', 55566777, 6),
(7, '2024-01-19', 66677888, 7),
(8, '2022-03-14', 11122333, 8),
(9, '2023-05-10', 22233444, 9),
(10, '2024-04-22', 88899000, 10),
(11, '2023-07-09', 55566777, 11),
(12, '2022-04-15', 44455666, 12),
(13, '2023-10-30', 11122333, 13),
(14, '2024-02-10', 66677888, 14),
(15, '2022-12-22', 33344555, 15),
(16, '2023-09-13', 22233444, 16),
(17, '2024-03-03', 55566777, 17),
(18, '2022-06-25', 11122333, 16),
(19, '2023-07-11', 22233444, 19),
(20, '2023-08-22', 33344555, 20),
(21, '2025-10-10', 22233444, 1),
(22, '2023-10-13', 22233444, 5),
(23, '2023-03-14', 11122333, 8);
