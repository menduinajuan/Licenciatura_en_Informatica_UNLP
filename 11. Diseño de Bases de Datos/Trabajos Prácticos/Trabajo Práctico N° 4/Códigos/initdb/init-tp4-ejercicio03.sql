-- =========================================================
-- CREACIÓN E INICIALIZACIÓN DE LA BASE DE DATOS - Ejercicio 3 (versión extendida)
-- =========================================================

DROP DATABASE IF EXISTS tp4_ejercicio3;
CREATE DATABASE tp4_ejercicio3;
USE tp4_ejercicio3;
SET NAMES utf8mb4;

-- =========================================================
-- TABLAS
-- =========================================================

CREATE TABLE Banda (
  codigoB INT PRIMARY KEY,
  nombreBanda VARCHAR(100) NOT NULL,
  genero_musical VARCHAR(50) NOT NULL,
  anio_creacion INT NOT NULL
);

CREATE TABLE Integrante (
  DNI INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  direccion VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  codigoB INT NOT NULL,
  FOREIGN KEY (codigoB) REFERENCES Banda(codigoB)
);

CREATE TABLE Escenario (
  nroEscenario INT PRIMARY KEY,
  nombre_escenario VARCHAR(100) NOT NULL,
  ubicacion VARCHAR(100) NOT NULL,
  cubierto BOOLEAN NOT NULL,
  m2 INT NOT NULL,
  descripcion VARCHAR(200) NOT NULL
);

CREATE TABLE Recital (
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  nroEscenario INT NOT NULL,
  codigoB INT NOT NULL,
  PRIMARY KEY (fecha, hora, nroEscenario),
  FOREIGN KEY (nroEscenario) REFERENCES Escenario(nroEscenario),
  FOREIGN KEY (codigoB) REFERENCES Banda(codigoB)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- BANDAS
INSERT INTO Banda (codigoB, nombreBanda, genero_musical, anio_creacion) VALUES
(1, 'Los Redondos', 'Rock Nacional', 1976),
(2, 'Soda Stereo', 'Rock', 1982),
(3, 'Los Autenticos Decadentes', 'Pop Rock', 1986),
(4, 'La Mississippi', 'Blues', 1988),
(5, 'Mempis la Blusera', 'Blues', 1980),
(6, 'Los Nocheros', 'Folklore', 1994),
(7, 'Miranda', 'Pop', 2001),
(8, 'Catupecu Machu', 'Rock Alternativo', 1994),
(9, 'Rata Blanca', 'Heavy Metal', 1985),
(10, 'Tan Bionica', 'Pop Rock', 2004);

-- INTEGRANTES
INSERT INTO Integrante (DNI, nombre, apellido, direccion, email, fecha_nacimiento, codigoB) VALUES
-- Los Redondos
(20000111, 'Carlos', 'Indio', 'Calle 1 123', 'indio@mail.com', '1959-01-17', 1),
(20000112, 'Skay', 'Beilinson', 'Calle 2 234', 'skay@mail.com', '1952-01-15', 1),

-- Soda Stereo
(20000113, 'Charly', 'Alberti', 'Calle 3 456', 'charly@soda.com', '1963-03-27', 2),
(20000114, 'Gustavo', 'Cerati', 'Calle 4 567', 'cerati@soda.com', '1959-08-11', 2),
(20000115, 'Zeta', 'Bosio', 'Calle 5 678', 'zeta@soda.com', '1958-10-01', 2),

-- Los Autenticos Decadentes (más de 5 integrantes)
(20000201, 'Cucho', 'Parisi', 'Av Siempreviva 123', 'cucho@decadentes.com', '1965-09-20', 3),
(20000202, 'Mosca', 'Lorenzo', 'Calle 45 456', 'mosca@decadentes.com', '1967-04-30', 3),
(20000203, 'Pablo', 'Lescano', 'Calle 12 999', 'pablo@mail.com', '1977-12-12', 3),
(20000204, 'Eduardo', 'Trucco', 'Calle 10 150', 'edu@decadentes.com', '1972-11-25', 3),
(20000205, 'Diego', 'Demarco', 'Calle 11 222', 'diego@decadentes.com', '1969-07-15', 3),
(20000206, 'Jorge', 'Serrano', 'Calle 12 333', 'jorge@decadentes.com', '1960-03-09', 3),
(20000207, 'Gaston', 'Bernardo', 'Calle 13 444', 'gaston@decadentes.com', '1978-02-02', 3),

-- La Mississippi
(20000116, 'Fernando', 'Vecino', 'Calle 6 999', 'fer@lamississippi.com', '1975-05-20', 4),
(20000208, 'Ricardo', 'Tapia', 'Calle 8 123', 'ricardo@lamississippi.com', '1968-04-08', 4),

-- Memphis la Blusera
(20000118, 'Alejandro', 'Lerner', 'Calle 8 555', 'lerner@mail.com', '1957-06-08', 5),
(20000209, 'Adrian', 'Otero', 'Calle 9 666', 'adrian@memphis.com', '1958-03-31', 5),

-- Los Nocheros
(20000123, 'Raul', 'Martinez', 'Calle 13 111', 'raul@mail.com', '1983-04-04', 6),
(20000124, 'Lucas', 'Salinas', 'Calle 14 222', 'lucas@mail.com', '1986-05-05', 6),
(20000210, 'Alvaro', 'Teruel', 'Calle 15 999', 'alvaro@nocheros.com', '1970-10-15', 6),

-- Miranda
(20000117, 'Martin', 'Piroyansky', 'Calle 7 444', 'martin@miranda.com', '1987-02-18', 7),
(20000211, 'Alejandro', 'Sergio', 'Calle 16 123', 'ale@miranda.com', '1971-02-06', 7),
(20000212, 'Juliana', 'Gattas', 'Calle 17 456', 'juliana@miranda.com', '1978-08-01', 7),

-- Catupecu Machu
(20000125, 'Jorge', 'Perez', 'Calle 15 333', 'jorge@mail.com', '1990-07-15', 8),
(20000213, 'Fernando', 'Ruiz Diaz', 'Calle 18 888', 'fernando@catupecu.com', '1969-03-21', 8),

-- Rata Blanca
(20000119, 'Juan', 'Lopez', 'Calle 9 666', 'juan@mail.com', '1985-09-09', 9),
(20000120, 'Mariano', 'Martinez', 'Calle 10 777', 'mariano@mail.com', '1968-12-15', 9),
(20000214, 'Adrian', 'Barilari', 'Calle 19 555', 'adrian@rata.com', '1959-11-11', 9),
(20000215, 'Guillermo', 'Sanchez', 'Calle 20 111', 'guille@rata.com', '1960-04-17', 9),

-- Tan Bionica
(20000121, 'Brenda', 'Asnicar', 'Calle 11 888', 'brenda@mail.com', '1991-10-17', 10),
(20000216, 'Chano', 'Charpentier', 'Calle 21 444', 'chano@tanbionica.com', '1981-09-23', 10),
(20000217, 'Diego', 'Lichtenstein', 'Calle 22 222', 'diego@tanbionica.com', '1983-03-15', 10);

-- ESCENARIOS
INSERT INTO Escenario (nroEscenario, nombre_escenario, ubicacion, cubierto, m2, descripcion) VALUES
(1, 'Gustavo Cerati', 'La Plata', TRUE, 5000, 'Escenario principal techado'),
(2, 'Carlos Gardel', 'Buenos Aires', TRUE, 4000, 'Escenario de shows acusticos'),
(3, 'Luis Alberto Spinetta', 'Cordoba', FALSE, 6000, 'Escenario al aire libre'),
(4, 'Norberto Napolitano', 'Rosario', FALSE, 4500, 'Escenario secundario'),
(5, 'Leon Gieco', 'Mar del Plata', TRUE, 3000, 'Escenario cerrado para conciertos pequenos');

-- RECITALES
INSERT INTO Recital (fecha, hora, nroEscenario, codigoB) VALUES
('2022-11-10', '21:00:00', 1, 2),
('2023-03-15', '22:00:00', 1, 2),
('2023-04-20', '21:30:00', 2, 4),
('2023-06-05', '20:00:00', 3, 1),
('2023-09-25', '23:00:00', 1, 9),
('2023-12-04', '18:00:00', 1, 2),
('2023-12-04', '19:30:00', 2, 3),
('2023-12-04', '21:00:00', 3, 5),
('2023-12-04', '22:30:00', 4, 9),
('2024-01-12', '21:00:00', 1, 6),
('2024-02-20', '22:00:00', 5, 7),
('2024-05-10', '20:30:00', 1, 8),
('2024-05-20', '20:30:00', 2, 8),
('2024-06-15', '23:00:00', 3, 10);