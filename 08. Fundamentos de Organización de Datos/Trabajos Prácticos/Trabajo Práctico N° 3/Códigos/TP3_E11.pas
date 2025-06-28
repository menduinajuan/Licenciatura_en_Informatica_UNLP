{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 11}
{Suponer que se trabaja en una oficina donde está montada una LAN (red local). La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central.
Semanalmente, cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta.
Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion.
Se debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.
Notas:
•	Los archivos detalle no están ordenados por ningún criterio.
•	Un usuario puede iniciar más de una sesión el mismo día en la misma máquina o, inclusive, en diferentes máquinas.}

program TP3_E11;
{$codepage UTF8}
uses crt;
const

type

var

begin

end.