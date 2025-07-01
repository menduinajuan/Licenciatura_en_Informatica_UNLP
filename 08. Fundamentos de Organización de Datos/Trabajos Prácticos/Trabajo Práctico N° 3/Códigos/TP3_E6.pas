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
  codigo_salida=-1;
  stock_baja=-1;
type
  t_string20=string[20];
  t_registro_prenda=record
    codigo: int16;
    descripcion: t_string20;
    colores: t_string20;
    tipo: t_string20;
    stock: int16;
    precio: real;
  end;
  t_archivo_maestro=file of t_registro_prenda;
  t_archivo_detalle=file of int16;
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
procedure leer_prenda(var registro_prenda: t_registro_prenda);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_prenda.codigo:=codigo_salida
  else
    registro_prenda.codigo:=1+random(1000);
  if (registro_prenda.codigo<>codigo_salida) then
  begin
    registro_prenda.descripcion:=random_string(10+random(10));
    registro_prenda.colores:=random_string(5+random(6));
    registro_prenda.tipo:=random_string(5+random(6));
    registro_prenda.stock:=1+random(100);
    registro_prenda.precio:=1+random(100);
  end;
end;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_prenda: t_registro_prenda;
begin
  rewrite(archivo_maestro);
  leer_prenda(registro_prenda);
  while (registro_prenda.codigo<>codigo_salida) do
  begin
    write(archivo_maestro,registro_prenda);
    leer_prenda(registro_prenda);
  end;
  close(archivo_maestro);
end;
procedure leer_codigo(var codigo: int16);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    codigo:=codigo_salida
  else
    codigo:=1+random(1000);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  codigo: int16;
begin
  rewrite(archivo_detalle);
  leer_codigo(codigo);
  while (codigo<>codigo_salida) do
  begin
    write(archivo_detalle,codigo);
    leer_codigo(codigo);
  end;
  close(archivo_detalle);
end;
procedure imprimir_registro_prenda(registro_prenda: t_registro_prenda);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_prenda.codigo);
  textcolor(green); write('; Descripción: '); textcolor(yellow); write(registro_prenda.descripcion);
  textcolor(green); write('; Colores: '); textcolor(yellow); write(registro_prenda.colores);
  textcolor(green); write('; Tipo: '); textcolor(yellow); write(registro_prenda.tipo);
  textcolor(green); write('; Stock: '); textcolor(yellow); write(registro_prenda.stock);
  textcolor(green); write('; Precio: $'); textcolor(yellow); writeln(registro_prenda.precio:0:2);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_prenda: t_registro_prenda;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_prenda);
    imprimir_registro_prenda(registro_prenda);
  end;
  textcolor(green); write('Tamaño del archivo maestro: '); textcolor(yellow); writeln(filesize(archivo_maestro));
  close(archivo_maestro);
end;
procedure imprimir_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  codigo: int16;
begin
  reset(archivo_detalle);
  textcolor(green); write('Códigos: ');
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,codigo);
    textcolor(yellow); write(codigo,' ');
  end;
  close(archivo_detalle);
  writeln();
end;
procedure bajas_logicas(var archivo_maestro: t_archivo_maestro; var archivo_detalle: t_archivo_detalle);
var
  registro_prenda: t_registro_prenda;
  codigo: int16;
begin
  reset(archivo_maestro);
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,codigo);
    seek(archivo_maestro,0);
    read(archivo_maestro,registro_prenda);
    while ((not eof(archivo_maestro)) and (registro_prenda.codigo<>codigo)) do
      read(archivo_maestro,registro_prenda);
    if (registro_prenda.codigo=codigo) then
    begin
      seek(archivo_maestro,filepos(archivo_maestro)-1);
      registro_prenda.stock:=stock_baja;
      write(archivo_maestro,registro_prenda);
    end;
  end;
  close(archivo_maestro);
  close(archivo_detalle);
end;
procedure bajas_fisicas(var archivo_maestro: t_archivo_maestro);
var
  registro_prenda: t_registro_prenda;
  archivo_maestro_aux: t_archivo_maestro;
begin
  reset(archivo_maestro);
  assign(archivo_maestro_aux,'E6_prendasMaestroAux'); rewrite(archivo_maestro_aux);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_prenda);
    if (registro_prenda.stock>0) then
      write(archivo_maestro_aux,registro_prenda);
  end;
  close(archivo_maestro);
  close(archivo_maestro_aux);
  erase(archivo_maestro);
  rename(archivo_maestro_aux,'E6_prendasMaestro');
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_detalle: t_archivo_detalle;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E6_prendasMaestro');
  cargar_archivo_maestro(archivo_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE:'); writeln();
  assign(archivo_detalle,'E6_bajasDetalle');
  cargar_archivo_detalle(archivo_detalle);
  imprimir_archivo_detalle(archivo_detalle);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO CON BAJAS LÓGICAS:'); writeln();
  bajas_logicas(archivo_maestro,archivo_detalle);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO CON BAJAS FÍSICAS:'); writeln();
  bajas_fisicas(archivo_maestro);
  imprimir_archivo_maestro(archivo_maestro);
end.