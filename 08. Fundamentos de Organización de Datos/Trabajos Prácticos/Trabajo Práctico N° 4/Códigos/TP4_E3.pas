{TRABAJO PRÁCTICO N° 4}
{EJERCICIO 3}
{Los árboles B+ representan una mejora sobre los árboles B dado que conservan la propiedad de acceso indexado a los registros del archivo de datos por alguna clave, pero permiten, además, un recorrido secuencial rápido.
Al igual que en el Ejercicio 2, considerar que, por un lado, se tiene el archivo que contiene la información de los alumnos de la Facultad de Informática (archivo de datos no ordenado) y, por otro lado, se tiene un índice al archivo de datos, pero, en este caso, el índice se estructura como un árbol B+ que ofrece acceso indizado por DNI al archivo de alumnos.
Resolver los siguientes incisos:
(c) Definir, en Pascal, las estructuras de datos correspondientes para el archivo de alumnos y su índice (árbol B+).
Por simplicidad, suponer que todos los nodos del árbol B+ (nodos internos y nodos hojas) tienen el mismo tamaño.}

program TP4_E3;
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
  t_lista=^t_registro_nodo;
  t_registro_nodo=record
    cantidad_claves: int16;
    claves: array[0..M-1] of int32;
    enlaces: array[0..M-1] of int16;
    hijos: array[0..M] of int16;
    sig: t_lista;
  end;
  t_archivo_datos=file of t_registro_alumno;
  t_archivo_indice=file of t_registro_nodo;
var
  archivo_datos: t_archivo_datos;
  archivo_indice: t_archivo_indice;
begin
  
end.