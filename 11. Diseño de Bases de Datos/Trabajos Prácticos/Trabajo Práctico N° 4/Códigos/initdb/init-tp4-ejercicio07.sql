-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio7;
USE tp4_ejercicio7;
SET NAMES utf8mb4;

-- =========================================================
-- TABLA CIUDAD
-- =========================================================
CREATE TABLE Ciudad (
    codigoCiudad INT PRIMARY KEY,
    nombre VARCHAR(80)
);

-- =========================================================
-- TABLA CLUB
-- =========================================================
CREATE TABLE Club (
    codigoClub INT PRIMARY KEY,
    nombre VARCHAR(100),
    anioFundacion INT,
    codigoCiudad INT,
    FOREIGN KEY (codigoCiudad) REFERENCES Ciudad(codigoCiudad)
);

-- =========================================================
-- TABLA ESTADIO
-- =========================================================
CREATE TABLE Estadio (
    codigoEstadio INT PRIMARY KEY,
    codigoClub INT,
    nombre VARCHAR(120),
    direccion VARCHAR(150),
    FOREIGN KEY (codigoClub) REFERENCES Club(codigoClub)
);

-- =========================================================
-- TABLA JUGADOR
-- =========================================================
CREATE TABLE Jugador (
    DNI INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    codigoCiudad INT,
    FOREIGN KEY (codigoCiudad) REFERENCES Ciudad(codigoCiudad)
);

-- =========================================================
-- TABLA CLUBJUGADOR
-- =========================================================
CREATE TABLE ClubJugador (
    codigoClub INT,
    DNI INT,
    desde DATE,
    hasta DATE,
    PRIMARY KEY (codigoClub, DNI, desde),
    FOREIGN KEY (codigoClub) REFERENCES Club(codigoClub),
    FOREIGN KEY (DNI) REFERENCES Jugador(DNI)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- CIUDADES
INSERT INTO Ciudad (codigoCiudad, nombre) VALUES
(1,  'La Plata'),
(2,  'Berisso'),
(3,  'Ensenada'),
(4,  'Mar del Plata'),
(5,  'Córdoba'),
(6,  'Rosario'),
(7,  'Buenos Aires'),
(8,  'Santa Fe'),
(9,  'Mendoza'),
(10, 'Bahía Blanca'),
(11, 'Quilmes'),
(12, 'Avellaneda'),
(13, 'Tandil'),
(14, 'San Juan'),
(15, 'Neuquén');

-- CLUBES
INSERT INTO Club (codigoClub, nombre, anioFundacion, codigoCiudad) VALUES
(1001, 'Gimnasia y Esgrima La Plata', 1887, 1),
(1002, 'Estudiantes de La Plata', 1905, 1),
(1003, 'Tolosano FC', 1932, 1),
(1004, 'AD Ringuelet', 1940, 1),
(1101, 'Villa San Carlos', 1925, 2),
(1102, 'Deportivo Berisso', 1930, 2),
(1201, 'Defensores de Cambaceres', 1921, 3),
(1301, 'Aldosivi', 1913, 4),
(1302, 'Alvarado', 1928, 4),
(2001, 'Talleres', 1913, 5),
(2002, 'Belgrano', 1905, 5),
(2003, 'Instituto', 1918, 5),
(3001, 'Rosario Central', 1889, 6),
(3002, 'Newell''s Old Boys', 1903, 6),
(4001, 'River Plate', 1901, 7),
(4002, 'Boca Juniors', 1905, 7),
(4003, 'Argentinos Juniors', 1904, 7),
(4101, 'Quilmes AC', 1887, 11),
(4201, 'Racing Club', 1903, 12),
(4202, 'Independiente', 1905, 12);

-- ESTADIOS
INSERT INTO Estadio (codigoEstadio, codigoClub, nombre, direccion) VALUES
(501, 1001, 'Estadio Juan Carmelo Zerillo', 'Av. 60 y 118, La Plata'),
(502, 1002, 'Estadio Jorge Luis Hirschi', '1 y 57, La Plata'),
(503, 1101, 'Estadio Genacio Salice', 'Calle 173 y 42, Berisso'),
(504, 1201, '12 de Octubre', 'Camino Rivadavia 1050, Ensenada'),
(505, 1301, 'Estadio José María Minella', 'Av. de las Olimpiadas s/n, MDP'),
(506, 2001, 'Mario Alberto Kempes', 'Av. Cárcano 3450, Córdoba'),
(507, 2002, 'Gigante de Alberdi', 'Arturo Orgaz 510, Córdoba'),
(508, 3001, 'Gigante de Arroyito', 'Av. Génova 790, Rosario'),
(509, 3002, 'Estadio Marcelo Bielsa', 'Parque Independencia, Rosario'),
(510, 4001, 'Monumental', 'Av. Figueroa Alcorta 7597, CABA'),
(511, 4002, 'La Bombonera', 'Brandsen 805, CABA');

-- JUGADORES
INSERT INTO Jugador (DNI, nombre, apellido, edad, codigoCiudad) VALUES
(20000001, 'Lucas', 'Martínez', 27, 1),
(20000002, 'Santiago', 'Gómez', 31, 5),
(20000003, 'Matías', 'Rossi', 24, 2),
(20000004, 'Franco', 'Almada', 29, 4),
(20000005, 'Bruno', 'Sosa', 33, 7),
(20000006, 'Julian', 'Pérez', 22, 2),
(20000007, 'Agustín', 'Benítez', 28, 5),
(20000008, 'Tomás', 'Herrera', 30, 6),
(20000009, 'Nicolás', 'Díaz', 26, 1),
(20000010, 'Diego', 'Acosta', 35, 5),
(20000011, 'Iván', 'Ruiz', 21, 3),
(20000012, 'Ezequiel', 'Funes', 32, 4),
(20000013, 'Gonzalo', 'Álvarez', 25, 11),
(20000014, 'Hernán', 'Maidana', 29, 12),
(20000015, 'Pablo', 'Bravo', 23, 9),
(20000016, 'Facundo', 'López', 27, 8),
(20000017, 'Pedro', 'Cano', 34, 5),
(20000018, 'Marcos', 'Vega', 20, 2),
(20000019, 'Alejo', 'Ibarra', 28, 4),
(20000020, 'Ramiro', 'Leiva', 31, 5),
(20000021, 'Sergio', 'Nieto', 22, 6),
(20000022, 'Lautaro', 'Giménez', 24, 1),
(20000023, 'Thiago', 'Paz', 26, 10),
(20000024, 'Emiliano', 'Suárez', 33, 4),
(20000025, 'Joaquín', 'Ramos', 27, 7),
(20000026, 'Matías', 'Orozco', 29, 15),
(20000027, 'Bautista', 'Cáceres', 19, 3),
(20000028, 'Kevin', 'Molina', 28, 2),
(20000029, 'Nahuel', 'Roldán', 30, 5),
(20000030, 'Alan', 'Correa', 21, 13),
(20000031, 'Julián', 'Ledesma', 25, 4),
(20000032, 'Cristian', 'Ortiz', 27, 1),
(20000033, 'Damián', 'Silva', 22, 2),
(20000034, 'Leonel', 'Ferrari', 34, 5),
(20000035, 'Esteban', 'Montiel', 23, 6),
(20000036, 'Diego', 'Cardozo', 32, 4),
(20000037, 'Maximiliano','Rico', 28, 7),
(20000038, 'Gabriel', 'Vera', 26, 1),
(20000039, 'Ariel', 'Frías', 29, 9),
(20000040, 'Fabián', 'Tevez', 24, 12);

-- HISTORIAL DE CLUBES Y JUGADORES
INSERT INTO ClubJugador (codigoClub, DNI, desde, hasta) VALUES
(1001, 20000001, '2021-07-01', NULL),
(1001, 20000003, '2020-01-15', '2022-12-31'),
(1001, 20000009, '2022-02-01', NULL),
(1001, 20000022, '2023-01-01', NULL),
(1001, 20000032, '2019-07-01', '2021-06-30'),
(1002, 20000005, '2018-07-01', '2020-06-30'),
(1002, 20000013, '2022-01-10', NULL),
(1002, 20000025, '2021-02-01', NULL),
(1002, 20000038, '2020-07-01', '2022-06-30'),
(1003, 20000011, '2023-01-01', NULL),
(1003, 20000021, '2024-01-10', NULL),
(1004, 20000027, '2024-02-01', NULL),
(1101, 20000006, '2022-03-01', NULL),
(1101, 20000018, '2024-07-01', NULL),
(1101, 20000028, '2020-01-01', '2021-12-31'),
(1102, 20000033, '2021-01-15', NULL),
(1201, 20000003, '2018-01-01', '2019-12-31'),
(1201, 20000027, '2022-01-01', '2023-01-31'),
(1301, 20000004, '2019-07-01', '2021-06-30'),
(1301, 20000012, '2017-01-01', '2018-12-31'),
(1301, 20000019, '2023-01-01', NULL),
(1302, 20000031, '2021-02-01', NULL),
(1302, 20000024, '2018-03-01', '2020-12-31'),
(1302, 20000036, '2022-01-01', NULL),
(2001, 20000002, '2019-01-01', '2020-12-31'),
(2002, 20000002, '2021-01-01', '2022-12-31'),
(2003, 20000002, '2023-01-01', NULL),
(2001, 20000010, '2016-01-01', '2018-12-31'),
(2002, 20000010, '2019-01-01', '2020-12-31'),
(2003, 20000010, '2021-01-01', '2022-12-31'),
(2001, 20000017, '2015-01-01', '2016-12-31'),
(2002, 20000017, '2017-01-01', '2018-12-31'),
(2003, 20000017, '2019-01-01', '2020-12-31'),
(2001, 20000020, '2018-01-01', '2019-12-31'),
(2002, 20000020, '2020-01-01', NULL),
(2001, 20000029, '2017-01-01', '2018-12-31'),
(2002, 20000029, '2019-01-01', '2020-12-31'),
(2003, 20000029, '2021-01-01', '2022-12-31'),
(2001, 20000034, '2013-01-01', '2014-12-31'),
(2002, 20000034, '2015-01-01', '2016-12-31'),
(2003, 20000034, '2017-01-01', '2018-12-31'),
(3001, 20000008, '2020-01-01', '2021-12-31'),
(3002, 20000008, '2022-01-01', NULL),
(3001, 20000035, '2023-01-10', NULL),
(4001, 20000005, '2021-07-01', NULL),
(4002, 20000037, '2020-03-01', NULL),
(4003, 20000023, '2022-02-01', NULL),
(4101, 20000013, '2019-01-01', '2021-01-09'),
(4201, 20000014, '2020-01-01', NULL),
(4202, 20000040, '2021-01-01', NULL),
(1301, 20000022, '2020-01-01', '2022-12-31'),
(3002, 20000022, '2018-01-01', '2019-12-31'),
(1201, 20000009, '2020-01-01', '2021-12-31'),
(3001, 20000009, '2018-01-01', '2019-12-31'),
(1101, 20000038, '2022-07-01', NULL),
(1302, 20000038, '2019-01-01', '2021-12-31'),
(1302, 20000024, '2021-01-01', '2021-12-31'),
(1301, 20000024, '2022-01-01', NULL),
(1002, 20000031, '2019-01-01', '2020-12-31');
