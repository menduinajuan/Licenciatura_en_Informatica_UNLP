-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio8;
USE tp4_ejercicio8;
SET NAMES utf8mb4;

-- =========================================================
-- TABLA EQUIPO
-- =========================================================
CREATE TABLE Equipo (
    codigoE INT PRIMARY KEY,
    nombreE VARCHAR(100),
    descripcionE VARCHAR(150)
);

-- =========================================================
-- TABLA INTEGRANTE
-- =========================================================
CREATE TABLE Integrante (
    DNI INT PRIMARY KEY,
    nombre VARCHAR(60),
    apellido VARCHAR(60),
    ciudad VARCHAR(80),
    email VARCHAR(120),
    telefono VARCHAR(30),
    codigoE INT,
    FOREIGN KEY (codigoE) REFERENCES Equipo(codigoE)
);

-- =========================================================
-- TABLA LAGUNA
-- =========================================================
CREATE TABLE Laguna (
    nroLaguna INT PRIMARY KEY,
    nombreL VARCHAR(120),
    ubicacion VARCHAR(120),
    extension VARCHAR(60),
    descripcion VARCHAR(150)
);

-- =========================================================
-- TABLA TORNEO DE PESCA
-- =========================================================
CREATE TABLE TorneoPesca (
    codTorneo INT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    nroLaguna INT,
    descripcion VARCHAR(150),
    FOREIGN KEY (nroLaguna) REFERENCES Laguna(nroLaguna)
);

-- =========================================================
-- TABLA INSCRIPCION
-- =========================================================
CREATE TABLE Inscripcion (
    codTorneo INT,
    codigoE INT,
    asistio BOOLEAN,
    gano BOOLEAN,
    PRIMARY KEY (codTorneo, codigoE),
    FOREIGN KEY (codTorneo) REFERENCES TorneoPesca(codTorneo),
    FOREIGN KEY (codigoE) REFERENCES Equipo(codigoE)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- LAGUNAS
INSERT INTO Laguna (nroLaguna, nombreL, ubicacion, extension, descripcion) VALUES
(1, 'Laguna de Chascomús', 'Chascomús, Buenos Aires', '3040 ha', 'Clásica laguna bonaerense'),
(2, 'La Salada, Coronel Granada', 'Gral. Pinto, Buenos Aires', '2500 ha', 'Pejerrey notable'),
(3, 'Laguna de Gómez', 'Junín, Buenos Aires', '2000 ha', 'Espigón y costa'),
(4, 'Laguna de Rocha', 'Chacabuco, Buenos Aires', '1800 ha', 'Acceso público'),
(5, 'Laguna Mar Chiquita (Cba)', 'Córdoba', '6000 km²', 'Gran cuenca salina'),
(6, 'Laguna Las Perdices', 'Azul, Buenos Aires', '900 ha', 'Sin torneos cargados');

-- EQUIPOS
INSERT INTO Equipo (codigoE, nombreE, descripcionE) VALUES
(2001, 'Pescadores LP', 'Equipo de La Plata'),
(2002, 'Los Dorados', 'Equipo cordobés competitivo'),
(2003, 'Berisso Fishing', 'Equipo del partido de Berisso'),
(2004, 'MDQ Pejerrey', 'Equipo marplatense'),
(2005, 'Team Laguna', 'Participa esporádicamente'),
(2006, 'Todo2020', 'Solo torneos 2020'),
(2007, 'TodosEnTodas', 'Participa en todas las lagunas con torneos'),
(2008, 'Sin2023Con2024', 'Inscripto en 2024, no en 2023'),
(2009, 'Chascomús Winners', 'Fuerte en la laguna de Chascomús'),
(10000, 'Equipo a eliminar', 'Para prueba de eliminación');

-- INTEGRANTES (varios de La Plata y equipos con >=5 integrantes)
INSERT INTO Integrante (DNI, nombre, apellido, ciudad, email, telefono, codigoE) VALUES
-- Pescadores LP (La Plata)
(30000001, 'Juan', 'Martínez', 'La Plata', 'juan.martinez@lp.com', '221-4000001', 2001),
(30000002, 'Ana', 'Gómez', 'La Plata', 'ana.gomez@lp.com', '221-4000002', 2001),
(30000003, 'Carlos', 'Ríos', 'La Plata', 'carlos.rios@lp.com', '221-4000003', 2001),
(30000004, 'Lucía', 'Suárez', 'Ensenada', 'lucia.suarez@lp.com', '221-4000004', 2001),
(30000005, 'Pedro', 'Acosta', 'Berisso', 'pedro.acosta@lp.com', '221-4000005', 2001),

-- Los Dorados (>=5 integrantes)
(30000011, 'Santiago', 'Paz', 'Córdoba', 'santiago.paz@dorados.com', '351-5000011', 2002),
(30000012, 'Bruno', 'Sosa', 'Córdoba', 'bruno.sosa@dorados.com', '351-5000012', 2002),
(30000013, 'Tomás', 'Herrera', 'Villa Allende', 'tomas.herrera@dorados.com', '351-5000013', 2002),
(30000014, 'Julián', 'Díaz', 'Córdoba', 'julian.diaz@dorados.com', '351-5000014', 2002),
(30000015, 'Iván', 'Ruiz', 'Río Cuarto', 'ivan.ruiz@dorados.com', '351-5000015', 2002),

-- Berisso Fishing
(30000021, 'Agustín', 'Benítez', 'Berisso', 'agustin.benitez@bf.com', '221-4100021', 2003),
(30000022, 'Ezequiel', 'Funes', 'La Plata', 'ezequiel.funes@bf.com', '221-4100022', 2003),
(30000023, 'Gonzalo', 'Álvarez', 'Berisso', 'gonzalo.alvarez@bf.com', '221-4100023', 2003),
(30000024, 'Hernán', 'Maidana', 'Berisso', 'hernan.maidana@bf.com', '221-4100024', 2003),

-- MDQ Pejerrey (>=5 integrantes)
(30000031, 'Pablo', 'Bravo', 'Mar del Plata', 'pablo.bravo@mdq.com', '223-4200031', 2004),
(30000032, 'Facundo', 'López', 'Mar del Plata', 'facundo.lopez@mdq.com', '223-4200032', 2004),
(30000033, 'Pedro', 'Cano', 'Mar del Plata', 'pedro.cano@mdq.com', '223-4200033', 2004),
(30000034, 'Ramiro', 'Leiva', 'Mar del Plata', 'ramiro.leiva@mdq.com', '223-4200034', 2004),
(30000035, 'Leonel', 'Ferrari', 'Mar del Plata', 'leonel.ferrari@mdq.com', '223-4200035', 2004),

-- Team Laguna (sin inscripciones 2023)
(30000041, 'Sergio', 'Nieto', 'Junín', 'sergio.nieto@tl.com', '236-4300041', 2005),
(30000042, 'Lautaro', 'Giménez', 'La Plata', 'lautaro.gimenez@tl.com', '221-4300042', 2005),
(30000043, 'Thiago', 'Paz', 'Chacabuco', 'thiago.paz@tl.com', '2352-4300043', 2005),

-- Todo2020 (solo 2020)
(30000051, 'Emiliano', 'Suárez', 'Olavarría', 'emiliano.suarez@2020.com', '2284-4400051', 2006),
(30000052, 'Joaquín', 'Ramos', 'Junín', 'joaquin.ramos@2020.com', '236-4400052', 2006),

-- TodosEnTodas (participa en todas las lagunas con torneos)
(30000061, 'Matías', 'Orozco', 'CABA', 'matias.orozco@tet.com', '11-4500061', 2007),
(30000062, 'Bautista', 'Cáceres', 'La Plata', 'bautista.caceres@tet.com', '221-4500062', 2007),
(30000063, 'Kevin', 'Molina', 'Rosario', 'kevin.molina@tet.com', '341-4500063', 2007),
(30000064, 'Nahuel', 'Roldán', 'Córdoba', 'nahuel.roldan@tet.com', '351-4500064', 2007),

-- Sin2023Con2024 (solo 2024)
(30000071, 'Alan', 'Correa', 'Chascomús', 'alan.correa@s2424.com', '2241-4600071', 2008),
(30000072, 'Julián', 'Ledesma', 'Chacabuco', 'julian.ledesma@s2424.com', '2352-4600072', 2008),

-- Chascomús Winners
(30000081, 'Cristian', 'Ortiz', 'Chascomús', 'cristian.ortiz@cw.com', '2241-4700081', 2009),
(30000082, 'Damián', 'Silva', 'La Plata', 'damian.silva@cw.com', '221-4700082', 2009),
(30000083, 'Gabriel', 'Vera', 'La Plata', 'gabriel.vera@cw.com', '221-4700083', 2009);

-- TORNEOS (2020, 2021, 2022, 2023, 2024)
INSERT INTO TorneoPesca (codTorneo, fecha, hora, nroLaguna, descripcion) VALUES
(101, '2020-03-15', '09:00:00', 1, 'Apertura Chascomús 2020'),
(102, '2020-11-20', '08:30:00', 3, 'Clausura Gómez 2020'),
(109, '2021-12-12', '09:00:00', 4, 'Rocha 2021'),
(108, '2022-09-04', '09:00:00', 2, 'Primavera La Salada 2022'),
(103, '2023-01-22', '07:00:00', 1, 'Verano Chascomús 2023'),
(104, '2023-05-14', '09:30:00', 2, 'Otoño La Salada 2023'),
(105, '2023-10-01', '08:00:00', 5, 'Pejerrey Mar Chiquita 2023'),
(106, '2024-02-18', '07:30:00', 2, 'Temporada La Salada 2024'),
(107, '2024-07-07', '08:00:00', 3, 'Invierno Gómez 2024');

-- INSCRIPCIONES (asistio / gano como booleanos)
-- 2020: torneos 101 (Chascomús) y 102 (Gómez) -> equipos 2001, 2002, 2006, 2009
INSERT INTO Inscripcion (codTorneo, codigoE, asistio, gano) VALUES
(101, 2001, TRUE, FALSE),
(101, 2002, TRUE, TRUE),   -- Los Dorados ganan Chascomús 2020
(101, 2006, TRUE, FALSE),  -- Solo 2020
(101, 2009, TRUE, FALSE),  -- Presencia de Chascomús Winners en 2020
(102, 2001, TRUE, FALSE),
(102, 2002, TRUE, FALSE),
(102, 2006, TRUE, TRUE),   -- Todo2020 gana Gómez 2020

-- 2021: torneo 109 (Rocha)
(109, 2004, TRUE, TRUE),
(109, 2007, TRUE, FALSE),

-- 2022: torneo 108 (La Salada) -> Team Laguna participa, sin 2023
(108, 2005, TRUE, FALSE),
(108, 2002, TRUE, FALSE),

-- 2023: torneos 103 (Chascomús), 104 (La Salada), 105 (Mar Chiquita)
(103, 2001, TRUE, TRUE),    -- Pescadores LP ganan en Chascomús 2023
(103, 2002, TRUE, FALSE),
(103, 2009, TRUE, FALSE),   -- Chascomús Winners participan 2023
(104, 2001, TRUE, FALSE),
(104, 2002, TRUE, TRUE),    -- Los Dorados ganan La Salada 2023
(104, 2003, TRUE, FALSE),
(105, 2002, TRUE, FALSE),
(105, 2004, TRUE, TRUE),    -- MDQ gana Mar Chiquita 2023
(105, 2007, TRUE, FALSE),

-- 2024: torneos 106 (La Salada) y 107 (Gómez)
(106, 2008, TRUE, FALSE),   -- Solo 2024
(106, 2002, TRUE, FALSE),
(106, 2007, TRUE, TRUE),
(107, 2008, TRUE, TRUE),    -- Solo 2024 (gana en 2024)
(107, 2007, TRUE, FALSE),
(107, 2004, TRUE, FALSE);
