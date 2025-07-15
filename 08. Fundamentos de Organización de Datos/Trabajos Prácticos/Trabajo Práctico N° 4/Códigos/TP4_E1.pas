{TRABAJO PRÁCTICO N° 4}
{EJERCICIO 1}
{Considerar que se desea almacenar, en un archivo, la información correspondiente a los alumnos de la Facultad de Informática de la UNLP.
De los mismos, se deberá guardar nombre y apellido, DNI, legajo y año de ingreso.
Suponer que dicho archivo se organiza como un árbol B de orden M.
(a) Definir, en Pascal, las estructuras de datos necesarias para organizar el archivo de alumnos como un árbol B de orden M.}

program TP4_E1;
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
    claves: array[0..M-1] of t_registro_alumno;
    hijos: array[0..M] of int16;
  end;
  t_archivo_datos=file of t_registro_nodo;
var
  archivo_datos: t_archivo_datos;
begin
  
end.