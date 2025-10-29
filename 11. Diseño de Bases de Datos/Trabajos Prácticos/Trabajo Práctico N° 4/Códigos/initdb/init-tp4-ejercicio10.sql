-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tp4_ejercicio10;
USE tp4_ejercicio10;
SET NAMES utf8mb4;

-- =========================================================
-- TABLA VEHICULO
-- =========================================================
CREATE TABLE Vehiculo (
    patente VARCHAR(10) PRIMARY KEY,
    modelo VARCHAR(60),
    marca  VARCHAR(60),
    peso   INT,
    km     INT
);

-- =========================================================
-- TABLA CAMION
-- =========================================================
CREATE TABLE Camion (
    patente VARCHAR(10) PRIMARY KEY,
    largo INT,
    max_toneladas INT,
    cant_ruedas INT,
    tiene_acoplado BOOLEAN,
    FOREIGN KEY (patente) REFERENCES Vehiculo(patente)
);

-- =========================================================
-- TABLA AUTO
-- =========================================================
CREATE TABLE Auto (
    patente VARCHAR(10) PRIMARY KEY,
    es_electrico BOOLEAN,
    tipo_motor VARCHAR(60),
    FOREIGN KEY (patente) REFERENCES Vehiculo(patente)
);

-- =========================================================
-- TABLA SERVICE
-- Clave primaria compuesta (fecha, patente)
-- =========================================================
CREATE TABLE Service (
    fecha DATE,
    patente VARCHAR(10),
    km_service INT,
    descripcion VARCHAR(120),
    monto INT,
    PRIMARY KEY (fecha, patente),
    FOREIGN KEY (patente) REFERENCES Vehiculo(patente)
);

-- =========================================================
-- TABLA PARTE
-- (precio_parte con decimales)
-- =========================================================
CREATE TABLE Parte (
    cod_parte INT PRIMARY KEY,
    nombre VARCHAR(120),
    precio_parte DECIMAL(10,2)
);

-- =========================================================
-- TABLA SERVICE_PARTE
-- Clave compuesta: (fecha, patente, cod_parte)
-- precio (con decimales, puede diferir del de lista)
-- =========================================================
CREATE TABLE Service_Parte (
    fecha DATE,
    patente VARCHAR(10),
    cod_parte INT,
    precio DECIMAL(10,2),
    PRIMARY KEY (fecha, patente, cod_parte),
    FOREIGN KEY (fecha, patente) REFERENCES Service(fecha, patente),
    FOREIGN KEY (cod_parte) REFERENCES Parte(cod_parte)
);

-- =========================================================
-- DATOS DE EJEMPLO
-- =========================================================

-- VEHICULOS
INSERT INTO Vehiculo (patente, modelo, marca, peso, km) VALUES
('AAA123', 'FH 540',       'Volvo',     8200, 180000),
('BBB234', 'Actros 1845',  'Mercedes',  8500, 260000),
('CCC345', 'Stralis Hi-Way','Iveco',    8300, 120000),
('DDD456', 'R450',         'Scania',    8400, 310000),
('EEE567', 'TGS 18.440',   'MAN',       8600, 95000),
('FFF678', '420',          'Ford Cargo',7800, 150000),
('GGG789', 'Premium 450',  'Renault',   8000, 210000),
('HHH890', 'FM 460',       'Volvo',     8150,  98000),
('III901', 'Delivery 13',  'VW',        7000,  60000),
('JJJ012', 'Arocs 2042',   'Mercedes',  8700, 270000),
('KKK123', 'Onix',         'Chevrolet', 1200,  35000),
('LLL234', 'Corolla',      'Toyota',    1300,  78000),
('MMM345', 'Model 3',      'Tesla',     1600,  42000),
('NNN456', 'Leaf',         'Nissan',    1500,  50000),
('OOO567', '208',          'Peugeot',   1150,  62000),
('PPP678', 'Argo',         'Fiat',      1180,  54000),
('QQQ789', 'Civic',        'Honda',     1250,  88000),
('RRR890', 'Cruze',        'Chevrolet', 1270,  72000),
('SSS901', 'A3',           'Audi',      1320,  30000),
('TTT012', 'Clio',         'Renault',   1100,  91000),
('AWA564', 'Yaris',        'Toyota',    1180,  65000),
('UVX111', 'Sprinter',     'Mercedes',  3200, 180000),
('WXY222', 'Daily',        'Iveco',     3000, 130000),
('ZZA333', 'Ranger',       'Ford',      2200, 110000);

-- CAMIONES
INSERT INTO Camion (patente, largo, max_toneladas, cant_ruedas, tiene_acoplado) VALUES
('AAA123', 12, 30,  8, TRUE),
('BBB234', 13, 32,  10, TRUE),
('CCC345', 12, 28,  6, FALSE),
('DDD456', 14, 35,  10, TRUE),
('EEE567', 12, 27,  8, FALSE),
('FFF678', 11, 24,  6, FALSE),
('GGG789', 12, 26,  8, TRUE),
('HHH890', 12, 25,  8, FALSE),
('III901',  9, 12,  4, FALSE),
('JJJ012', 13, 33,  10, TRUE),
('UVX111',  8,  8,  4, FALSE),
('WXY222',  9, 10,  6, FALSE);

-- AUTOS
INSERT INTO Auto (patente, es_electrico, tipo_motor) VALUES
('KKK123', FALSE, '1.4 Nafta'),
('LLL234', FALSE, '1.8 Nafta'),
('MMM345', TRUE,  'Electrico'),
('NNN456', TRUE,  'Electrico'),
('OOO567', FALSE, '1.6 Nafta'),
('PPP678', FALSE, '1.3 Nafta'),
('QQQ789', FALSE, '2.0 Nafta'),
('RRR890', FALSE, '1.4 Turbo'),
('SSS901', FALSE, '1.4 Turbo'),
('TTT012', FALSE, '1.2 Nafta'),
('AWA564', FALSE, '1.5 Nafta'),
('ZZA333', FALSE, '2.2 Diesel');

-- PARTES (al menos una > $4000 y una común para todos los services 2025)
INSERT INTO Parte (cod_parte, nombre, precio_parte) VALUES
(1,  'Aceite 10W40',            3500.00),
(2,  'Filtro de combustible',   4500.00),
(3,  'Filtro de aceite',        2500.00),
(4,  'Pastillas freno premium', 6000.00),
(5,  'Bujías',                  1500.00),
(6,  'Neumático 205/55R16',    80000.00),
(7,  'Sticker Control 2025',     500.00),
(8,  'Refrigerante',            1200.00);

-- SERVICES
-- Incluir: muchos 2025 (con Sticker Control 2025 en todos), varios 2024 y 2023.
INSERT INTO Service (fecha, patente, km_service, descripcion, monto) VALUES
-- 2023
('2023-03-10', 'KKK123',  9000,  'cambio de aceite',     20000),
('2023-04-05', 'OOO567', 12000,  'cambio de aceite',     21000),
('2023-06-12', 'AAA123', 170000, 'inspección general',   80000),
('2023-07-20', 'CCC345', 110000, 'inspección general',   82000),
('2023-09-01', 'LLL234', 50000,  'alineación y balanceo',18000),
('2023-10-15', 'PPP678', 40000,  'cambio de aceite',     19000),
('2023-11-22', 'III901', 30000,  'revisión de frenos',   60000),
('2023-12-01', 'UVX111', 150000, 'inspección general',   70000),

-- 2024
('2024-01-10', 'NNN456', 30000,  'inspección general',   35000),
('2024-02-14', 'MMM345', 25000,  'cambio de aceite',     32000),
('2024-02-20', 'BBB234', 240000, 'inspección general',   90000),
('2024-03-03', 'EEE567',  90000, 'inspección general',   60000),
('2024-03-18', 'GGG789', 200000, 'revisión de frenos',   75000),
('2024-04-25', 'HHH890',  95000, 'cambio de aceite',     30000),
('2024-05-05', 'JJJ012', 260000, 'inspección general',   95000),
('2024-06-11', 'WXY222', 120000, 'inspección general',   62000),
('2024-08-09', 'LLL234', 70000,  'inspección general',   38000),
('2024-09-15', 'TTT012', 80000,  'cambio de aceite',     27000),
('2024-11-21', 'AWA564', 60000,  'inspección general',   36000),

-- 2025 (dentro del último año desde 2025-10-18) -> asegurar sticker común
('2025-01-15', 'AAA123', 180500, 'inspección general',   88000),
('2025-02-10', 'CCC345', 119500, 'revisión de frenos',   70000),
('2025-03-12', 'EEE567',  94000, 'cambio de aceite',     31000),
('2025-03-30', 'FFF678', 150500, 'inspección general',   64000),
('2025-04-18', 'GGG789', 210500, 'inspección general',   78000),
('2025-05-09', 'HHH890',  97500, 'inspección general',   62000),
('2025-05-22', 'III901',  45000, 'cambio de aceite',     35000),
('2025-06-17', 'UVX111', 175000, 'inspección general',   72000),
('2025-07-04', 'WXY222', 129000, 'revisión de frenos',   68000),
('2025-07-28', 'BBB234', 255000, 'inspección general',   99000),
('2025-08-16', 'JJJ012', 270500, 'inspección general',  101000),
('2025-09-10', 'OOO567',  63000, 'cambio de aceite',     32000),
('2025-09-25', 'KKK123',  13000, 'inspección general',   34000),
('2025-10-01', 'AWA564',  65000, 'cambio de aceite',     30000);

-- SERVICE_PARTES
-- Regla: todas las atenciones 2025 incluyen el Sticker Control 2025 (cod 7)
-- Además: asegurar que 'Pastillas freno premium' (cod 4, > $4000) aparezca en >30 services
-- y que 'Filtro de combustible' (cod 2) figure en alguna inspección general para el punto 2.

-- 2023
INSERT INTO Service_Parte (fecha, patente, cod_parte, precio) VALUES
('2023-03-10','KKK123',1,3500.00), ('2023-03-10','KKK123',3,2500.00),
('2023-04-05','OOO567',1,3500.00), ('2023-04-05','OOO567',3,2500.00),
('2023-06-12','AAA123',2,4500.00), ('2023-06-12','AAA123',4,6000.00),
('2023-07-20','CCC345',2,4500.00), ('2023-07-20','CCC345',4,6000.00),
('2023-09-01','LLL234',6,80000.00),
('2023-10-15','PPP678',1,3500.00), ('2023-10-15','PPP678',3,2500.00),
('2023-11-22','III901',4,6000.00), ('2023-11-22','III901',6,80000.00),
('2023-12-01','UVX111',2,4500.00), ('2023-12-01','UVX111',4,6000.00);

-- 2024
INSERT INTO Service_Parte (fecha, patente, cod_parte, precio) VALUES
('2024-01-10','NNN456',2,4500.00), ('2024-01-10','NNN456',4,6000.00),
('2024-02-14','MMM345',1,3500.00), ('2024-02-14','MMM345',3,2500.00),
('2024-02-20','BBB234',2,4500.00), ('2024-02-20','BBB234',4,6000.00),
('2024-03-03','EEE567',2,4500.00), ('2024-03-03','EEE567',4,6000.00),
('2024-03-18','GGG789',4,6000.00), ('2024-03-18','GGG789',6,80000.00),
('2024-04-25','HHH890',1,3500.00), ('2024-04-25','HHH890',3,2500.00),
('2024-05-05','JJJ012',2,4500.00), ('2024-05-05','JJJ012',4,6000.00),
('2024-06-11','WXY222',2,4500.00), ('2024-06-11','WXY222',4,6000.00),
('2024-08-09','LLL234',2,4500.00), ('2024-08-09','LLL234',4,6000.00),
('2024-09-15','TTT012',1,3500.00), ('2024-09-15','TTT012',3,2500.00),
('2024-11-21','AWA564',2,4500.00), ('2024-11-21','AWA564',4,6000.00);

-- 2025 (todas incluyen Sticker 2025) + sumar muchas con cod 4 para superar 30 apariciones
INSERT INTO Service_Parte (fecha, patente, cod_parte, precio) VALUES
('2025-01-15','AAA123',7,500.00), ('2025-01-15','AAA123',4,6000.00), ('2025-01-15','AAA123',2,4500.00),
('2025-02-10','CCC345',7,500.00), ('2025-02-10','CCC345',4,6000.00),
('2025-03-12','EEE567',7,500.00), ('2025-03-12','EEE567',1,3500.00), ('2025-03-12','EEE567',3,2500.00),
('2025-03-30','FFF678',7,500.00), ('2025-03-30','FFF678',4,6000.00),
('2025-04-18','GGG789',7,500.00), ('2025-04-18','GGG789',4,6000.00),
('2025-05-09','HHH890',7,500.00), ('2025-05-09','HHH890',4,6000.00),
('2025-05-22','III901',7,500.00), ('2025-05-22','III901',1,3500.00), ('2025-05-22','III901',3,2500.00),
('2025-06-17','UVX111',7,500.00), ('2025-06-17','UVX111',4,6000.00),
('2025-07-04','WXY222',7,500.00), ('2025-07-04','WXY222',4,6000.00),
('2025-07-28','BBB234',7,500.00), ('2025-07-28','BBB234',4,6000.00), ('2025-07-28','BBB234',2,4500.00),
('2025-08-16','JJJ012',7,500.00), ('2025-08-16','JJJ012',4,6000.00),
('2025-09-10','OOO567',7,500.00), ('2025-09-10','OOO567',1,3500.00), ('2025-09-10','OOO567',3,2500.00),
('2025-09-25','KKK123',7,500.00), ('2025-09-25','KKK123',2,4500.00), ('2025-09-25','KKK123',4,6000.00),
('2025-10-01','AWA564',7,500.00), ('2025-10-01','AWA564',1,3500.00), ('2025-10-01','AWA564',3,2500.00);

-- Relleno adicional con 'Pastillas freno premium' en más servicios (sumar >30 en total)
-- INSERT INTO Service_Parte (fecha, patente, cod_parte, precio) VALUES
-- ('2023-06-13','AAA123',4,6000.00),
-- ('2023-07-20','CCC345',4,6000.00),
-- ('2023-11-22','III901',4,6000.00),
-- ('2023-12-01','UVX111',4,6000.00),
-- ('2024-02-20','BBB234',4,6000.00),
-- ('2024-03-03','EEE567',4,6000.00),
-- ('2024-03-18','GGG789',4,6000.00),
-- ('2024-05-05','JJJ012',4,6000.00),
-- ('2024-06-11','WXY222',4,6000.00),
-- ('2024-08-09','LLL234',4,6000.00),
-- ('2024-11-21','AWA564',4,6000.00);

