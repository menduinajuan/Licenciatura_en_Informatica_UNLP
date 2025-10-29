-- Crear bases de datos
DROP DATABASE IF EXISTS tp4_ejercicio1;
DROP DATABASE IF EXISTS tp4_ejercicio2;
DROP DATABASE IF EXISTS tp4_ejercicio3;
DROP DATABASE IF EXISTS tp4_ejercicio4;
DROP DATABASE IF EXISTS tp4_ejercicio5;
DROP DATABASE IF EXISTS tp4_ejercicio6;
DROP DATABASE IF EXISTS tp4_ejercicio7;
DROP DATABASE IF EXISTS tp4_ejercicio8;
DROP DATABASE IF EXISTS tp4_ejercicio9;
DROP DATABASE IF EXISTS tp4_ejercicio10;
DROP DATABASE IF EXISTS tp4_ejercicio11;
DROP DATABASE IF EXISTS tp4_ejercicio12;


CREATE DATABASE IF NOT EXISTS tp4_ejercicio1;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio2;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio3;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio4;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio5;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio6;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio7;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio8;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio9;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio10;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio11;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio12;
CREATE DATABASE IF NOT EXISTS tp4_ejercicio13;



-- Dar permisos al usuario 'alumno' sobre todas las bases
GRANT ALL PRIVILEGES ON tp4_ejercicio1.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio2.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio3.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio4.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio5.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio6.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio7.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio8.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio9.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio10.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio11.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio12.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio13.* TO 'alumno'@'%';
GRANT ALL PRIVILEGES ON tp4_ejercicio14.* TO 'alumno'@'%';


-- Aplicar cambios de permisos
FLUSH PRIVILEGES;
