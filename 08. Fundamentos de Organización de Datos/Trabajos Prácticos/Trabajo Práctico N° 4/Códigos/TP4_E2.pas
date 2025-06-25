{TRABAJO PRÁCTICO N° 4}
{EJERCICIO 2}
{Una mejora respecto a la solución propuesta en el Ejercicio 1 sería mantener, por un lado, el archivo que contiene la información de los alumnos de la Facultad de Informática (archivo de datos no ordenado) y, por otro lado, mantener un índice al archivo de datos que se estructura como un árbol B que ofrece acceso indizado por DNI de los alumnos.
(a) Definir, en Pascal, las estructuras de datos correspondientes para el archivo de alumnos y su índice.}

program TP4_E2;
const
  M=10;
type
  t_registro_alumno=record
    nombre: string;
    apellido: string;
    dni: int32;
    legajo: int16;
    anio_ingreso: int16;
  end;
  t_registro_nodo=record
    cantidad_claves: int16;
    claves: array[0..M-1] of int32;
    enlaces: array[0..M-1] of int16;
    hijos: array[0..M] of int16;
  end;
  t_archivo_datos=file of t_registro_alumno;
  t_archivo_indice=file of t_registro_nodo;
var
  archivo_datos: t_archivo_datos;
  archivo_indice: t_archivo_indice;
begin
  
end.