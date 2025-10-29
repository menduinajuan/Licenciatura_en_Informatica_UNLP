-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio11;
USE tp4_ejercicio11;
SET NAMES utf8mb4;

-- =========================================================
-- TABLA BOX
-- =========================================================
CREATE TABLE Box (
    nroBox INT PRIMARY KEY,
    m2 INT,
    ubicacion VARCHAR(120),
    capacidad VARCHAR(60),   -- descripción (p.ej., 'Chico', 'Mediano', 'Grande')
    ocupacion INT            -- cantidad de mascotas actualmente en el box
);

-- =========================================================
-- TABLA MASCOTA
-- =========================================================
CREATE TABLE Mascota (
    codMascota INT PRIMARY KEY,
    nombre VARCHAR(80),
    edad INT,
    raza VARCHAR(80),
    peso INT,
    telefonoContacto VARCHAR(40)
);

-- =========================================================
-- TABLA VETERINARIO
-- Nota: usamos matrícula como VARCHAR para admitir formatos 'MP 1000', 'MN 4545'.
-- CUIT es clave candidata única.
-- =========================================================
CREATE TABLE Veterinario (
    matricula VARCHAR(20) PRIMARY KEY,
    CUIT VARCHAR(20) UNIQUE,
    nombYAp VARCHAR(120),
    direccion VARCHAR(160),
    telefono VARCHAR(40)
);

-- =========================================================
-- TABLA SUPERVISION
-- Clave primaria compuesta: (codMascota, nroBox, fechaEntra)
-- fechaSale NULL => la mascota permanece en el box actualmente.
-- =========================================================
CREATE TABLE Supervision (
    codMascota INT,
    nroBox INT,
    fechaEntra DATE,
    fechaSale DATE NULL,
    matricula VARCHAR(20),
    descripcionEstadia VARCHAR(160),
    PRIMARY KEY (codMascota, nroBox, fechaEntra),
    FOREIGN KEY (codMascota) REFERENCES Mascota(codMascota),
    FOREIGN KEY (nroBox) REFERENCES Box(nroBox),
    FOREIGN KEY (matricula) REFERENCES Veterinario(matricula)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- BOXES (algunos con ocupación > 0 por supervisiones abiertas)
INSERT INTO Box (nroBox, m2, ubicacion, capacidad, ocupacion) VALUES
(1, 6,  'Pabellón A', 'Chico',   0),
(2, 8,  'Pabellón A', 'Mediano', 0),
(3, 10, 'Pabellón A', 'Grande',  1),
(4, 5,  'Pabellón B', 'Chico',   0),
(5, 7,  'Pabellón B', 'Mediano', 1),
(6, 12, 'Pabellón B', 'Grande',  0),
(7, 9,  'Pabellón C', 'Mediano', 0),
(8, 11, 'Pabellón C', 'Grande',  2),
(9, 6,  'Pabellón C', 'Chico',   0),
(10, 8, 'Pabellón D', 'Mediano', 0),
(11, 10,'Pabellón D', 'Grande',  0),
(12, 5, 'Pabellón D', 'Chico',   0),
(13, 7, 'Pabellón E', 'Mediano', 0),
(14, 9, 'Pabellón E', 'Mediano', 0),
(15, 11,'Pabellón E', 'Grande',  0),
(16, 6, 'Pabellón F', 'Chico',   1),
(17, 8, 'Pabellón F', 'Mediano', 0),
(18, 10,'Pabellón F', 'Grande',  0),
(19, 7, 'Pabellón G', 'Mediano', 0),
(20, 9, 'Pabellón G', 'Mediano', 0);

-- MASCOTAS
INSERT INTO Mascota (codMascota, nombre, edad, raza, peso, telefonoContacto) VALUES
(1001, 'Luna',     3,  'Labrador',          28, '221-5000001'),
(1002, 'Max',      5,  'Ovejero Alemán',   34, '221-5000002'),
(1003, 'Milo',     2,  'Beagle',            12, '221-5000003'),
(1004, 'Nala',     4,  'Golden Retriever',  30, '221-5000004'),
(1005, 'Rocky',    6,  'Bulldog Francés',   11, '221-5000005'),
(1006, 'Olivia',   1,  'Caniche',            6, '221-5000006'),
(1007, 'Simba',    7,  'Boxer',             29, '221-5000007'),
(1008, 'Lola',     5,  'Dálmata',           25, '221-5000008'),
(1009, 'Ciro',     4,  'Mestizo',           18, '221-5000009'),
(1010, 'Toby',     2,  'Border Collie',     20, '221-5000010'),
(1011, 'India',    3,  'Siames (gato)',      4, '221-5000011'),
(1012, 'Mora',     1,  'Mestizo',           10, '221-5000012'),
(1013, 'Bobby',    8,  'Caniche',            7, '221-5000013'),
(1014, 'Rocco',    5,  'Pitbull',           28, '221-5000014'),
(1015, 'Tomas',    2,  'Gato común',         5, '221-5000015'),
(1016, 'Tina',     9,  'Dogo Argentino',    40, '221-5000016'),
(1017, 'Kira',     4,  'Husky Siberiano',   24, '221-5000017'),
(1018, 'Cala',     6,  'Shar Pei',          23, '221-5000018'),
(1019, 'Batu',     3,  'Salchicha',          8, '221-5000019'),
(1020, 'Lucho',    2,  'Gatx (mestizo)',     4, '221-5000020'),
(1021, 'Teo',      5,  'Bulldog Inglés',    24, '221-5000021'),
(1022, 'Nina',     4,  'Galgo',             27, '221-5000022'),
(1023, 'Pipo',     1,  'Caniche',            5, '221-5000023'),
(1024, 'Nico',     3,  'Labrador',          30, '221-5000024');

-- VETERINARIOS (incluye 'Oscar Lopez', 'MP 1000', 'MN 4545', 'MP 10000')
INSERT INTO Veterinario (matricula, CUIT, nombYAp, direccion, telefono) VALUES
('MP 1000',  '20-20000000-1', 'María Pérez',     'Calle 10 123, La Plata',   '221-4100000'),
('MN 4545',  '23-23000000-9', 'Juan García',     'Calle 11 456, La Plata',   '221-4100001'),
('MP 10000', '27-27000000-3', 'Ana López',       'Calle 12 789, La Plata',   '221-4100002'), -- será modificado a Pablo Lopez (punto 4)
('MP 2001',  '20-21000000-6', 'Oscar Lopez',     'Diag. 80 100, La Plata',   '221-4100003'),
('MN 3003',  '22-22000000-5', 'Sofía Benítez',   'Av. 7 555, La Plata',      '221-4100004'),
('MP 4004',  '24-24000000-4', 'Tomás Herrera',   'Calle 6 345, La Plata',    '221-4100005'),
('MN 5050',  '26-26000000-2', 'Lucía Martínez',  'Calle 1 999, La Plata',    '221-4100006'),
('MP 6060',  '30-30000000-7', 'Diego Acosta',    'Av. 13 1300, Ensenada',    '221-4100007'),
('MN 7070',  '33-33000000-1', 'Carla Sosa',      'Av. 44 200, Berisso',      '221-4100008'),
('MP 8080',  '34-34000000-8', 'Gonzalo Álvarez', 'Calle 60 200, La Plata',   '221-4100009'),
('MN 9090',  '35-35000000-0', 'Valentina Paz',   'Calle 64 321, La Plata',   '221-4100010'),
('MP 1111',  '36-36000000-6', 'Pedro Cano',      'Calle 2 200, La Plata',    '221-4100011');

-- SUPERVISIONES
-- Reglas para consultas:
-- * Enero 2024 con fechaSale: varias supervisiones cerradas para contar por veterinario (punto 1).
-- * Veterinarios sin supervisión actual (ninguna con fechaSale IS NULL) (punto 2): ej. 'MN 5050', 'MP 8080'.
-- * Mascotas atendidas por 'Oscar Lopez' (punto 3).
-- * Intersección por matrículas 'MP 1000' y 'MN 4545' (punto 5) sobre algunas mascotas.
-- * Entradas 2024 (punto 6).
INSERT INTO Supervision (codMascota, nroBox, fechaEntra, fechaSale, matricula, descripcionEstadia) VALUES
-- 2023 (cerradas)
(1001, 1, '2023-12-20', '2023-12-28', 'MP 1000',  'Observación posoperatoria'),
(1002, 2, '2023-12-22', '2023-12-30', 'MN 4545',  'Tratamiento dermatológico'),
(1003, 3, '2023-12-25', '2024-01-05', 'MP 2001',  'Dolor lumbar'),

-- Enero 2024 (cerradas) para conteo del punto 1
(1004, 3, '2024-01-02', '2024-01-06', 'MP 1000',  'Gastroenteritis'),
(1005, 4, '2024-01-03', '2024-01-07', 'MN 4545',  'Chequeo general'),
(1006, 5, '2024-01-04', '2024-01-09', 'MP 2001',  'Neumonía'),
(1007, 6, '2024-01-05', '2024-01-10', 'MN 3003',  'Post vacuna'),
(1008, 7, '2024-01-06', '2024-01-12', 'MN 3003',  'Dieta de control'),
(1009, 8, '2024-01-07', '2024-01-15', 'MN 3003',  'Cirugía menor'),
(1010, 9, '2024-01-07', '2024-01-20', 'MP 4004',  'Fiebre y vómitos'),
(1011,10, '2024-01-08', '2024-01-18', 'MP 4004',  'Observación'),
(1012,11, '2024-01-10', '2024-01-25', 'MP 4004',  'Cirugía limpieza dental'),

-- 2024 (varias, algunas abiertas)
(1001, 3, '2024-02-10', '2024-02-14', 'MN 3003',  'Control posoperatorio'),
(1002, 5, '2024-02-12', NULL,         'MN 4545',  'Aislamiento por dermatitis'), -- abierta (ocupa box 5)
(1003, 8, '2024-03-01', NULL,         'MP 2001',  'Rehabilitación de columna'),  -- abierta (ocupa box 8)
(1004, 8, '2024-03-05', NULL,         'MP 2001',  'Reposo post cirugía'),        -- abierta (ocupa box 8)
(1005,16, '2024-03-08', NULL,         'MN 7070',  'Observación por tos'),        -- abierta (ocupa box 16)
(1006,12, '2024-03-09', '2024-03-15', 'MN 7070',  'Alta control'),
(1007,13, '2024-04-01', '2024-04-05', 'MN 9090',  'Control rutinario'),
(1008,14, '2024-04-03', '2024-04-06', 'MN 9090',  'Vacunación'),
(1009,15, '2024-04-05', '2024-04-12', 'MP 6060',  'Cirugía ocular'),
(1010,17, '2024-04-08', '2024-04-11', 'MP 6060',  'Dolor abdominal'),
(1011,18, '2024-05-01', '2024-05-10', 'MP 1111',  'Ingesta de cuerpo extraño'),
(1012,19, '2024-05-12', '2024-05-18', 'MP 1111',  'Corte superficial'),
(1013,20, '2024-06-20', NULL,         'MN 3003',  'Tratamiento prolongado'),     -- abierta
(1014, 1, '2024-07-01', '2024-07-05', 'MP 4004',  'Control pos vacuna'),
(1015, 2, '2024-08-10', '2024-08-15', 'MN 3003',  'Chequeo geriátrico'),
(1016, 3, '2024-09-01', NULL,         'MN 3003',  'Atención por golpe'),         -- abierta
(1017, 4, '2024-10-05', NULL,         'MN 3003',  'Control conducta'),           -- abierta

-- 2025 (para estados actuales y veterinarios sin actuales)
(1018, 5, '2025-01-10', '2025-01-12', 'MN 9090',  'Control leve'),
(1019, 6, '2025-02-01', '2025-02-07', 'MP 6060',  'Consulta general'),
(1020, 7, '2025-03-15', '2025-03-18', 'MP 1111',  'Vacunación'),
(1021, 8, '2025-04-01', '2025-04-05', 'MN 3003',  'Seguimiento rápido'),
(1022, 9, '2025-05-10', '2025-05-12', 'MN 4545',  'Corte leve'),
(1023,10, '2025-06-01', '2025-06-04', 'MP 4004',  'Chequeo'),
(1024,11, '2025-07-20', NULL,         'MP 6060',  'Aislamiento breve');          -- abierta

-- Ajuste de ocupación de boxes para que coincida con supervisiones abiertas
-- (Box 3, 5, 8, 16, 20, 3 ya estaban configurados arriba)
UPDATE Box SET ocupacion = 1 WHERE nroBox IN (3,5,16,20);
UPDATE Box SET ocupacion = 2 WHERE nroBox = 8;
