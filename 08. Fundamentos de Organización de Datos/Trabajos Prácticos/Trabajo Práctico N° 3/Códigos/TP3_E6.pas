{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 6}
{Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con la información correspondiente a las prendas que se encuentran a la venta.
De cada prenda, se registra: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario.
Ante un eventual cambio de temporada, se deben actualizar las prendas a la venta. Para ello, reciben un archivo conteniendo: cod_prenda de las prendas que quedarán obsoletas.
Se deberá implementar un procedimiento que reciba ambos archivos y realice la baja lógica de las prendas.
Para ello, se deberá modificar el stock de la prenda correspondiente a valor negativo.
Adicionalmente, se deberá implementar otro procedimiento que se encargue de efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la información de las prendas a la venta.
Para ello, se deberá utilizar una estructura auxiliar (esto es, un archivo nuevo), en el cual se copien, únicamente, aquellas prendas que no están marcadas como borradas.
Al finalizar este proceso de compactación del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro original.}

program TP3_E6;
{$codepage UTF8}
uses crt;
const

type

var

begin

end.