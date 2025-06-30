{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 7}
{Realizar un programa que permita:
(a) Crear un archivo binario a partir de la información almacenada en un archivo de texto.
El nombre del archivo de texto es: “novelas.txt”.
La información en el archivo de texto consiste en: código de novela, nombre, género y precio de diferentes novelas argentinas.
Los datos de cada novela se almacenan en dos líneas en el archivo de texto.
La primera línea contendrá la siguiente información: código novela, precio y género; y la segunda línea almacenará el nombre de la novela.
(b) Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar una novela y modificar una existente.
Las búsquedas se realizan por código de novela.
Nota: El nombre del archivo binario es proporcionado por el usuario desde el teclado.}

program TP1_E7;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=0;
  opcion_salida=0;
type
  t_string20=string[20];
  t_registro_novela=record
    codigo: int16;
    nombre: t_string20;
    genero: t_string20;
    precio: real;
  end;
  t_archivo_novelas=file of t_registro_novela;
function random_string(length: int8): t_string20;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_novela(var registro_novela: t_registro_novela; ok: boolean);
var
  i: int8;
begin
  if (ok=true) then
  begin
    i:=random(100);
    if (i=0) then
      registro_novela.codigo:=codigo_salida
    else
      registro_novela.codigo:=1+random(1000);
  end;
  if (registro_novela.codigo<>codigo_salida) then
  begin
    registro_novela.nombre:=random_string(5+random(15));
    registro_novela.genero:=random_string(5+random(15));
    registro_novela.precio:=100+random(9001)/10;
  end;
end;
procedure cargar_archivo_carga(var archivo_carga: text);
var
  registro_novela: t_registro_novela;
begin
  rewrite(archivo_carga);
  leer_novela(registro_novela,true);
  while (registro_novela.codigo<>codigo_salida) do
  begin
    with registro_novela do
    begin
      writeln(archivo_carga,codigo,' ',precio:0:2,' ',genero);
      writeln(archivo_carga,nombre);
    end;
    leer_novela(registro_novela,true);
  end;
  close(archivo_carga);
end;
procedure cargar_archivo_novelas(var archivo_novelas: t_archivo_novelas; var archivo_carga: text);
var
  registro_novela: t_registro_novela;
begin
  rewrite(archivo_novelas);
  reset(archivo_carga);
  while (not eof(archivo_carga)) do
  begin
    with registro_novela do
    begin
      readln(archivo_carga,codigo,precio,genero); genero:=trim(genero);
      readln(archivo_carga,nombre);
    end;
    write(archivo_novelas,registro_novela);
  end;
  close(archivo_novelas);
  close(archivo_carga);
  textcolor(green); writeln('El archivo binario de novelas fue creado y cargado con éxito');
end;
function control_unicidad(var archivo_novelas: t_archivo_novelas; codigo: int16): boolean;
var
  registro_novela: t_registro_novela;
  ok: boolean;
begin
  ok:=false;
  while ((not eof(archivo_novelas)) and (ok=false)) do
  begin
    read(archivo_novelas,registro_novela);
    if (registro_novela.codigo=codigo) then
      ok:=true;
  end;
  control_unicidad:=ok;
end;
procedure agregar_novela(var archivo_novelas: t_archivo_novelas);
var
  registro_novela: t_registro_novela;
  novelas: int16;
begin
  novelas:=0;
  reset(archivo_novelas);
  leer_novela(registro_novela,true);
  while (registro_novela.codigo<>codigo_salida) do
  begin
    if (control_unicidad(archivo_novelas,registro_novela.codigo)=false) then
    begin
      seek(archivo_novelas,filesize(archivo_novelas));
      write(archivo_novelas,registro_novela);
      novelas:=novelas+1;
    end;
    leer_novela(registro_novela,true);
  end;
  close(archivo_novelas);
  textcolor(green); write('Se han agregado '); textcolor(yellow); write(novelas); textcolor(green); writeln(' novelas al final del archivo');
end;
procedure modificar_novela(var archivo_novelas: t_archivo_novelas);
var
  registro_novela: t_registro_novela;
  codigo: int16;
  ok: boolean;
begin
  codigo:=1+random(1000);
  ok:=false;
  reset(archivo_novelas);
  while ((not eof(archivo_novelas)) and (ok=false)) do
  begin
    read(archivo_novelas,registro_novela);
    if (registro_novela.codigo=codigo) then
    begin
      leer_novela(registro_novela,false);
      seek(archivo_novelas,filepos(archivo_novelas)-1);
      write(archivo_novelas,registro_novela);
      ok:=true;
    end;
  end;
  close(archivo_novelas);
  if (ok=true) then
  begin
    textcolor(green); write('Se ha modificado la novela con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('No se ha encontrado la novela con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end;
end;
procedure exportar_archivo_txt(var archivo_novelas: t_archivo_novelas);
var
  registro_novela: t_registro_novela;
  archivo_txt: text;
begin
  reset(archivo_novelas);
  assign(archivo_txt,'E7_novelas2.txt'); rewrite(archivo_txt);
  while (not eof(archivo_novelas)) do
  begin
    read(archivo_novelas,registro_novela);
    with registro_novela do
    begin
      writeln(archivo_txt,codigo,' ',precio:0:2,' ',genero);
      writeln(archivo_txt,nombre);
    end;
  end;
  close(archivo_novelas);
  close(archivo_txt);
  textcolor(green); write('Se ha exportado el archivo creado en el inciso (a) a un archivo de texto denominado '); textcolor(yellow); write('"novelas2.txt"'); textcolor(green); writeln(' con todas las novelas del mismo');
end;
procedure leer_opcion(var opcion: int8);
begin
  textcolor(red); writeln('MENÚ DE OPCIONES');
  textcolor(yellow); write('OPCIÓN 1: '); textcolor(green); writeln('Crear un archivo binario a partir de la información almacenada en un archivo de texto denominado "novelas.txt"');
  textcolor(yellow); write('OPCIÓN 2: '); textcolor(green); writeln('Añadir una o más novelas al final del archivo con sus datos ingresados por teclado');
  textcolor(yellow); write('OPCIÓN 3: '); textcolor(green); writeln('Modificar una novela existente');
  textcolor(yellow); write('OPCIÓN 4: '); textcolor(green); writeln('Exportar el archivo creado en el inciso (a) a un archivo de texto denominado "novelas2.txt" con todas las novelas del mismo');
  textcolor(yellow); write('OPCIÓN 0: '); textcolor(green); writeln('Salir del menú de opciones');
  textcolor(green); write('Introducir opción elegida: '); textcolor(yellow); readln(opcion);
  writeln();
end;
procedure menu_opciones(var archivo_novelas: t_archivo_novelas; var archivo_carga: text);
var
  opcion: int8;
begin
  leer_opcion(opcion);
  while (opcion<>opcion_salida) do
  begin
    case opcion of
      1: cargar_archivo_novelas(archivo_novelas,archivo_carga);
      2: agregar_novela(archivo_novelas);
      3: modificar_novela(archivo_novelas);
      4: exportar_archivo_txt(archivo_novelas);
    else
        textcolor(green); writeln('La opción ingresada no corresponde a ninguna del menú de opciones');
    end;
    writeln();
    leer_opcion(opcion);
  end;
end;
var
  archivo_novelas: t_archivo_novelas;
  archivo_carga: text;
begin
  randomize;
  assign(archivo_carga,'E7_novelas1.txt');
  assign(archivo_novelas,'E7_novelas2');
  cargar_archivo_carga(archivo_carga);
  menu_opciones(archivo_novelas,archivo_carga);
end.