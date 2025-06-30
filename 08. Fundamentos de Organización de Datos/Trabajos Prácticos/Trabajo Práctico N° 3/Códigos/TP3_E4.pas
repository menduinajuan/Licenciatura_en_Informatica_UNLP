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
(a) Implementar el siguiente módulo:
Abre el archivo y agrega una flor recibida como parámetro, manteniendo la política descrita anteriormente
procedure agregarFlor(var a: tArchFlores; nombre: string; codigo: integer);
(b) Listar el contenido del archivo omitiendo las flores eliminadas. Modificar lo que se considere necesario para obtener el listado.}

program TP3_E4;
{$codepage UTF8}
uses crt;
const
  codigo_salida=-1;
  codigo_cabecera=0;
type
  t_string45=string[45];
  t_registro_flor=record
    nombre: t_string45;
    codigo: int16;
  end;
  t_archivo_flores=file of t_registro_flor;
function random_string(length: int8): t_string45;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_flor(var registro_flor: t_registro_flor);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_flor.codigo:=codigo_salida
  else
    registro_flor.codigo:=1+random(1000);
  if (registro_flor.codigo<>codigo_salida) then
    registro_flor.nombre:=random_string(5+random(6));
end;
procedure cargar_archivo_flores(var archivo_flores: t_archivo_flores);
var
  registro_flor: t_registro_flor;
begin
  rewrite(archivo_flores);
  registro_flor.codigo:=codigo_cabecera;
  registro_flor.nombre:='Cabecera';
  while (registro_flor.codigo<>codigo_salida) do
  begin
    write(archivo_flores,registro_flor);
    leer_flor(registro_flor);
  end;
  close(archivo_flores);
end;
procedure imprimir_registro_flor(registro_flor: t_registro_flor);
begin
  textcolor(green); write('Nombre: '); textcolor(yellow); write(registro_flor.nombre);
  textcolor(green); write('; Código: '); textcolor(yellow); writeln(registro_flor.codigo);
end;
procedure imprimir_archivo_flores(var archivo_flores: t_archivo_flores);
var
  registro_flor: t_registro_flor;
begin
  reset(archivo_flores);
  while (not eof(archivo_flores)) do
  begin
    read(archivo_flores,registro_flor);
    if (registro_flor.codigo>codigo_cabecera) then
      imprimir_registro_flor(registro_flor);
  end;
  textcolor(green); write('Tamaño del archivo flores: '); textcolor(yellow); writeln(filesize(archivo_flores));
  close(archivo_flores);
end;
procedure agregar_flor(var archivo_flores: t_archivo_flores; nombre: t_string45; codigo: int16);
var
  registro_flor, cabecera: t_registro_flor;
begin
  reset(archivo_flores);
  read(archivo_flores,cabecera);
  registro_flor.nombre:=nombre;
  registro_flor.codigo:=codigo;
  if (cabecera.codigo=codigo_cabecera) then
  begin
    seek(archivo_flores,filesize(archivo_flores));
    write(archivo_flores,registro_flor);
  end
  else
  begin
    seek(archivo_flores,cabecera.codigo*(-1));
    read(archivo_flores,cabecera);
    seek(archivo_flores,filepos(archivo_flores)-1);
    write(archivo_flores,registro_flor);
    seek(archivo_flores,0);
    write(archivo_flores,cabecera);
  end;
  close(archivo_flores);
  textcolor(green); write('Se ha realizado el alta de la flor '); textcolor(yellow); write(nombre); textcolor(green); write(' con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  writeln();
end;
var
  archivo_flores: t_archivo_flores;
  codigo: int16;
  nombre: t_string45;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO FLORES:'); writeln();
  assign(archivo_flores,'E4_flores');
  cargar_archivo_flores(archivo_flores);
  imprimir_archivo_flores(archivo_flores);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO FLORES AL AGREGAR FLOR:'); writeln();
  codigo:=1+random(1000);
  nombre:=random_string(5+random(6));
  agregar_flor(archivo_flores,nombre,codigo);
  imprimir_archivo_flores(archivo_flores);
end.