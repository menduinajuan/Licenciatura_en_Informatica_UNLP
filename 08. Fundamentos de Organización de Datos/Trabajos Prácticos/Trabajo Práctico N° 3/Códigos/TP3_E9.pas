{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 9}
{El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos que vende.
Para ello, genera un archivo maestro donde figuran todos los productos que comercializa.
De cada producto, se maneja la siguiente información: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente, se genera un archivo detalle donde se registran todas las ventas de productos realizadas.
De cada venta, se registran: código de producto y cantidad de unidades vendidas. Resolver los siguientes puntos:
(a) Se pide realizar un procedimiento que actualice el archivo maestro con el archivo detalle, teniendo en cuenta que:
•	Los archivos no están ordenados por ningún criterio.
•	Cada registro del maestro puede ser actualizado por 0, 1 o más registros del archivo detalle.
(b) ¿Qué cambios se realizarían en el procedimiento del inciso anterior si se sabe que cada registro del archivo maestro puede ser actualizado por 0 o 1 registro del archivo detalle?}

program TP3_E9;
{$codepage UTF8}
uses crt;
const
  codigo_salida=-1;
type
  t_string10=string[10];
  t_registro_producto=record
    codigo: int16;
    nombre: t_string10;
    precio: real;
    stock_actual: int16;
    stock_minimo: int16;
  end;
  t_registro_venta=record
    codigo: int16;
    cantidad_vendida: int16;
  end;
  t_archivo_maestro=file of t_registro_producto;
  t_archivo_detalle=file of t_registro_venta;
function random_string(length: int8): t_string10;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_producto(var registro_producto: t_registro_producto);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_producto.codigo:=codigo_salida
  else
    registro_producto.codigo:=1+random(1000);
  if (registro_producto.codigo<>codigo_salida) then
  begin
    registro_producto.nombre:=random_string(5+random(5));
    registro_producto.precio:=1+random(100);
    registro_producto.stock_actual:=10+random(91);
    registro_producto.stock_minimo:=1+random(50);
  end;
end;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_producto: t_registro_producto;
begin
  rewrite(archivo_maestro);
  leer_producto(registro_producto);
  while (registro_producto.codigo<>codigo_salida) do
  begin
    write(archivo_maestro,registro_producto);
    leer_producto(registro_producto);
  end;
  close(archivo_maestro);
end;
procedure leer_venta(var registro_venta: t_registro_venta);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_venta.codigo:=codigo_salida
  else
    registro_venta.codigo:=1+random(1000);
  if (registro_venta.codigo<>codigo_salida) then
    registro_venta.cantidad_vendida:=1+random(10);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  registro_venta: t_registro_venta;
begin
  rewrite(archivo_detalle);
  leer_venta(registro_venta);
  while (registro_venta.codigo<>codigo_salida) do
  begin
    write(archivo_detalle,registro_venta);
    leer_venta(registro_venta);
  end;
  close(archivo_detalle);
end;
procedure imprimir_registro_producto(registro_producto: t_registro_producto);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_producto.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_producto.nombre);
  textcolor(green); write('; Precio: $'); textcolor(yellow); write(registro_producto.precio:0:2);
  textcolor(green); write('; Stock actual: '); textcolor(yellow); write(registro_producto.stock_actual);
  textcolor(green); write('; Stock mínimo: '); textcolor(yellow); writeln(registro_producto.stock_minimo);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_producto: t_registro_producto;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_producto);
    imprimir_registro_producto(registro_producto);
  end;
  textcolor(green); write('Tamaño del archivo maestro: '); textcolor(yellow); writeln(filesize(archivo_maestro));
  close(archivo_maestro);
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_venta.codigo);
  textcolor(green); write('; Cantidad vendida: '); textcolor(yellow); writeln(registro_venta.cantidad_vendida);
end;
procedure imprimir_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  registro_venta: t_registro_venta;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_venta);
    imprimir_registro_venta(registro_venta);
  end;
  close(archivo_detalle);
end;
procedure actualizar1_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_detalle: t_archivo_detalle);
var
  registro_producto: t_registro_producto;
  registro_venta: t_registro_venta;
  ventas: int16;
begin
  reset(archivo_maestro);
  reset(archivo_detalle);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_producto);
    ventas:=0;
    seek(archivo_detalle,0);
    while (not eof(archivo_detalle)) do
    begin
      read(archivo_detalle,registro_venta);
      if (registro_venta.codigo=registro_producto.codigo) then
        ventas:=ventas+registro_venta.cantidad_vendida;
    end;
    if (ventas>0) then
    begin
      registro_producto.stock_actual:=registro_producto.stock_actual-ventas;
      seek(archivo_maestro,filepos(archivo_maestro)-1);
      write(archivo_maestro,registro_producto);
    end;
  end;
  close(archivo_maestro);
  close(archivo_detalle);
end;
procedure actualizar2_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_detalle: t_archivo_detalle);
var
  registro_producto: t_registro_producto;
  registro_venta: t_registro_venta;
begin
  reset(archivo_maestro);
  reset(archivo_detalle);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_producto);
    seek(archivo_detalle,0);
    read(archivo_detalle,registro_venta);
    while ((not eof(archivo_detalle)) and (registro_venta.codigo<>registro_producto.codigo)) do
      read(archivo_detalle,registro_venta);
    if (registro_venta.codigo=registro_producto.codigo) then
    begin
      registro_producto.stock_actual:=registro_producto.stock_actual-registro_venta.cantidad_vendida;
      seek(archivo_maestro,filepos(archivo_maestro)-1);
      write(archivo_maestro,registro_producto);
    end;
  end;
  close(archivo_maestro);
  close(archivo_detalle);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_detalle: t_archivo_detalle;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E9_productosMaestro');
  cargar_archivo_maestro(archivo_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE:'); writeln();
  assign(archivo_detalle,'E9_productosDetalle');
  cargar_archivo_detalle(archivo_detalle);
  imprimir_archivo_detalle(archivo_detalle);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO 1:'); writeln();
  actualizar1_archivo_maestro(archivo_maestro,archivo_detalle);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO 2:'); writeln();
  actualizar2_archivo_maestro(archivo_maestro,archivo_detalle);
  imprimir_archivo_maestro(archivo_maestro);
end.