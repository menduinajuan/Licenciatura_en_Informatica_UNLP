{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 7}
{Se cuenta con un archivo que almacena información sobre especies de aves en vía de extinción.
Para ello, se almacena: código, nombre de la especie, familia de ave, descripción y zona geográfica.
El archivo no está ordenado por ningún criterio. Realizar un programa que permita borrar especies de aves extintas.
Este programa debe disponer de dos procedimientos:
(a) Un procedimiento que, dada una especie de ave (su código), marque la misma como borrada (en caso de querer borrar múltiples especies de aves, se podría invocar este procedimiento repetidamente).
(b) Un procedimiento que compacte el archivo, quitando, definitivamente, las especies de aves marcadas como borradas.
Para quitar los registros, se deberá copiar el último registro del archivo en la posición del registro a borrar y, luego, eliminar del archivo el último registro de forma tal de evitar registros duplicados.
  (i) Implementar una variante de este procedimiento de compactación del archivo (baja física) donde el archivo se trunque una sola vez.}

program TP3_E7;
{$codepage UTF8}
uses crt;
const

type

var

begin

end.