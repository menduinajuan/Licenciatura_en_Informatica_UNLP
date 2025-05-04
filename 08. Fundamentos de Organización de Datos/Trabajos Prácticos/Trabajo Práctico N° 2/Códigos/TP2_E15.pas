{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 15}
{Se desea modelar la información de una ONG dedicada a la asistencia de personas con carencias habitacionales.
La ONG cuenta con un archivo maestro conteniendo información como se indica a continuación: código provincia, nombre provincia, código de localidad, nombre de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin agua, #viviendas sin sanitarios.
Mensualmente, reciben detalles de las diferentes provincias indicando avances en las obras de ayuda en la edificación y equipamientos de viviendas en cada provincia.
La información de los detalles es la siguiente: código provincia, código localidad, #viviendas con luz, #viviendas construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, se reciben 10 detalles.
Todos los archivos están ordenados por código de provincia y código de localidad.
Para la actualización del archivo maestro, se debe proceder de la siguiente manera:
•	Al valor de viviendas sin luz se le resta el valor recibido en el detalle.
•	Ídem para viviendas sin agua, sin gas y sin sanitarios.
•	A las viviendas de chapa se le resta el valor recibido de viviendas construidas.
La misma combinación de provincia y localidad aparecen, a lo sumo, una única vez.
Realizar las declaraciones necesarias, el programa principal y los procedimientos que se requiera para la actualización solicitada e informar cantidad de localidades sin viviendas de chapa (las localidades pueden o no haber sido actualizadas).}

program TP2_E15;
{$codepage UTF8}
uses crt;
const
  
type

var

begin
  
end.