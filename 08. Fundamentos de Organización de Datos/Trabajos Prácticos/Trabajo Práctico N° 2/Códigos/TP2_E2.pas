{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 2}
{El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos que vende.
Para ello, genera un archivo maestro donde figuran todos los productos que comercializa.
De cada producto, se maneja la siguiente información: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente, se genera un archivo detalle donde se registran todas las ventas de productos realizadas.
De cada venta, se registran: código de producto y cantidad de unidades vendidas.
Se pide realizar un programa con opciones para:
(a) Actualizar el archivo maestro con el archivo detalle, sabiendo que:
•	Ambos archivos están ordenados por código de producto.
•	Cada registro del maestro puede ser actualizado por 0, 1 o más registros del archivo detalle.
•	El archivo detalle sólo contiene registros que están en el archivo maestro.
(b) Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.}

program TP2_E2;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=999;
  opcion_salida=0;
type
  t_string20=string[20];
  t_registro_producto=record
    codigo: int16;
    nombre: t_string20;
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
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_producto: t_registro_producto;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_producto do
    begin
      readln(archivo_carga_maestro,codigo,precio,stock_actual,stock_minimo,nombre); nombre:=trim(nombre);
      write(archivo_maestro,registro_producto);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
  textcolor(green); writeln('El archivo binario maestro fue creado y cargado con éxito');
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
  textcolor(green); writeln('El archivo binario detalle fue creado y cargado con éxito');
end;
procedure imprimir_registro_producto(registro_producto: t_registro_producto);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_producto.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_producto.nombre);
  textcolor(green); write('; Precio: '); textcolor(yellow); write(registro_producto.precio:0:2);
  textcolor(green); write('; Stock actual: '); textcolor(yellow); write(registro_producto.stock_actual);
  textcolor(green); write('; Stock mínimo: '); textcolor(yellow); writeln(registro_producto.stock_minimo);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_producto: t_registro_producto;
begin
  reset(archivo_maestro);
  textcolor(green); writeln('Los productos del archivo maestro son: ');
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
  textcolor(green); writeln('Las ventas del archivo detalle son: ');
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
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_detalle: t_archivo_detalle);
var
  registro_producto: t_registro_producto;
  registro_venta: t_registro_venta;
begin
  reset(archivo_maestro);
  reset(archivo_detalle);
  leer_venta(archivo_detalle,registro_venta);
  while (registro_venta.codigo<>codigo_salida) do
  begin
    read(archivo_maestro,registro_producto);
    while (registro_producto.codigo<>registro_venta.codigo) do
      read(archivo_maestro,registro_producto);
    while (registro_producto.codigo=registro_venta.codigo) do
    begin
      if (registro_venta.cantidad_vendida>=registro_producto.stock_actual) then
        registro_producto.stock_actual:=0 
      else
        registro_producto.stock_actual:=registro_producto.stock_actual-registro_venta.cantidad_vendida;
      leer_venta(archivo_detalle,registro_venta);
    end;
    seek(archivo_maestro,filepos(archivo_maestro)-1);
    write(archivo_maestro,registro_producto);
  end;
  close(archivo_maestro);
  close(archivo_detalle);
  textcolor(green); writeln('El archivo maestro fue actualizado con éxito');
end;
procedure exportar_archivo_txt(var archivo_maestro: t_archivo_maestro);
var
  registro_producto: t_registro_producto;
  archivo_txt: text;
begin
  reset(archivo_maestro);
  assign(archivo_txt,'E2_stock_minimo.txt'); rewrite(archivo_txt);
  textcolor(green); writeln('Los productos cuyo stock actual está por debajo del stock mínimo son: ');
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_producto);
    if (registro_producto.stock_actual<registro_producto.stock_minimo) then
    begin
      imprimir_registro_producto(registro_producto);
      with registro_producto do
        writeln(archivo_txt,codigo,' ',nombre,' ',precio:0:2,' ',stock_actual,' ',stock_minimo);
    end;
  end;
  close(archivo_maestro);
  close(archivo_txt);
  textcolor(green); writeln('El archivo de texto "stock_minimo.txt" fue creado y cargado con éxito');
end;
procedure leer_opcion(var opcion: int8);
begin
  textcolor(red); writeln('MENÚ DE OPCIONES');
  textcolor(yellow); write('OPCIÓN 1: '); textcolor(green); writeln('Crear archivos de registros ordenados de productos y cargarlos con datos ingresados desde archivos de texto');
  textcolor(yellow); write('OPCIÓN 2: '); textcolor(green); writeln('Listar en pantalla los datos de los productos del archivo maestro');
  textcolor(yellow); write('OPCIÓN 3: '); textcolor(green); writeln('Listar en pantalla los datos de los productos del archivo detalle');
  textcolor(yellow); write('OPCIÓN 4: '); textcolor(green); writeln('Actualizar el archivo maestro con el archivo detalle');
  textcolor(yellow); write('OPCIÓN 5: '); textcolor(green); writeln('Listar en un archivo de texto llamado "stock_minimo.txt" aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido');
  textcolor(yellow); write('OPCIÓN 0: '); textcolor(green); writeln('Salir del menú de opciones');
  textcolor(green); write('Introducir opción elegida: '); textcolor(yellow); readln(opcion);
  writeln();
end;
procedure menu_opciones(var archivo_maestro: t_archivo_maestro; var archivo_detalle: t_archivo_detalle; var archivo_carga_maestro, archivo_carga_detalle: text);
var
  opcion: int8;
begin
  leer_opcion(opcion);
  while (opcion<>opcion_salida) do
  begin
    case opcion of
      1:
      begin
        cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
        cargar_archivo_detalle(archivo_detalle,archivo_carga_detalle);
      end;
      2: imprimir_archivo_maestro(archivo_maestro);
      3: imprimir_archivo_detalle(archivo_detalle);
      4: actualizar_archivo_maestro(archivo_maestro,archivo_detalle);
      5: exportar_archivo_txt(archivo_maestro);
    else
        textcolor(green); writeln('La opción ingresada no corresponde a ninguna de las mostradas en el menú de opciones');
    end;
    writeln();
    leer_opcion(opcion);
  end;
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_detalle: t_archivo_detalle;
  archivo_carga_maestro, archivo_carga_detalle: text;
begin
  assign(archivo_maestro,'E2_productosMaestro'); assign(archivo_carga_maestro,'E2_productosMaestro.txt');
  assign(archivo_detalle,'E2_ventasDetalle'); assign(archivo_carga_detalle,'E2_ventasDetalle.txt');
  menu_opciones(archivo_maestro,archivo_detalle,archivo_carga_maestro,archivo_carga_detalle);
end.