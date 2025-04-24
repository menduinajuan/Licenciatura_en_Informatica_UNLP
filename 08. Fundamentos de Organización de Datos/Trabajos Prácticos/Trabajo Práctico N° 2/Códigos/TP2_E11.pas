{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 11}
{Se tiene información en un archivo de las horas extras realizadas por los empleados de una empresa en un mes.
Para cada empleado, se tiene la siguiente información: departamento, división, número de empleado, categoría y cantidad de horas extras realizadas por el empleado.
Se sabe que el archivo se encuentra ordenado por departamento, luego por división y, por último, por número de empleado.
Presentar en pantalla un listado con el siguiente formato:
Para obtener el valor de la hora, se debe cargar un arreglo desde un archivo de texto al iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía de 1 a 15.
En el archivo de texto, debe haber una línea para cada categoría con el número de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la posición del valor coincidente con el número de categoría.}

program TP2_E11;
{$codepage UTF8}
uses crt;
const
  categoría_ini=1; categoria_fin=15;
type
  t_categoria=categoría_ini..categoria_fin;
  t_registro_horas=record
    departamento: int16;
    division: int16;
    empleado: int16;
    categoria: t_categoria;
    horas: int16;
  end;
var

begin
  
end.