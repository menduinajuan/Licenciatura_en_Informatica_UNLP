{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 4}
{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto, se almacena: código del producto, nombre, descripción, stock disponible, stock mínimo y precio del producto.
Se recibe, diariamente, un archivo detalle de cada una de las 30 sucursales de la cadena.
Se debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo maestro.
La información que se recibe en los detalles es: código de producto y cantidad vendida.
Además, se deberá informar en un archivo de texto: nombre de producto, descripción, stock disponible y precio de aquellos productos que tengan stock disponible por debajo del stock mínimo.
Pensar alternativas sobre realizar el informe en el mismo procedimiento de actualización o realizarlo en un procedimiento separado (analizar ventajas/desventajas en cada caso).
Nota: Todos los archivos se encuentran ordenados por código de productos. En cada detalle, puede venir 0 o N registros de un determinado producto.}

program TP2_E4;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=3; // detalles_total=30;
  codigo_salida=999;
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_producto=record
    codigo: int16;
    nombre: t_string20;
    descripcion: t_string20;
    stock_disponible: int16;
    stock_minimo: int16;
    precio: real;
  end;
  t_registro_venta=record
    codigo: int16;
    cantidad_vendida: int16;
  end;
  t_archivo_maestro=file of t_registro_producto;
  t_archivo_detalle=file of t_registro_venta;
  t_vector_ventas=array[t_detalle] of t_registro_venta;
  t_vector_detalles=array[t_detalle] of t_archivo_detalle;
  t_vector_carga_detalles=array[t_detalle] of text;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_producto: t_registro_producto;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_producto do
    begin
      readln(archivo_carga_maestro,codigo,stock_disponible,stock_minimo,precio,nombre); nombre:=trim(nombre);
      readln(archivo_carga_maestro,descripcion); descripcion:=trim(descripcion);
      write(archivo_maestro,registro_producto);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle; var archivo_carga_detalle: text);
var
  registro_venta: t_registro_venta;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga_detalle);
  while (not eof(archivo_carga_detalle)) do
    with registro_venta do
    begin
      readln(archivo_carga_detalle,codigo,cantidad_vendida);
      write(archivo_detalle,registro_venta);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_producto(registro_producto: t_registro_producto);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_producto.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_producto.nombre);
  textcolor(green); write('; Descripción: '); textcolor(yellow); write(registro_producto.descripcion);
  textcolor(green); write('; Stock disponible: '); textcolor(yellow); write(registro_producto.stock_disponible);
  textcolor(green); write('; Stock mínimo: '); textcolor(yellow); write(registro_producto.stock_minimo);
  textcolor(green); write('; Precio: '); textcolor(yellow); writeln(registro_producto.precio:0:2);
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
procedure leer_venta(var archivo_detalle: t_archivo_detalle; var registro_venta: t_registro_venta);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_venta)
  else
    registro_venta.codigo:=codigo_salida;
end;
procedure minimo(var vector_detalles: t_vector_detalles; var vector_ventas: t_vector_ventas; var min: t_registro_venta);
var
  i, pos: t_detalle;
begin
  min.codigo:=codigo_salida;
  for i:= 1 to detalles_total do
    if (vector_ventas[i].codigo<min.codigo) then
    begin
      min:=vector_ventas[i];
      pos:=i;
    end;
  if (min.codigo<codigo_salida) then
    leer_venta(vector_detalles[pos],vector_ventas[pos]);
end;
procedure exportar_archivo_txt(var archivo_maestro: t_archivo_maestro);
var
  registro_producto: t_registro_producto;
  archivo_txt: text;
begin
  reset(archivo_maestro);
  assign(archivo_txt,'E4_stock_minimo.txt'); rewrite(archivo_txt);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_producto);
    if (registro_producto.stock_disponible<registro_producto.stock_minimo) then
      with registro_producto do
        writeln(archivo_txt,nombre,' ',descripcion,' ',stock_disponible,' ',precio:0:2);
  end;
  close(archivo_txt);
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles: t_vector_detalles);
var
  registro_producto: t_registro_producto;
  min: t_registro_venta;
  vector_ventas: t_vector_ventas;
  i: t_detalle;
begin
  reset(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_venta(vector_detalles[i],vector_ventas[i]);
  end;
  minimo(vector_detalles,vector_ventas,min);
  while (min.codigo<>codigo_salida) do
  begin
    read(archivo_maestro,registro_producto);
    while (registro_producto.codigo<>min.codigo) do
      read(archivo_maestro,registro_producto);
    while (registro_producto.codigo=min.codigo) do
    begin
      if (min.cantidad_vendida>=registro_producto.stock_disponible) then
        registro_producto.stock_disponible:=0 
      else
        registro_producto.stock_disponible:=registro_producto.stock_disponible-min.cantidad_vendida;
      minimo(vector_detalles,vector_ventas,min);
    end;
    seek(archivo_maestro,filepos(archivo_maestro)-1);
    write(archivo_maestro,registro_producto);
  end;
  exportar_archivo_txt(archivo_maestro);
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
end;
var
  vector_detalles: t_vector_detalles;
  vector_carga_detalles: t_vector_carga_detalles;
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
  i: t_detalle;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E4_productosMaestro'); assign(archivo_carga_maestro,'E4_productosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E4_ventasDetalle'+intToStr(i)); assign(vector_carga_detalles[i],'E4_ventasDetalle'+intToStr(i)+'.txt');
    cargar_archivo_detalle(vector_detalles[i],vector_carga_detalles[i]);
    imprimir_archivo_detalle(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  actualizar_archivo_maestro(archivo_maestro,vector_detalles);
  imprimir_archivo_maestro(archivo_maestro);
end.