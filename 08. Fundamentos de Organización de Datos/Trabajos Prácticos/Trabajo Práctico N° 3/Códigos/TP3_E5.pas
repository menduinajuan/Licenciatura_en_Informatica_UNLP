{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 5}
{Dada la estructura planteada en el ejercicio anterior, implementar el siguiente módulo:
Abre el archivo y elimina la flor recibida como parámetro, manteniendo la política descripta anteriormente
procedure eliminarFlor(var a: tArchFlores; flor: reg_flor);}

program TP3_E5;
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
    registro_flor.codigo:=1+random(100);
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
procedure eliminar_flor(var archivo_flores: t_archivo_flores; flor: t_registro_flor);
var
  registro_flor, cabecera: t_registro_flor;
  ok: boolean;
begin
  ok:=false;
  reset(archivo_flores);
  read(archivo_flores,cabecera);
  while ((not eof(archivo_flores)) and (ok=false)) do
  begin
    read(archivo_flores,registro_flor);
    if (registro_flor.codigo=flor.codigo) then
    begin
      ok:=true;
      seek(archivo_flores,filepos(archivo_flores)-1);
      write(archivo_flores,cabecera);
      cabecera.codigo:=(filepos(archivo_flores)-1)*(-1);
      seek(archivo_flores,0);
      write(archivo_flores,cabecera);
    end;
  end;
  close(archivo_flores);
  if (ok=true) then
  begin
    textcolor(green); write('Se ha realizado la baja de la flor '); textcolor(yellow); write(flor.nombre); textcolor(green); write(' con código '); textcolor(yellow); write(flor.codigo); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('No se ha encontrado la flor '); textcolor(yellow); write(flor.nombre); textcolor(green); write(' con código '); textcolor(yellow); write(flor.codigo); textcolor(green); writeln(' en el archivo');
  end;
  writeln();
end;
var
  archivo_flores: t_archivo_flores;
  registro_flor: t_registro_flor;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO FLORES:'); writeln();
  assign(archivo_flores,'E5_flores');
  cargar_archivo_flores(archivo_flores);
  imprimir_archivo_flores(archivo_flores);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO FLORES AL AGREGAR FLOR ANTES DE LA BAJA:'); writeln();
  registro_flor.codigo:=1+random(100);
  registro_flor.nombre:=random_string(5+random(6));
  agregar_flor(archivo_flores,registro_flor.nombre,registro_flor.codigo);
  imprimir_archivo_flores(archivo_flores);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO FLORES AL ELIMINAR FLOR:'); writeln();
  registro_flor.codigo:=1+random(100);
  eliminar_flor(archivo_flores,registro_flor);
  imprimir_archivo_flores(archivo_flores);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO FLORES AL AGREGAR FLOR DESPUÉS DE LA BAJA:'); writeln();
  registro_flor.codigo:=1+random(100);
  registro_flor.nombre:=random_string(5+random(6));
  agregar_flor(archivo_flores,registro_flor.nombre,registro_flor.codigo);
  imprimir_archivo_flores(archivo_flores);
end.