-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio9;
USE tp4_ejercicio9;
SET NAMES utf8mb4;

-- =========================================================
-- TABLA EMPLEADO
-- =========================================================
CREATE TABLE Empleado (
    DNI INT PRIMARY KEY,
    nombre VARCHAR(60),
    apellido VARCHAR(60),
    telefono VARCHAR(30),
    direccion VARCHAR(120),
    fechaIngreso DATE
);

-- =========================================================
-- TABLA EQUIPO
-- =========================================================
CREATE TABLE Equipo (
    codEquipo INT PRIMARY KEY,
    nombreE VARCHAR(100),
    descTecnologias VARCHAR(200),
    DNILider INT,
    FOREIGN KEY (DNILider) REFERENCES Empleado(DNI)
);

-- =========================================================
-- TABLA PROYECTO
-- (fechaFinP es opcional -> puede ser NULL)
-- =========================================================
CREATE TABLE Proyecto (
    codProyecto INT PRIMARY KEY,
    nombrP VARCHAR(120),
    descripcion VARCHAR(200),
    fechaInicioP DATE,
    fechaFinP DATE NULL,
    fechaFinEstimada DATE,
    DNIResponsable INT,
    equipoBackend INT,
    equipoFrontend INT,
    FOREIGN KEY (DNIResponsable) REFERENCES Empleado(DNI),
    FOREIGN KEY (equipoBackend) REFERENCES Equipo(codEquipo),
    FOREIGN KEY (equipoFrontend) REFERENCES Equipo(codEquipo)
);

-- =========================================================
-- TABLA EMPLEADO_EQUIPO
-- =========================================================
CREATE TABLE Empleado_Equipo (
    codEquipo INT,
    DNI INT,
    fechaInicio DATE,
    fechaFin DATE NULL,
    descripcionRol VARCHAR(120),
    PRIMARY KEY (codEquipo, DNI, fechaInicio),
    FOREIGN KEY (codEquipo) REFERENCES Equipo(codEquipo),
    FOREIGN KEY (DNI) REFERENCES Empleado(DNI)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- EMPLEADOS (incluye 40568965 para la modificación del punto 6)
INSERT INTO Empleado (DNI, nombre, apellido, telefono, direccion, fechaIngreso) VALUES
(40111222, 'Lucía',   'Martínez',   '221-4001001', 'Calle 10 N° 123, La Plata',  '2018-03-01'),
(40222333, 'Santiago','Gómez',      '221-4001002', 'Calle 12 N° 456, La Plata',  '2019-05-10'),
(40333444, 'Ana',     'Rossi',      '11-5001003',  'Av. Siempreviva 742, CABA',  '2017-11-20'),
(40444555, 'Tomás',   'Benítez',    '223-4101004', 'Mitre 1200, Mar del Plata',  '2020-01-15'),
(40555666, 'Carla',   'Acosta',     '351-4201005', 'Colón 300, Córdoba',         '2021-06-01'),
(40655666, 'Iván',    'Ruiz',       '221-4301006', 'Diag. 80 100, La Plata',     '2016-09-05'),
(40766777, 'Pablo',   'Bravo',      '221-4401007', 'Calle 60 123, La Plata',     '2015-02-12'),
(40877888, 'Ramiro',  'Leiva',      '11-4501008',  'Honduras 2000, CABA',        '2014-08-08'),
(40988999, 'Julieta', 'Ledesma',    '223-4601009', 'Luro 500, Mar del Plata',    '2013-04-04'),
(41099000, 'Bruno',   'Sosa',       '221-4701010', '7 y 50, La Plata',           '2022-10-01'),
(41100111, 'Sofía',   'Paz',        '221-4801011', 'Calle 2 200, La Plata',      '2020-12-10'),
(41211222, 'Diego',   'Herrera',    '351-4901012', 'Rivadavia 500, Córdoba',     '2012-03-03'),
(41322333, 'Matías',  'Cano',       '381-5001013', 'Sarmiento 555, Tucumán',     '2019-09-09'),
(41433444, 'Gonzalo', 'Álvarez',    '261-5101014', 'Chile 100, Mendoza',         '2018-07-07'),
(41544555, 'Valentina','Maidana',   '221-5201015', '122 y 49, La Plata',         '2023-03-20'),
(40568965, 'Mario',   'Gómez',      '221-5301016', '14 y 32, La Plata',          '2021-05-05'); -- empleado editable (punto 6)

-- EQUIPOS
-- 40111222 lidera 2 equipos (para el punto 3)
INSERT INTO Equipo (codEquipo, nombreE, descTecnologias, DNILider) VALUES
(501, 'Backend Java A',          'Java, Spring, MySQL',                40111222),
(502, 'Frontend React A',        'JavaScript, React, Vite',            40222333),
(503, 'Data & API',              'Python, FastAPI, PostgreSQL',        40333444),
(504, 'Mobile Kotlin',           'Android, Kotlin',                     40444555),
(505, 'QA & Testing',            'Selenium, JMeter, Cypress',           40655666),
(506, 'Backend Java B',          'Java, Quarkus, PostgreSQL',          40111222), -- mismo líder que 501
(507, 'Java Sin Miembros',       'Java, Spring Boot',                  40877888), -- sin empleados asignados (punto 5)
(508, 'Frontend Angular',        'TypeScript, Angular',                40766777),
(509, 'DevOps & Cloud',          'Docker, Kubernetes, AWS',            41211222);

-- RELACIONES EMPLEADO_EQUIPO (asignaciones; algunas actuales con fechaFin NULL)
INSERT INTO Empleado_Equipo (codEquipo, DNI, fechaInicio, fechaFin, descripcionRol) VALUES
-- Backend Java A (501)
(501, 41099000, '2022-01-10', NULL,           'Dev Backend'),
(501, 41100111, '2022-05-01', '2024-06-30',   'Dev Backend'),
(501, 41544555, '2023-07-01', NULL,           'Dev Backend'),
-- Frontend React A (502)
(502, 40555666, '2021-03-01', NULL,           'Dev Frontend'),
(502, 41100111, '2024-07-01', NULL,           'Dev Frontend'),
-- Data & API (503)
(503, 41433444, '2020-08-15', NULL,           'Data Eng'),
(503, 41322333, '2021-09-01', '2023-12-31',   'API Dev'),
-- Mobile Kotlin (504)
(504, 40444555, '2020-02-01', NULL,           'Líder Mobile'),
(504, 40988999, '2022-04-01', NULL,           'Mobile Dev'),
-- QA (505)
(505, 40655666, '2019-01-01', NULL,           'QA Líder'),
(505, 40111222, '2019-03-01', '2020-03-01',   'Automation'),
-- Backend Java B (506)
(506, 41099000, '2024-01-05', NULL,           'Sr Backend'),
-- Frontend Angular (508)
(508, 40766777, '2018-06-01', NULL,           'Líder Frontend'),
(508, 40568965, '2021-06-01', NULL,           'UI Dev'),
-- DevOps (509)
(509, 41211222, '2017-05-01', NULL,           'DevOps Lead'),
(509, 40333444, '2021-01-01', NULL,           'SRE');

-- PROYECTOS
INSERT INTO Proyecto (codProyecto, nombrP, descripcion, fechaInicioP, fechaFinP, fechaFinEstimada, DNIResponsable, equipoBackend, equipoFrontend) VALUES
(9001, 'Proyecto Alfa', 'E-commerce minorista',          '2022-01-15', '2024-03-10', '2024-02-20', 40988999, 501, 502),
(9002, 'Proyecto Beta', 'App de logística',              '2021-03-01', '2023-08-01', '2023-09-01', 41099000, 503, 508),
(9003, 'Proyecto Gamma','Plataforma analítica',          '2020-07-01', '2021-12-20', '2021-12-01', 41433444, 503, 502),
(9004, 'Proyecto Delta','Mobile banca',                  '2022-05-10', NULL,         '2025-11-30', 40555666, 506, 508),
(9005, 'Proyecto Épsilon','Onboarding digital',          '2024-02-01', NULL,         '2025-06-30', 41100111, 501, 503),
(9006, 'Proyecto X',    'Sistema interno de legajos',    '2023-04-01', '2024-04-15', '2024-04-01', 40988999, 501, 502),
(9007, 'Proyecto Omega','Portal proveedores',            '2021-09-01', '2022-12-15', '2022-10-31', 41211222, 503, 507),
(9008, 'Proyecto Zeta', 'Core bancario',                 '2019-01-01', '2020-12-01', '2020-12-15', 40111222, 506, 508),
(9009, 'Proyecto Sigma','Data Lake corporativo',         '2024-06-01', NULL,         '2025-12-20', 41322333, 503, 509),
(9010, 'Proyecto Kappa','Gestión de tickets',            '2020-02-01', '2023-01-20', '2022-12-15', 40655666, 501, 508),
(9011, 'Proyecto Lambda','App de turnos',                '2023-09-10', NULL,         '2025-03-31', 41544555, 503, 502);
