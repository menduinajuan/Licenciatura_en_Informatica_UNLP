{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 4}
{Dada la siguiente estructura:
type
  reg_flor=record
    nombre: String[45];
    codigo: integer;
  end;
tArchFlores=file of reg_flor;
Las bajas se realizan apilando registros borrados y las altas reutilizando registros borrados.
El registro 0 se usa como cabecera de la pila de registros borrados: el número 0 en el campo código implica que no hay registros borrados y -N indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
(a) Implementar el siguiente módulo:}
{Abre el archivo y agrega una flor recibida como parámetro, manteniendo la política descrita anteriormente}
{procedure agregarFlor(var a: tArchFlores; nombre: string; codigo: integer);}
{(b) Listar el contenido del archivo omitiendo las flores eliminadas. Modificar lo que se considere necesario para obtener el listado.}

program TP3_E4;
{$codepage UTF8}
uses crt;
const

type

var

begin

end.