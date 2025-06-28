{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 8}
{Se cuenta con un archivo con información de las diferentes distribuciones de Linux existentes.
De cada distribución, se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad de desarrolladores y descripción.
El nombre de las distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida.
Escribir la definición de las estructuras de datos necesarias y los siguientes procedimientos:
(a) BuscarDistribucion: Módulo que recibe por parámetro el archivo, un nombre de distribución y devuelve la posición dentro del archivo donde se encuentra el registro correspondiente a la distribución dada, si existe, o devuelve -1, en caso de que no exista.
(b) AltaDistribucion: Módulo que recibe como parámetro el archivo y el registro que contiene los datos de una nueva distribución, y se encarga de agregar la distribución al archivo reutilizando espacio disponible en caso de que exista.
(El control de unicidad se debe realizar utilizando el módulo anterior). En caso de que la distribución que se quiere agregar ya exista, se debe informar “Ya existe la distribución”.
(c) BajaDistribucion: Módulo que recibe como parámetro el archivo y el nombre de una distribución, y se encarga de dar de baja lógicamente la distribución dada.
Para marcar una distribución como borrada, se debe utilizar el campo cantidad de desarrolladores para mantener actualizada la lista invertida.
Para verificar que la distribución a borrar exista, se debe utilizar el módulo BuscarDistribucion. En caso de no existir, se debe informar “Distribución no existente”.}

program TP3_E8;
{$codepage UTF8}
uses crt;
const

type

var

begin

end.