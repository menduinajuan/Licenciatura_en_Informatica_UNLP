{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 17}
{Una concesionaria de motos de la Ciudad de Chascomús posee un archivo con información de las motos que posee a la venta.
De cada moto, se registra: código, nombre, descripción, modelo, marca y stock actual.
Mensualmente, se reciben 10 archivos detalles con información de las ventas de cada uno de los 10 empleados que trabajan.
De cada archivo detalle, se dispone de la siguiente información: código de moto, precio y fecha de la venta.
Se debe realizar un proceso que actualice el stock del archivo maestro desde los archivos detalles. Además, se debe informar cuál fue la moto más vendida.
Nota: Todos los archivos están ordenados por código de la moto y el archivo maestro debe ser recorrido sólo una vez y en forma simultánea con los detalles.}

program TP2_E17;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=3; // detalles_total=10;
  codigo_salida=999;
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_moto=record
    codigo: int16;
    nombre: t_string20;
    descripcion: t_string20;
    modelo: t_string20;
    marca: t_string20;
    stock: int16;
  end;
  t_registro_venta=record
    codigo: int16;
    precio: real;
    fecha: t_string20;
  end;
  t_archivo_maestro=file of t_registro_moto;
  t_archivo_detalle=file of t_registro_venta;
  t_vector_ventas=array[t_detalle] of t_registro_venta;
  t_vector_detalles=array[t_detalle] of t_archivo_detalle;
  t_vector_carga_detalles=array[t_detalle] of text;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_moto: t_registro_moto;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_moto do
    begin
      readln(archivo_carga_maestro,codigo,stock,nombre); nombre:=trim(nombre);
      readln(archivo_carga_maestro,descripcion); descripcion:=trim(descripcion);
      readln(archivo_carga_maestro,modelo); modelo:=trim(modelo);
      readln(archivo_carga_maestro,marca); marca:=trim(marca);
      write(archivo_maestro,registro_moto);
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
      readln(archivo_carga_detalle,codigo,precio,fecha); fecha:=trim(fecha);
      write(archivo_detalle,registro_venta);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_moto(registro_moto: t_registro_moto);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_moto.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_moto.nombre);
  textcolor(green); write('; Descripción: '); textcolor(yellow); write(registro_moto.descripcion);
  textcolor(green); write('; Modelo: '); textcolor(yellow); write(registro_moto.modelo);
  textcolor(green); write('; Marca: '); textcolor(yellow); write(registro_moto.marca);
  textcolor(green); write('; Stock: '); textcolor(yellow); writeln(registro_moto.stock);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_moto: t_registro_moto;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_moto);
    imprimir_registro_moto(registro_moto);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_venta.codigo);
  textcolor(green); write('; Precio: $'); textcolor(yellow); write(registro_venta.precio:0:2);
  textcolor(green); write('; Fecha: '); textcolor(yellow); writeln(registro_venta.fecha);
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
procedure actualizar_maximo(ventas: int16; registro_moto: t_registro_moto; var ventas_max: int16; var registro_moto_max: t_registro_moto);
begin
  if (ventas>ventas_max) then
  begin
    ventas_max:=ventas;
    registro_moto_max:=registro_moto;
  end;
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles: t_vector_detalles);
var
  registro_moto, registro_moto_max: t_registro_moto;
  min: t_registro_venta;
  vector_ventas: t_vector_ventas;
  i: t_detalle;
  ventas, ventas_max: int16;
begin
  ventas_max:=low(int16);
  reset(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_venta(vector_detalles[i],vector_ventas[i]);
  end;
  minimo(vector_detalles,vector_ventas,min);
  while (min.codigo<>codigo_salida) do
  begin
    ventas:=0;
    read(archivo_maestro,registro_moto);
    while (registro_moto.codigo<>min.codigo) do
      read(archivo_maestro,registro_moto);
    while (registro_moto.codigo=min.codigo) do
    begin
      ventas:=ventas+1;
      minimo(vector_detalles,vector_ventas,min);
    end;
    registro_moto.stock:=registro_moto.stock-ventas;
    seek(archivo_maestro,filepos(archivo_maestro)-1);
    write(archivo_maestro,registro_moto);
    actualizar_maximo(ventas,registro_moto,ventas_max,registro_moto_max);
  end;
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
  textcolor(green); write('La moto más vendida fue la '); textcolor(red); write(registro_moto_max.marca); textcolor(green); write(' '); textcolor(red); write(registro_moto_max.modelo); textcolor(green); write(', con un total de '); textcolor(red); write(ventas_max); textcolor(green); writeln(' ventas');
  writeln();
end;
var
  vector_detalles: t_vector_detalles;
  vector_carga_detalles: t_vector_carga_detalles;
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
  i: t_detalle;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E17_motosMaestro'); assign(archivo_carga_maestro,'E17_motosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E17_ventasDetalle'+intToStr(i)); assign(vector_carga_detalles[i],'E17_ventasDetalle'+intToStr(i)+'.txt');
    cargar_archivo_detalle(vector_detalles[i],vector_carga_detalles[i]);
    imprimir_archivo_detalle(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  actualizar_archivo_maestro(archivo_maestro,vector_detalles);
  imprimir_archivo_maestro(archivo_maestro);
end.