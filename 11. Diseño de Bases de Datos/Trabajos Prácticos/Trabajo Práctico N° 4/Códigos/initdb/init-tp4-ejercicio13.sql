-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio13;
USE tp4_ejercicio13;
SET NAMES utf8mb4;

-- =========================================================
-- TABLA CLUB
-- =========================================================
CREATE TABLE Club (
    IdClub INT PRIMARY KEY,
    nombreClub VARCHAR(120),
    ciudad VARCHAR(80)
);

-- =========================================================
-- TABLA COMPLEJO
-- =========================================================
CREATE TABLE Complejo (
    IdComplejo INT PRIMARY KEY,
    nombreComplejo VARCHAR(120),
    IdClub INT,
    FOREIGN KEY (IdClub) REFERENCES Club(IdClub)
);

-- =========================================================
-- TABLA CANCHA
-- =========================================================
CREATE TABLE Cancha (
    IdCancha INT PRIMARY KEY,
    nombreCancha VARCHAR(120),
    IdComplejo INT,
    FOREIGN KEY (IdComplejo) REFERENCES Complejo(IdComplejo)
);

-- =========================================================
-- TABLA ENTRENADOR
-- =========================================================
CREATE TABLE Entrenador (
    IdEntrenador INT PRIMARY KEY,
    nombreEntrenador VARCHAR(120),
    fechaNacimiento DATE,
    direccion VARCHAR(160)
);

-- =========================================================
-- TABLA ENTRENAMIENTO
-- =========================================================
CREATE TABLE Entrenamiento (
    IdEntrenamiento INT PRIMARY KEY,
    fecha DATE,
    IdEntrenador INT,
    IdCancha INT,
    FOREIGN KEY (IdEntrenador) REFERENCES Entrenador(IdEntrenador),
    FOREIGN KEY (IdCancha) REFERENCES Cancha(IdCancha)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- CLUBES (incluye obligatorios: Facultad de Informática FC y Cátedra de DBD FC)
INSERT INTO Club (IdClub, nombreClub, ciudad) VALUES
(1,  'Everton',                     'La Plata'),
(2,  'Estrella de Berisso',         'Berisso'),
(3,  'Gimnasia y Esgrima La Plata', 'La Plata'),
(4,  'Estudiantes de La Plata',     'La Plata'),
(5,  'Villa San Carlos',            'Berisso'),
(6,  'Facultad de Informática FC',  'La Plata'),
(7,  'Cátedra de DBD FC',           'La Plata'),
(8,  'AD Ringuelet',                'La Plata'),
(9,  'Tolosano FC',                 'La Plata'),
(10, 'San Lorenzo',                 'CABA');

-- COMPLEJOS
INSERT INTO Complejo (IdComplejo, nombreComplejo, IdClub) VALUES
(101, 'Complejo 1',           1),  -- Everton (para consulta 2)
(102, 'Complejo 2',           2),  -- Estrella de Berisso
(103, 'Predio Juan C',        3),
(104, 'Country City Bell',    4),
(105, 'Predio Berisso Sur',   5),
(106, 'Campus Informática',   6),  -- Facultad de Informática FC
(107, 'Laboratorio DBD',      7),  -- Cátedra de DBD FC
(108, 'Predio Ringuelet',     8),
(109, 'Polideportivo Tolos',  9),
(110, 'Ciudad Deportiva',     10);

-- CANCHAS (varias por complejo 101 para conteos 2022)
INSERT INTO Cancha (IdCancha, nombreCancha, IdComplejo) VALUES
(1001, 'Cancha A Everton',   101),
(1002, 'Cancha B Everton',   101),
(1003, 'Cancha C Everton',   101),
(1004, 'Cancha Estrella A',  102),
(1005, 'Cancha Estrella B',  102),
(1006, 'Bosque 1',           103),
(1007, 'Bosque 2',           103),
(1008, 'UNO 1',              104),
(1009, 'UNO 2',              104),
(1010, 'San Carlos 1',       105),
(1011, 'San Carlos 2',       105),
(1012, 'INF Lab 1',          106),
(1013, 'INF Lab 2',          106),
(1014, 'DBD Arena',          107),
(1015, 'Ringuelet 1',        108),
(1016, 'Tolosano 1',         109),
(1017, 'Cuervo 1',           110);

-- ENTRENADORES (incluye Jorge Gonzalez, Marcos Perez y Juan Perez)
INSERT INTO Entrenador (IdEntrenador, nombreEntrenador, fechaNacimiento, direccion) VALUES
(201, 'Jorge Gonzalez', '1980-02-15', 'Calle 10 123, La Plata'),
(202, 'Marcos Perez',   '1985-07-30', 'Calle 12 456, La Plata'),
(203, 'Juan Perez',     '1978-11-20', 'Calle 8 789, Berisso'),
(204, 'Sofia Rojas',    '1990-05-05', 'Av 7 1111, La Plata'),
(205, 'Carlos Gomez',   '1975-09-09', 'Diag 80 300, La Plata'),
(206, 'Lucia Fernandez','1988-01-25', 'Av 60 200, Ensenada'),
(207, 'Pedro Alvarez',  '1982-03-18', 'Calle 1 999, La Plata'),
(208, 'Maria Lopez',    '1992-12-12', 'Av 13 1300, La Plata'),
(209, 'Diego Torres',   '1987-04-22', 'Calle 44 500, Berisso'),
(210, 'Ana Castro',     '1991-06-10', 'Calle 6 345, La Plata');

-- ENTRENAMIENTOS
-- 2022 (para conteo por canchas de "Complejo 1")
INSERT INTO Entrenamiento (IdEntrenamiento, fecha, IdEntrenador, IdCancha) VALUES
(3001, '2022-02-10', 201, 1001),
(3002, '2022-03-05', 202, 1001),
(3003, '2022-03-18', 204, 1002),
(3004, '2022-04-01', 205, 1002),
(3005, '2022-04-20', 201, 1003),
(3006, '2022-05-15', 206, 1001),
(3007, '2022-06-02', 202, 1002),
(3008, '2022-07-10', 207, 1003),
(3009, '2022-08-25', 208, 1001),
(3010, '2022-09-12', 209, 1002),
(3011, '2022-10-05', 210, 1003),
(3012, '2022-11-20', 203, 1001),

-- 2023 (para listar entrenadores con actividad 2023 y para Jorge Gonzalez en varios complejos)
(3101, '2023-01-15', 201, 1004), -- Estrella de Berisso
(3102, '2023-02-10', 201, 1006), -- GELP (Predio Juan C)
(3103, '2023-03-18', 201, 1008), -- Estudiantes (Country City Bell)
(3104, '2023-04-05', 202, 1010), -- Villa San Carlos
(3105, '2023-04-25', 204, 1001), -- Everton
(3106, '2023-05-20', 205, 1005), -- Estrella de Berisso
(3107, '2023-06-12', 206, 1012), -- Facultad de Informática FC
(3108, '2023-07-01', 207, 1014), -- Cátedra de DBD FC
(3109, '2023-08-08', 208, 1016), -- Tolosano
(3110, '2023-09-09', 209, 1015), -- Ringuelet
(3111, '2023-10-10', 210, 1017), -- San Lorenzo
(3112, '2023-11-22', 203, 1009), -- Juan Perez (para luego borrar en #6 si se desea)

-- 2024 (varios para requerimientos 4 y 5)
(3201, '2024-01-10', 202, 1001), -- Marcos en Everton
(3202, '2024-02-14', 202, 1004), -- Marcos en Estrella de Berisso
(3203, '2024-03-12', 202, 1012), -- Marcos en Inf FC
(3204, '2024-04-18', 202, 1014), -- Marcos en Cátedra DBD FC
(3205, '2024-05-05', 204, 1001), -- Sofia en Everton
(3206, '2024-05-20', 204, 1004), -- Sofia en Estrella (cumple #4)
(3207, '2024-06-06', 201, 1005), -- Jorge Estrella
(3208, '2024-07-07', 201, 1002), -- Jorge Everton
(3209, '2024-08-08', 205, 1006),
(3210, '2024-09-09', 206, 1007),
(3211, '2024-10-10', 207, 1008),
(3212, '2024-11-11', 208, 1009),

-- 2025 (variación y datos actuales)
(3301, '2025-01-15', 201, 1012),
(3302, '2025-02-20', 203, 1001), -- Juan Perez (para tener datos que luego se puedan eliminar)
(3303, '2025-03-22', 202, 1010),
(3304, '2025-04-30', 204, 1011),
(3305, '2025-06-05', 205, 1013),
(3306, '2025-07-12', 206, 1015),
(3307, '2025-08-18', 207, 1016),
(3308, '2025-09-25', 208, 1017);
