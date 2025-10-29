-- =========================================================
-- CREACIÓN E INICIALIZACIÓN DE LA BASE DE DATOS - Ejercicio 5
-- =========================================================

DROP DATABASE IF EXISTS tp4_ejercicio5;
CREATE DATABASE tp4_ejercicio5;
USE tp4_ejercicio5;
SET NAMES utf8mb4;


-- ===============================================
-- TABLAS
-- ===============================================

-- Tabla Agencia
CREATE TABLE Agencia (
    razon_social      VARCHAR(100) PRIMARY KEY,
    direccion         VARCHAR(150) NOT NULL,
    telef             VARCHAR(20) NOT NULL,
    email             VARCHAR(100) NOT NULL
);


-- Tabla Ciudad
CREATE TABLE Ciudad (
    codigo_postal     INT PRIMARY KEY,
    nombreCiudad      VARCHAR(100) NOT NULL,
    anioCreacion      INT NOT NULL
);


-- Tabla Cliente
CREATE TABLE Cliente (
    dni               INT PRIMARY KEY,
    nombre            VARCHAR(50) NOT NULL,
    apellido          VARCHAR(50) NOT NULL,
    telefono          VARCHAR(20) NOT NULL,
    direccion         VARCHAR(150) NOT NULL
);


-- Tabla Viaje
CREATE TABLE Viaje (
    fecha             DATE NOT NULL,
    hora              TIME NOT NULL,
    dni               INT NOT NULL,
    cpOrigen          INT NOT NULL,
    cpDestino         INT NOT NULL,
    razon_social      VARCHAR(100) NOT NULL,
    descripcion       VARCHAR(200) NOT NULL,
    PRIMARY KEY (fecha, hora, dni),
    FOREIGN KEY (dni) REFERENCES Cliente(dni),
    FOREIGN KEY (cpOrigen) REFERENCES Ciudad(codigo_postal),
    FOREIGN KEY (cpDestino) REFERENCES Ciudad(codigo_postal),
    FOREIGN KEY (razon_social) REFERENCES Agencia(razon_social)
);



-- ===============================================
-- DATOS INICIALES
-- ===============================================

INSERT INTO Ciudad (codigo_postal, nombreCiudad, anioCreacion) VALUES
(1900, 'La Plata', 1882),
(1896, 'Villa Elisa', 1890),
(1980, 'Berisso', 1871),
(1981, 'Ensenada', 1801),
(1982, 'City Bell', 1915),
(1983, 'Tolosa', 1870),
(1984, 'Gonnet', 1914),
(1985, 'Coronel Brandsen', 1875),
(1986, 'Quilmes', 1666),
(1987, 'Berazategui', 1856);



INSERT INTO Agencia (razon_social, direccion, telef, email) VALUES
('TAXI A', 'Calle 12 N°450, La Plata', '221-4500001', 'contacto@taxia.com'),
('TAXI B', 'Av. 7 N°200, La Plata', '221-4500002', 'info@taxib.com'),
('TAXI C', 'Calle 44 N°120, Ensenada', '221-4500003', 'reservas@taxic.com'),
('TAXI D', 'Calle 8 N°155, Berisso', '221-4500004', 'contacto@taxid.com'),
('TAXI E', 'Calle 60 N°900, City Bell', '221-4500005', 'taxie@jmail.com'),
('TAXI F', 'Av. 122 N°333, Tolosa', '221-4500006', 'contacto@taxif.com'),
('TAXI Y', 'Av. 1 N°100, La Plata', '221-4500007', 'taxiy@jmail.com'),
('TAXI Z', 'Av. 13 N°250, La Plata', '221-4500008', 'taxiz@correo.com');


INSERT INTO Cliente (dni, nombre, apellido, telefono, direccion) VALUES
(38495444, 'Juan', 'Pérez', '221-4400111', 'Calle 10 N°550'),
(40325692, 'María', 'Roma', '221-4400222', 'Calle 20 N°650'),
(39587412, 'Lucía', 'Romero', '221-4400333', 'Calle 30 N°750'),
(38745987, 'Carlos', 'Gómez', '221-4400444', 'Av. 13 N°1000'),
(39856234, 'Laura', 'Fernández', '221-4400555', 'Calle 5 N°200'),
(38451236, 'Marta', 'López', '221-4400666', 'Calle 60 N°800'),
(37987541, 'Pablo', 'Domínguez', '221-4400777', 'Calle 115 N°120'),
(37548752, 'Julieta', 'Martínez', '221-4400888', 'Av. 44 N°350'),
(38221478, 'Ricardo', 'Roma', '221-4400999', 'Av. 7 N°140'),
(38997741, 'Sofía', 'Alonso', '221-4400100', 'Calle 1 N°50');


INSERT INTO Viaje (fecha, hora, dni, cpOrigen, cpDestino, razon_social, descripcion) VALUES
('2019-01-05', '08:00', 40325692, 1900, 1986, 'TAXI A', 'Viaje demorado por lluvia'),
('2019-01-10', '09:30', 40325692, 1900, 1985, 'TAXI B', 'Viaje sin demoras'),
('2019-01-15', '11:15', 38495444, 1900, 1984, 'TAXI Y', 'Viaje demorado por tránsito'),
('2019-02-20', '14:00', 38495444, 1900, 1985, 'TAXI Y', 'Viaje normal'),
('2019-03-01', '10:30', 39587412, 1980, 1986, 'TAXI C', 'Traslado rápido'),
('2019-04-22', '18:00', 38745987, 1981, 1982, 'TAXI D', 'Viaje demorado por corte'),
('2019-05-03', '19:45', 39856234, 1983, 1985, 'TAXI E', 'Demorado por obras'),
('2019-06-10', '20:15', 38451236, 1982, 1980, 'TAXI F', 'Viaje sin novedad'),
('2019-07-25', '22:00', 37987541, 1900, 1985, 'TAXI Y', 'Demorado por lluvia'),
('2019-08-30', '07:30', 37548752, 1984, 1987, 'TAXI Z', 'Viaje normal'),
('2019-09-12', '08:00', 38221478, 1900, 1985, 'TAXI Y', 'Traslado de rutina'),
('2019-10-01', '09:00', 38997741, 1986, 1980, 'TAXI B', 'Viaje sin demoras'),
('2019-11-05', '10:00', 40325692, 1900, 1985, 'TAXI Y', 'Viaje corto'),
('2020-01-10', '12:30', 38495444, 1984, 1985, 'TAXI A', 'Viaje demorado por congestión'),
('2020-02-15', '13:45', 38495444, 1980, 1982, 'TAXI Y', 'Traslado interurbano'),
('2021-03-20', '15:00', 39587412, 1986, 1983, 'TAXI F', 'Viaje habitual'),
('2022-04-18', '16:30', 38997741, 1985, 1980, 'TAXI E', 'Demorado por control policial'),
('2023-05-12', '18:00', 38745987, 1983, 1985, 'TAXI Z', 'Viaje normal'),
('2023-06-22', '19:45', 39856234, 1982, 1985, 'TAXI B', 'Viaje demorado por tráfico'),
('2024-07-10', '21:00', 40325692, 1900, 1985, 'TAXI A', 'Viaje nocturno sin demoras'),
('2024-09-10', '10:00:00', 40325692, 1900, 1985, 'TAXI C', 'Descripcion sobre el viaje'),
('2024-09-20', '13:00:00', 40325692, 1900, 1985, 'TAXI D', 'Descripcion sobre el viaje'),
('2024-11-20', '20:00:00', 40325692, 1900, 1985, 'TAXI E', 'Descripcion sobre el viaje'),
('2024-12-10', '20:00:00', 40325692, 1900, 1985, 'TAXI F', 'Descripcion sobre el viaje'),
('2024-12-23', '11:00:00', 40325692, 1900, 1985, 'TAXI Z', 'Descripcion sobre el viaje');


