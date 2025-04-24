{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 13}
{Suponer que se es administrador de un servidor de correo electrónico.
En los logs del mismo (información guardada acerca de los movimientos que ocurren en el server) que se encuentran en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información: nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados.
Diariamente, el servidor de correo genera un archivo con la siguiente información: nro_usuario, cuentaDestino, cuerpoMensaje.
Este archivo representa todos los correos enviados por los usuarios en un día determinado.
Ambos archivos están ordenados por nro_usuario y se sabe que un usuario puede enviar cero, uno o más mails por día.
(a) Realizar el procedimiento necesario para actualizar la información del log en un día particular. Definir las estructuras de datos que utilice el procedimiento.
(b) Generar un archivo de texto que contenga el siguiente informe dado un archivo detalle de un día determinado:
Nota: Tener en cuenta que, en el listado, deberán aparecer todos los usuarios que existen en el sistema.
Considerar la implementación de esta opción de las siguientes maneras:
•	Como un procedimiento separado del inciso (a).
•	En el mismo procedimiento de actualización del inciso (a). ¿Qué cambios se requieren en el procedimiento del inciso (a) para realizar el informe en el mismo recorrido?}

program TP2_E13;
{$codepage UTF8}
uses crt;
const
  
type

var

begin
  
end.