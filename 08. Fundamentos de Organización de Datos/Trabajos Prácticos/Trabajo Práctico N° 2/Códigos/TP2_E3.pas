{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 3}
{A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas alfabetizadas y total de encuestados.
Se reciben dos archivos detalle provenientes de dos agencias de censo diferentes.
Dichos archivos contienen: nombre de la provincia, código de localidad, cantidad de alfabetizados y cantidad de encuestados.
Se pide realizar los módulos necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
Nota: Los archivos están ordenados por nombre de provincia y, en los archivos detalle, pueden venir 0, 1 o más registros por cada provincia.}

program TP2_E3;
{$codepage UTF8}
uses crt, sysutils;
const
  nombre_salida='ZZZ';
type
  t_string50=string[50];
  t_registro_provincia=record
    nombre: t_string50;
    alfabetizados: int16;
    encuestados: int16;
  end;
  t_registro_localidad=record
    nombre: t_string50;
    codigo: int16;
    alfabetizados: int16;
    encuestados: int16;
  end;
  t_archivo_maestro=file of t_registro_provincia;
  t_archivo_detalle=file of t_registro_localidad;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga: text);
var
  registro_provincia: t_registro_provincia;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga);
  while (not eof(archivo_carga)) do
    with registro_provincia do
    begin
      readln(archivo_carga,alfabetizados,encuestados,nombre); nombre:=trim(nombre);
      write(archivo_maestro,registro_provincia);
    end;
  close(archivo_maestro);
  close(archivo_carga);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle; var archivo_carga: text);
var
  registro_localidad: t_registro_localidad;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga);
  while (not eof(archivo_carga)) do
    with registro_localidad do
    begin
      readln(archivo_carga,codigo,alfabetizados,encuestados,nombre); nombre:=trim(nombre);
      write(archivo_detalle,registro_localidad);
    end;
  close(archivo_detalle);
  close(archivo_carga);
end;
procedure imprimir_registro_provincia(registro_provincia: t_registro_provincia);
begin
  textcolor(green); write('Provincia: '); textcolor(yellow); write(registro_provincia.nombre);
  textcolor(green); write('; Alfabetizados: '); textcolor(yellow); write(registro_provincia.alfabetizados);
  textcolor(green); write('; Encuestados: '); textcolor(yellow); writeln(registro_provincia.encuestados);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_provincia: t_registro_provincia;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_provincia);
    imprimir_registro_provincia(registro_provincia);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_localidad(registro_localidad: t_registro_localidad);
begin
  textcolor(green); write('Provincia: '); textcolor(yellow); write(registro_localidad.nombre);
  textcolor(green); write('; Código de localidad: '); textcolor(yellow); write(registro_localidad.codigo);
  textcolor(green); write('; Alfabetizados: '); textcolor(yellow); write(registro_localidad.alfabetizados);
  textcolor(green); write('; Encuestados: '); textcolor(yellow); writeln(registro_localidad.encuestados);
end;
procedure imprimir_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  registro_localidad: t_registro_localidad;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_localidad);
    imprimir_registro_localidad(registro_localidad);
  end;
  close(archivo_detalle);
end;
procedure leer_localidad(var archivo_detalle: t_archivo_detalle; var registro_localidad: t_registro_localidad);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_localidad)
  else
    registro_localidad.nombre:=nombre_salida;
end;
procedure minimo(var archivo_detalle1, archivo_detalle2: t_archivo_detalle; var registro_localidad1, registro_localidad2, min: t_registro_localidad);
begin
  if (registro_localidad1.nombre<=registro_localidad2.nombre) then
  begin
    min:=registro_localidad1;
    leer_localidad(archivo_detalle1,registro_localidad1);
  end
  else
  begin
    min:=registro_localidad2;
    leer_localidad(archivo_detalle2,registro_localidad2);
  end;
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_detalle1, archivo_detalle2: t_archivo_detalle);
var
  registro_provincia: t_registro_provincia;
  registro_localidad1, registro_localidad2, min: t_registro_localidad;
begin
  reset(archivo_maestro);
  reset(archivo_detalle1); reset(archivo_detalle2);
  leer_localidad(archivo_detalle1,registro_localidad1);
  leer_localidad(archivo_detalle2,registro_localidad2);
  minimo(archivo_detalle1,archivo_detalle2,registro_localidad1,registro_localidad2,min);
  while (min.nombre<>nombre_salida) do
  begin
    read(archivo_maestro,registro_provincia);
    while (registro_provincia.nombre<>min.nombre) do
      read(archivo_maestro,registro_provincia);
    while (registro_provincia.nombre=min.nombre) do
    begin
      registro_provincia.alfabetizados:=registro_provincia.alfabetizados+min.alfabetizados;
      registro_provincia.encuestados:=registro_provincia.encuestados+min.encuestados;
      minimo(archivo_detalle1,archivo_detalle2,registro_localidad1,registro_localidad2,min);
    end;
    seek(archivo_maestro,filepos(archivo_maestro)-1);
    write(archivo_maestro,registro_provincia);
  end;
  close(archivo_maestro);
  close(archivo_detalle1); close(archivo_detalle2);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_detalle1, archivo_detalle2: t_archivo_detalle;
  archivo_carga_maestro, archivo_carga_detalle1, archivo_carga_detalle2: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E3_provinciasMaestro'); assign(archivo_carga_maestro,'E3_provinciasMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE 1:'); writeln();
  assign(archivo_detalle1,'E3_localidadesDetalle1'); assign(archivo_carga_detalle1,'E3_localidadesDetalle1.txt');
  cargar_archivo_detalle(archivo_detalle1,archivo_carga_detalle1);
  imprimir_archivo_detalle(archivo_detalle1);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE 2:'); writeln();
  assign(archivo_detalle2,'E3_localidadesDetalle2'); assign(archivo_carga_detalle2,'E3_localidadesDetalle2.txt');
  cargar_archivo_detalle(archivo_detalle2,archivo_carga_detalle2);
  imprimir_archivo_detalle(archivo_detalle2);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  actualizar_archivo_maestro(archivo_maestro,archivo_detalle1,archivo_detalle2);
  imprimir_archivo_maestro(archivo_maestro);
end.