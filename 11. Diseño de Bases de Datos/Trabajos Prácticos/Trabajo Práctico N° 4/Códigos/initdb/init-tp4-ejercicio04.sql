-- =========================================================
-- CREACIÓN E INICIALIZACIÓN DE LA BASE DE DATOS - Ejercicio 4
-- =========================================================

DROP DATABASE IF EXISTS tp4_ejercicio4;
CREATE DATABASE tp4_ejercicio4;
USE tp4_ejercicio4;
SET NAMES utf8mb4;

-- ===============================================
-- TABLAS
-- ===============================================

CREATE TABLE Persona (
  DNI INT PRIMARY KEY,
  Apellido VARCHAR(100) NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  Fecha_Nacimiento DATE NOT NULL,
  Estado_Civil VARCHAR(50) NOT NULL,
  Genero CHAR(1) NOT NULL
);

CREATE TABLE Alumno (
  DNI INT PRIMARY KEY,
  Legajo VARCHAR(20) NOT NULL,
  Anio_Ingreso INT NOT NULL,
  FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE Profesor (
  DNI INT PRIMARY KEY,
  Matricula VARCHAR(20) NOT NULL,
  Nro_Expediente INT NOT NULL,
  FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE Titulo (
  Cod_Titulo INT PRIMARY KEY,
  Nombre VARCHAR(100) NOT NULL,
  Descripcion VARCHAR(200) NOT NULL
);

CREATE TABLE Titulo_Profesor (
  Cod_Titulo INT NOT NULL,
  DNI INT NOT NULL,
  Fecha DATE NOT NULL,
  PRIMARY KEY (Cod_Titulo, DNI),
  FOREIGN KEY (Cod_Titulo) REFERENCES Titulo(Cod_Titulo),
  FOREIGN KEY (DNI) REFERENCES Profesor(DNI)
);

CREATE TABLE Curso (
  Cod_Curso INT PRIMARY KEY,
  Nombre VARCHAR(100) NOT NULL,
  Descripcion VARCHAR(200) NOT NULL,
  Fecha_Creacion DATE NOT NULL,
  Duracion INT NOT NULL
);

CREATE TABLE Alumno_Curso (
  DNI INT NOT NULL,
  Cod_Curso INT NOT NULL,
  Anio INT NOT NULL,
  Desempenio VARCHAR(50) NOT NULL,
  Calificacion DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (DNI, Cod_Curso, Anio),
  FOREIGN KEY (DNI) REFERENCES Alumno(DNI),
  FOREIGN KEY (Cod_Curso) REFERENCES Curso(Cod_Curso)
);

CREATE TABLE Profesor_Curso (
  DNI INT NOT NULL,
  Cod_Curso INT NOT NULL,
  Fecha_Desde DATE NOT NULL,
  Fecha_Hasta DATE NULL,
  PRIMARY KEY (DNI, Cod_Curso, Fecha_Desde),
  FOREIGN KEY (DNI) REFERENCES Profesor(DNI),
  FOREIGN KEY (Cod_Curso) REFERENCES Curso(Cod_Curso)
);

-- ===============================================
-- DATOS INICIALES
-- ===============================================

-- PERSONAS (Alumnos + Profesores)
INSERT INTO Persona VALUES
(30111222, 'Perez', 'Lucas', '1991-03-10', 'Soltero', 'M'),
(30222333, 'Gomez', 'Ana', '1995-05-12', 'Casada', 'F'),
(30333444, 'Rodriguez', 'Martina', '1999-08-21', 'Soltera', 'F'),
(30444555, 'Lopez', 'Diego', '1992-09-01', 'Casado', 'M'),
(30555666, 'Fernandez', 'Lucia', '1988-12-19', 'Divorciada', 'F'),
(30568989, 'Ramos', 'Carla', '1994-10-04', 'Soltera', 'F'),
(30666777, 'Garcia', 'Juan', '1980-11-14', 'Casado', 'M'),   -- profesor
(30777888, 'Suarez', 'Maria', '1985-04-03', 'Casada', 'F'),  -- profesora
(30888999, 'Mendez', 'Luis', '1978-01-15', 'Casado', 'M'),   -- profesor
(30999000, 'Vega', 'Sofia', '1998-03-22', 'Soltera', 'F'),
(31000111, 'Torres', 'Pedro', '1993-07-10', 'Soltero', 'M'),
(31111222, 'Ramirez', 'Julieta', '1997-11-30', 'Soltera', 'F'),
(31222333, 'Aguirre', 'Tomas', '1996-09-12', 'Casado', 'M'),
(31333444, 'Morales', 'Valentina', '1995-04-05', 'Soltera', 'F'),
(31444555, 'Pereyra', 'Facundo', '1999-05-28', 'Soltero', 'M');

-- ALUMNOS
INSERT INTO Alumno VALUES
(30111222, '2012/01', 2012),
(30222333, '2015/02', 2015),
(30333444, '2020/03', 2020),
(30444555, '2018/04', 2018),
(30555666, '2013/05', 2013),
(30568989, '2020/09', 2020),
(30999000, '2021/07', 2021),
(31000111, '2019/08', 2019),
(31111222, '2022/06', 2022),
(31222333, '2021/10', 2021),
(31333444, '2023/11', 2023),
(31444555, '2024/12', 2024);

-- PROFESORES
INSERT INTO Profesor VALUES
(30666777, 'MAT-100', 5001),
(30777888, 'MAT-200', 5002),
(30888999, 'MAT-300', 5003);

-- TITULOS
INSERT INTO Titulo VALUES
(20, 'Lic. en Sistemas', 'Título universitario en sistemas de información'),
(21, 'Analista Programador', 'Título técnico en programación'),
(22, 'Ingeniero en Computación', 'Título de ingeniería informática'),
(23, 'Doctor en Ciencias de la Computación', 'Posgrado académico avanzado'),
(24, 'Lic. en Educación', 'Título en docencia universitaria'),
(25, 'Especialista en Bases de Datos', 'Posgrado en bases de datos');

-- TITULOS DE PROFESORES
INSERT INTO Titulo_Profesor VALUES
(20, 30666777, '2005-06-01'),
(25, 30666777, '2010-09-15'),
(21, 30777888, '2008-07-10'),
(22, 30777888, '2013-04-22'),
(23, 30777888, '2019-08-05'),
(20, 30888999, '2003-05-17'),
(21, 30888999, '2006-11-10'),
(22, 30888999, '2011-12-20'),
(25, 30888999, '2020-06-30');

-- CURSOS
INSERT INTO Curso VALUES
(100, 'Diseño de Bases de Datos', 'Modelado y normalización de bases de datos', '2018-01-01', 120),
(101, 'Programación Avanzada', 'Paradigmas y estructuras avanzadas', '2017-05-01', 90),
(102, 'Gestión de Proyectos', 'Herramientas de planificación y control', '2016-08-10', 80),
(103, 'Administración de Bases de Datos', 'Optimización y seguridad en SGBD', '2019-09-15', 150),
(104, 'Fundamentos de BD', 'Introducción a los modelos de datos', '2020-03-20', 70);

-- PROFESOR - CURSO
INSERT INTO Profesor_Curso VALUES
(30666777, 100, '2020-01-01', NULL),
(30777888, 101, '2020-01-01', NULL),
(30888999, 102, '2020-01-01', NULL),
(30666777, 103, '2020-01-01', NULL),
(30888999, 104, '2021-01-01', NULL);

-- ALUMNO - CURSO (Incluye inscripciones 2022, 2023 y 2024)
INSERT INTO Alumno_Curso VALUES
(30111222, 100, 2023, 'Aprobado', 9.00),
(30222333, 100, 2023, 'Aprobado', 8.50),
(30333444, 101, 2022, 'Regular', 7.00),
(30444555, 103, 2023, 'Aprobado', 9.50),
(30555666, 102, 2022, 'Insuficiente', 4.00),
(30568989, 104, 2023, 'Regular', 6.00),
(30999000, 100, 2023, 'Aprobado', 8.00),
(31000111, 101, 2023, 'Regular', 6.50),
(31111222, 102, 2023, 'Insuficiente', 5.00),
(31222333, 104, 2023, 'Aprobado', 9.00),

-- Nuevas inscripciones para 2024
(30111222, 100, 2024, 'Aprobado', 9.50),
(30222333, 100, 2024, 'Regular', 7.00),
(30333444, 100, 2024, 'Aprobado', 8.50),
(30444555, 100, 2024, 'Regular', 6.00),
(30555666, 101, 2024, 'Aprobado', 8.00),
(30999000, 102, 2024, 'Insuficiente', 5.50),
(31000111, 103, 2024, 'Regular', 6.50),
(31111222, 103, 2024, 'Aprobado', 9.00),
(31222333, 103, 2024, 'Regular', 7.00),
(31333444, 104, 2024, 'Aprobado', 8.50),
(31444555, 104, 2024, 'Regular', 6.00);

-- ===============================================
-- FIN DEL SCRIPT
-- ===============================================
